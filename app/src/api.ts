import type {
  Catalog,
  EducatorProtagonist,
  EducatorTopic,
  PageResult,
  SocialPerson,
  StageBalls,
  StageNumber,
  SyncPayload,
  TopicStageEval,
  User,
} from "./types";

const TOKEN_HEADER = "Authorization";

export class ApiError extends Error {
  status: number;
  constructor(message: string, status: number) {
    super(message);
    this.status = status;
  }
}

async function request<T>(
  path: string,
  options: RequestInit & { token?: string | null } = {},
): Promise<T> {
  const headers = new Headers(options.headers);
  if (options.body && !(options.body instanceof FormData) && !headers.has("Content-Type")) {
    headers.set("Content-Type", "application/json");
  }
  if (options.token) {
    headers.set(TOKEN_HEADER, `Bearer ${options.token}`);
  }

  const response = await fetch(path, { ...options, headers });
  const data = await response.json().catch(() => ({}));
  if (!response.ok) {
    throw new ApiError(data.error || "No se pudo completar la acción", response.status);
  }
  return data as T;
}

function qs(params: Record<string, string | number | undefined | null>) {
  const search = new URLSearchParams();
  for (const [key, value] of Object.entries(params)) {
    if (value != null && value !== "") search.set(key, String(value));
  }
  const text = search.toString();
  return text ? `?${text}` : "";
}

export const api = {
  checkDni: (dni: string) =>
    request<{ dni: string; registered: boolean; tipo: "protagonista" | "educador" }>(
      "/api/auth/check-dni",
      {
        method: "POST",
        body: JSON.stringify({ dni }),
      },
    ),

  register: (dni: string, alias: string, password: string) =>
    request<{ token: string; user: User }>("/api/auth/register", {
      method: "POST",
      body: JSON.stringify({ dni, alias, password }),
    }),

  login: (dni: string, password: string) =>
    request<{ token: string; user: User }>("/api/auth/login", {
      method: "POST",
      body: JSON.stringify({ dni, password }),
    }),

  logout: (token: string) =>
    request<{ ok: boolean }>("/api/auth/logout", { method: "POST", token }),

  me: (token: string) =>
    request<{ user: User; awardedInsigniaIds: string[] }>("/api/me", { token }),

  catalog: (token: string) => request<Catalog>("/api/catalog", { token }),

  pull: (token: string) => request<SyncPayload>("/api/sync", { token }),

  push: (token: string, body: unknown) =>
    request<{ ok: boolean }>("/api/sync", {
      method: "POST",
      token,
      body: JSON.stringify(body),
    }),

  topicLikes: (token: string, topicId: string) =>
    request<{ people: SocialPerson[] }>(`/api/topics/${topicId}/likes`, { token }),

  changePassword: (token: string, password: string) =>
    request<{ user: User }>("/api/profile", {
      method: "PATCH",
      token,
      body: JSON.stringify({ password }),
    }),

  uploadAvatar: async (token: string, file: File) => {
    const body = new FormData();
    body.append("avatar", file);
    return request<{ avatar: string }>("/api/profile/avatar", {
      method: "POST",
      token,
      body,
    });
  },

  educatorProtagonists: (token: string, params: { q?: string; page?: number }) =>
    request<PageResult<EducatorProtagonist>>(
      `/api/educator/protagonists${qs(params)}`,
      { token },
    ),

  educatorResetPassword: (token: string, userId: number) =>
    request<{ temporaryPassword: string }>(
      `/api/educator/protagonists/${userId}/reset-password`,
      { method: "POST", token },
    ),

  educatorToggleEnabled: (token: string, personId: number) =>
    request<{ habilitado: boolean }>(
      `/api/educator/protagonists/${personId}/toggle-enabled`,
      { method: "POST", token },
    ),

  educatorProgression: (token: string, personId: number) =>
    request<{
      personId: number;
      userId: number | null;
      user: User & { nombre?: string };
      awardedInsigniaIds: string[];
      progression: { stage: number; label: string; shortLabel: string };
      closedStages: StageNumber[];
      topicStageEvals: TopicStageEval[];
      likes: SyncPayload["likes"];
      progress: SyncPayload["progress"];
      notes: SyncPayload["notes"];
    }>(`/api/educator/protagonists/${personId}/progression`, { token }),

  educatorToggleInsignia: (token: string, personId: number, insigniaId: string) =>
    request<{
      insigniaId: string;
      element?: string;
      awarded: boolean;
      awardedInsigniaIds: string[];
      progression: { stage: number; label: string; shortLabel: string };
    }>(`/api/educator/protagonists/${personId}/insignias/${insigniaId}`, {
      method: "POST",
      token,
    }),

  educatorCycleTopicStage: (
    token: string,
    personId: number,
    topicId: string,
    stage: StageNumber,
  ) =>
    request<{
      topicId: string;
      stage: StageNumber;
      status: "in_progress" | "done" | null;
      balls: StageBalls;
      topicStageEvals: TopicStageEval[];
      progress: SyncPayload["progress"];
    }>(`/api/educator/protagonists/${personId}/topics/${topicId}/stages/${stage}`, {
      method: "POST",
      token,
    }),

  educatorCloseStage: (token: string, personId: number, stage: StageNumber) =>
    request<{ stage: StageNumber; closedStages: StageNumber[] }>(
      `/api/educator/protagonists/${personId}/stages/${stage}/close`,
      { method: "POST", token },
    ),

  educatorTopics: (
    token: string,
    params: { q?: string; page?: number; areaId?: string },
  ) =>
    request<PageResult<EducatorTopic>>(`/api/educator/topics${qs(params)}`, { token }),

  educatorTopicProtagonists: (
    token: string,
    topicId: string,
    params: { q?: string; page?: number },
  ) =>
    request<{
      topic: { id: string; title: string; areaName: string; areaColor: string };
      page: number;
      pageSize: number;
      total: number;
      items: {
        personId: number;
        alias: string;
        avatar: string | null;
        balls: StageBalls;
      }[];
    }>(`/api/educator/topics/${topicId}/protagonists${qs(params)}`, { token }),
};
