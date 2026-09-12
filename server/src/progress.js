export function topicStatus(statuses) {
  const set = new Set(statuses.filter((s) => s && s !== "none"));
  if (set.has("doing")) return "doing";
  if (set.has("goal")) return "goal";
  if (set.has("done")) return "done";
  return "none";
}

export function workingAreaIds(progressRows, activities) {
  const activityArea = new Map(activities.map((a) => [a.id, a.areaId]));
  const working = new Set();
  for (const row of progressRows) {
    if (row.status === "goal" || row.status === "doing") {
      const areaId = activityArea.get(row.activityId);
      if (areaId) working.add(areaId);
    }
  }
  return [...working];
}
