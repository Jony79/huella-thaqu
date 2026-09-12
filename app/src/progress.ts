import type { Area, Status } from "./types";

export function topicStatus(statuses: Status[]): Status {
  const set = new Set(statuses.filter((s) => s && s !== "none"));
  if (set.has("doing")) return "doing";
  if (set.has("goal")) return "goal";
  if (set.has("done")) return "done";
  return "none";
}

export function workingAreaIds(
  areas: Area[],
  progress: { activityId: string; status: Status }[],
): string[] {
  const activityArea = new Map<string, string>();
  for (const area of areas) {
    for (const topic of area.topics) {
      for (const activity of topic.activities) {
        activityArea.set(activity.id, area.id);
      }
    }
  }
  const working = new Set<string>();
  for (const row of progress) {
    if (row.status === "goal" || row.status === "doing") {
      const areaId = activityArea.get(row.activityId);
      if (areaId) working.add(areaId);
    }
  }
  return [...working];
}

export function nowIso() {
  return new Date().toISOString();
}
