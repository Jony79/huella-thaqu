import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useRef,
  useState,
  type ReactNode,
} from "react";
import { api, ApiError } from "./api";
import { db } from "./db";
import { nowIso } from "./progress";
import { topicHasGreen } from "./stages";
import type {
  Catalog,
  LikeRow,
  NoteRow,
  ProgressRow,
  StageNumber,
  Status,
  SyncPayload,
  TopicStageEval,
  User,
} from "./types";

type Session = {
  token: string;
  user: User;
};

type QueueKind = "like" | "progress" | "note";

type Store = {
  ready: boolean;
  online: boolean;
  syncing: boolean;
  session: Session | null;
  catalog: Catalog | null;
  likes: Record<string, LikeRow>;
  progress: Record<string, ProgressRow>;
  notes: Record<string, NoteRow>;
  awardedInsigniaIds: string[];
  workingInsigniaIds: string[];
  topicStageEvals: TopicStageEval[];
  closedStages: StageNumber[];
  error: string | null;
  setError: (value: string | null) => void;
  checkDni: (dni: string) => Promise<{ registered: boolean; dni: string; tipo?: "protagonista" | "educador" }>;
  register: (dni: string, alias: string, password: string) => Promise<void>;
  login: (dni: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
  syncNow: () => Promise<void>;
  toggleLike: (topicId: string) => Promise<void>;
  setStatus: (activityId: string, status: Status) => Promise<void>;
  setNote: (topicId: string, text: string) => Promise<void>;
  changePassword: (password: string) => Promise<void>;
  changeAvatar: (file: File) => Promise<void>;
};

const StoreContext = createContext<Store | null>(null);

async function persistSession(session: Session | null) {
  if (!session) {
    await db.session.delete("current");
    return;
  }
  await db.session.put({ id: "current", ...session });
}

async function applyPull(data: SyncPayload) {
  await db.likes.clear();
  await db.progress.clear();
  await db.notes.clear();
  await db.awards.clear();
  if (data.likes.length) await db.likes.bulkPut(data.likes);
  if (data.progress.length) await db.progress.bulkPut(data.progress);
  if (data.notes.length) await db.notes.bulkPut(data.notes);
  if (data.awardedInsigniaIds.length) {
    await db.awards.bulkPut(data.awardedInsigniaIds.map((areaId) => ({ areaId })));
  }
  await db.meta.put({ key: "topicStageEvals", value: data.topicStageEvals || [] });
  await db.meta.put({ key: "closedStages", value: data.closedStages || [] });
}

function mapBy<T>(rows: T[], key: keyof T) {
  return Object.fromEntries(rows.map((row) => [String(row[key]), row]));
}

export function StoreProvider({ children }: { children: ReactNode }) {
  const [ready, setReady] = useState(false);
  const [online, setOnline] = useState(() => navigator.onLine);
  const [syncing, setSyncing] = useState(false);
  const [session, setSession] = useState<Session | null>(null);
  const [catalog, setCatalog] = useState<Catalog | null>(null);
  const [likes, setLikes] = useState<Record<string, LikeRow>>({});
  const [progress, setProgress] = useState<Record<string, ProgressRow>>({});
  const [notes, setNotes] = useState<Record<string, NoteRow>>({});
  const [awardedInsigniaIds, setAwardedInsigniaIds] = useState<string[]>([]);
  const [topicStageEvals, setTopicStageEvals] = useState<TopicStageEval[]>([]);
  const [closedStages, setClosedStages] = useState<StageNumber[]>([]);
  const workingInsigniaIds: string[] = [];
  const [error, setError] = useState<string | null>(null);
  const sessionRef = useRef<Session | null>(null);
  sessionRef.current = session;

  const refreshLocal = useCallback(async () => {
    const [likeRows, progressRows, noteRows, awardRows, catalogRow, evalsMeta, closedMeta] =
      await Promise.all([
        db.likes.toArray(),
        db.progress.toArray(),
        db.notes.toArray(),
        db.awards.toArray(),
        db.catalog.get("catalog"),
        db.meta.get("topicStageEvals"),
        db.meta.get("closedStages"),
      ]);
    setLikes(mapBy(likeRows, "topicId"));
    setProgress(mapBy(progressRows, "activityId"));
    setNotes(mapBy(noteRows, "topicId"));
    setAwardedInsigniaIds(awardRows.map((row) => row.areaId));
    setTopicStageEvals((evalsMeta?.value as TopicStageEval[]) || []);
    setClosedStages((closedMeta?.value as StageNumber[]) || []);
    if (catalogRow) setCatalog(catalogRow.data);
  }, []);

  const flushQueue = useCallback(async (token: string) => {
    const queued = await db.queue.toArray();
    if (!queued.length) return;
    await api.push(token, {
      likes: queued.filter((q) => q.kind === "like").map((q) => q.payload),
      progress: queued.filter((q) => q.kind === "progress").map((q) => q.payload),
      notes: queued.filter((q) => q.kind === "note").map((q) => q.payload),
    });
    await db.queue.clear();
  }, []);

  const syncNow = useCallback(async () => {
    const current = sessionRef.current ?? (await db.session.get("current"));
    if (!current || !navigator.onLine) return;
    setSyncing(true);
    try {
      await flushQueue(current.token);
      const [nextCatalog, pulled] = await Promise.all([
        api.catalog(current.token),
        api.pull(current.token),
      ]);
      await db.catalog.put({ id: "catalog", data: nextCatalog });
      await applyPull(pulled);
      const next = { token: current.token, user: pulled.user };
      await persistSession(next);
      setCatalog(nextCatalog);
      setSession(next);
      await refreshLocal();
    } catch (err) {
      if (err instanceof ApiError && err.status === 401) {
        await persistSession(null);
        setSession(null);
      }
    } finally {
      setSyncing(false);
    }
  }, [flushQueue, refreshLocal]);

  useEffect(() => {
    const onOnline = () => setOnline(true);
    const onOffline = () => setOnline(false);
    window.addEventListener("online", onOnline);
    window.addEventListener("offline", onOffline);
    return () => {
      window.removeEventListener("online", onOnline);
      window.removeEventListener("offline", onOffline);
    };
  }, []);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const stored = await db.session.get("current");
      if (stored && !cancelled) {
        setSession({ token: stored.token, user: stored.user });
      }
      await refreshLocal();
      if (!cancelled) setReady(true);
    })();
    return () => {
      cancelled = true;
    };
  }, [refreshLocal]);

  useEffect(() => {
    if (!ready || !session?.token || !online) return;
    void syncNow();
  }, [ready, session?.token, online, syncNow]);

  useEffect(() => {
    if (!ready || !session?.token) return;
    const onVisible = () => {
      if (document.visibilityState === "visible" && navigator.onLine) {
        void syncNow();
      }
    };
    document.addEventListener("visibilitychange", onVisible);
    return () => document.removeEventListener("visibilitychange", onVisible);
  }, [ready, session?.token, syncNow]);

  const checkDni = useCallback(async (dni: string) => api.checkDni(dni), []);

  const register = useCallback(async (dni: string, alias: string, password: string) => {
    const result = await api.register(dni, alias, password);
    const next = { token: result.token, user: result.user };
    await persistSession(next);
    setSession(next);
  }, []);

  const login = useCallback(async (dni: string, password: string) => {
    const result = await api.login(dni, password);
    const next = { token: result.token, user: result.user };
    await persistSession(next);
    setSession(next);
  }, []);

  const logout = useCallback(async () => {
    if (sessionRef.current && navigator.onLine) {
      try {
        await api.logout(sessionRef.current.token);
      } catch {
        /* el dispositivo local se limpia igual */
      }
    }
    await persistSession(null);
    setSession(null);
  }, []);

  const enqueue = useCallback(
    async (kind: QueueKind, payload: LikeRow | ProgressRow | NoteRow) => {
      await db.queue.add({ kind, payload });
      if (sessionRef.current && navigator.onLine) {
        void syncNow();
      }
    },
    [syncNow],
  );

  const toggleLike = useCallback(
    async (topicId: string) => {
      const current = likes[topicId];
      const nextLiked = !(current?.liked ?? false);
      if (!nextLiked && topicHasGreen(topicStageEvals, topicId)) {
        throw new Error("No se puede quitar una ficha con evaluación completada (bolita verde)");
      }
      const row: LikeRow = {
        topicId,
        liked: nextLiked,
        updatedAt: nowIso(),
      };
      await db.likes.put(row);
      setLikes((prev) => ({ ...prev, [topicId]: row }));
      await enqueue("like", row);
    },
    [enqueue, likes, topicStageEvals],
  );

  const setStatus = useCallback(
    async (activityId: string, status: Status) => {
      const current = progress[activityId];
      if (current?.lockedStage) {
        throw new Error("Esta acción está fijada a una etapa completada");
      }
      const row: ProgressRow = {
        activityId,
        status,
        lockedStage: null,
        updatedAt: nowIso(),
      };
      await db.progress.put(row);
      setProgress((prev) => ({ ...prev, [activityId]: row }));
      await enqueue("progress", row);
    },
    [enqueue, progress],
  );

  const setNote = useCallback(
    async (topicId: string, text: string) => {
      const row: NoteRow = { topicId, text, updatedAt: nowIso() };
      await db.notes.put(row);
      setNotes((prev) => ({ ...prev, [topicId]: row }));
      await enqueue("note", row);
    },
    [enqueue],
  );

  const changePassword = useCallback(async (password: string) => {
    const current = sessionRef.current;
    if (!current) throw new Error("Sin sesión");
    if (!navigator.onLine) throw new Error("Para cambiar la contraseña necesitás datos");
    await api.changePassword(current.token, password);
  }, []);

  const changeAvatar = useCallback(async (file: File) => {
    const current = sessionRef.current;
    if (!current) throw new Error("Sin sesión");
    if (!navigator.onLine) throw new Error("Para cambiar la foto necesitás datos");
    const { avatar } = await api.uploadAvatar(current.token, file);
    const next = { ...current, user: { ...current.user, avatar } };
    await persistSession(next);
    setSession(next);
  }, []);

  const value = useMemo<Store>(
    () => ({
      ready,
      online,
      syncing,
      session,
      catalog,
      likes,
      progress,
      notes,
      awardedInsigniaIds,
      workingInsigniaIds,
      topicStageEvals,
      closedStages,
      error,
      setError,
      checkDni,
      register,
      login,
      logout,
      syncNow,
      toggleLike,
      setStatus,
      setNote,
      changePassword,
      changeAvatar,
    }),
    [
      awardedInsigniaIds,
      catalog,
      changeAvatar,
      changePassword,
      checkDni,
      closedStages,
      error,
      likes,
      login,
      logout,
      notes,
      online,
      progress,
      ready,
      register,
      session,
      setNote,
      setStatus,
      syncNow,
      syncing,
      toggleLike,
      topicStageEvals,
    ],
  );

  return <StoreContext.Provider value={value}>{children}</StoreContext.Provider>;
}

export function useStore() {
  const ctx = useContext(StoreContext);
  if (!ctx) throw new Error("useStore fuera de StoreProvider");
  return ctx;
}
