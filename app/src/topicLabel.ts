import type { Topic } from "./types";

export function topicNumber(topicId: string) {
  const match = topicId.match(/-(\d+)$/);
  return match ? match[1] : "";
}

export function topicHeading(topic: Topic) {
  const number = topicNumber(topic.id);
  if (!number) return topic.title;
  const normalized = topic.title.replace(/^0?\d+[.\s·-]+/, "");
  return `${number}. ${normalized}`;
}
