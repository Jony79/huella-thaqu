import type { BallColor, StageNumber, TopicStageEval } from "./types";

export const STAGE_NUMBERS: StageNumber[] = [1, 2, 3, 4];

export function ballsForTopic(evals: TopicStageEval[]): Record<StageNumber, BallColor> {
  const byStage = Object.fromEntries(evals.map((e) => [e.stage, e.status]));
  const color = (status?: string): BallColor => {
    if (status === "done") return "green";
    if (status === "in_progress") return "yellow";
    return "gray";
  };
  return {
    1: color(byStage[1]),
    2: color(byStage[2]),
    3: color(byStage[3]),
    4: color(byStage[4]),
  };
}

export function topicHasGreen(evals: TopicStageEval[], topicId: string) {
  return evals.some((e) => e.topicId === topicId && e.status === "done");
}

export function stageTag(stage: StageNumber | null | undefined) {
  if (!stage) return null;
  return `E${stage}`;
}
