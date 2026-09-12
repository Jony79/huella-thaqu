import Dexie, { type EntityTable } from "dexie";
import type { Catalog, LikeRow, NoteRow, ProgressRow, User } from "./types";

export type SessionRow = {
  id: "current";
  token: string;
  user: User;
};

export type MetaRow = {
  key: string;
  value: unknown;
};

export type QueueRow = {
  id?: number;
  kind: "like" | "progress" | "note";
  payload: LikeRow | ProgressRow | NoteRow;
};

class HuellaDB extends Dexie {
  session!: EntityTable<SessionRow, "id">;
  catalog!: EntityTable<{ id: "catalog"; data: Catalog }, "id">;
  likes!: EntityTable<LikeRow, "topicId">;
  progress!: EntityTable<ProgressRow, "activityId">;
  notes!: EntityTable<NoteRow, "topicId">;
  awards!: EntityTable<{ areaId: string }, "areaId">;
  queue!: EntityTable<QueueRow, "id">;
  meta!: EntityTable<MetaRow, "key">;

  constructor() {
    super("huella-thaqu");
    this.version(1).stores({
      session: "id",
      catalog: "id",
      likes: "topicId",
      progress: "activityId",
      notes: "topicId",
      awards: "areaId",
      queue: "++id, kind",
      meta: "key",
    });
  }
}

export const db = new HuellaDB();
