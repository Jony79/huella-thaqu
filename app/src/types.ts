export type Status = "none" | "goal" | "doing" | "done";

export type StageNumber = 1 | 2 | 3 | 4;

export type StageBallStatus = "in_progress" | "done";

export type BallColor = "gray" | "yellow" | "green";

export type Activity = {
  id: string;
  title: string;
};

export type Topic = {
  id: string;
  title: string;
  body: string;
  activities: Activity[];
};

export type Area = {
  id: string;
  name: string;
  color: string;
  badge?: string;
  topics: Topic[];
};

export type Catalog = {
  version: number;
  areas: Area[];
};

export type User = {
  alias: string;
  avatar: string | null;
  dni?: string;
  role?: "protagonista" | "educador";
};

export type EducatorProtagonist = {
  personId: number;
  userId: number | null;
  dni: string;
  nombre: string;
  alias: string | null;
  avatar: string | null;
  habilitado: boolean;
  lastAccess: string | null;
  awardCount?: number;
  progressionLabel?: string;
  progressionStage?: number;
};

export type EducatorTopic = {
  id: string;
  title: string;
  areaId: string;
  areaName: string;
  areaColor: string;
  protagonistas: number;
};

export type PageResult<T> = {
  page: number;
  pageSize: number;
  total: number;
  items: T[];
};

export type LikeRow = {
  topicId: string;
  liked: boolean;
  updatedAt: string;
};

export type ProgressRow = {
  activityId: string;
  status: Status;
  lockedStage?: StageNumber | null;
  updatedAt: string;
};

export type NoteRow = {
  topicId: string;
  text: string;
  updatedAt: string;
};

export type TopicStageEval = {
  topicId: string;
  stage: StageNumber;
  status: StageBallStatus;
  updatedAt?: string;
};

export type SyncPayload = {
  user: User;
  awardedInsigniaIds: string[];
  closedStages: StageNumber[];
  topicStageEvals: TopicStageEval[];
  likes: LikeRow[];
  progress: ProgressRow[];
  notes: NoteRow[];
};

export type SocialPerson = {
  alias: string;
  status: Status;
};

export type StageBalls = {
  e1: BallColor;
  e2: BallColor;
  e3: BallColor;
  e4: BallColor;
};
