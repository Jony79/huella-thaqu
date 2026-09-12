"""Genera content/areas.json desde las fichas PDF."""
from __future__ import annotations

import json
import re
from pathlib import Path

import pymupdf

ROOT = Path(__file__).resolve().parents[1]
PDFS = ROOT / "material" / "pdfs"

AREAS = [
    {
        "id": "salud-bienestar",
        "name": "Salud y bienestar",
        "color": "#1d4e89",
        "pdf": "666d0611548164109d04b7cc_Fichas - Salud y bienestar.pdf",
    },
    {
        "id": "habilidades-vida",
        "name": "Habilidades para la vida",
        "color": "#c45c26",
        "pdf": "666d042e2dd00cac574dd810_Fichas - Habilidades para la vida.pdf",
    },
    {
        "id": "ambiente",
        "name": "Ambiente",
        "color": "#2d6a4f",
        "pdf": "666d031316a6a4fb694bfe69_Fichas - Ambiente.pdf",
    },
    {
        "id": "paz-desarrollo",
        "name": "Paz y desarrollo",
        "color": "#6d3b7a",
        "pdf": "666d04d45bb6463dc2deafe1_FIchas - Paz y desarrollo.pdf",
    },
]

SKIP_LINE = re.compile(
    r"^(ficha|acciones sugeridas|preguntas orientadoras|propongo estas acciones\.?\.?\.?|"
    r"salud y bienestar|habilidades para la vida|ambiente|paz y desarrollo|paz y desarro?llo)$",
    re.I,
)
NUM = re.compile(r"^\d{1,2}$")


def clean(line: str) -> str:
    line = line.replace("ﬁ", "fi").replace("ﬂ", "fl").replace("\u00ad", "")
    return re.sub(r"\s+", " ", line).strip()


def page_lines(page) -> list[str]:
    lines = []
    buf = ""
    for raw in page.get_text("text").splitlines():
        line = clean(raw)
        if not line:
            continue
        if line.endswith("-") and len(line) > 3:
            buf += line[:-1]
            continue
        text = (buf + line) if buf else line
        buf = ""
        lines.append(text)
    if buf:
        lines.append(buf)
    return lines


def ficha_number(lines: list[str]) -> str | None:
    for line in lines:
        match = re.search(r"Ficha\s+(\d{1,2})", line, re.I)
        if match:
            return match.group(1).zfill(2)
    for line in lines:
        if NUM.match(line):
            return line.zfill(2)
    return None


def useful(line: str) -> bool:
    if SKIP_LINE.match(line) or NUM.match(line):
        return False
    if line.lower().startswith("ficha "):
        return False
    return True


def sentences_from(lines: list[str]) -> list[str]:
    text = " ".join(line for line in lines if useful(line))
    text = re.sub(r"\s+", " ", text).strip()
    text = re.sub(r"\s+\d{1,2}$", "", text)
    parts = re.split(r"(?<=[.?!])\s+", text)
    return [part.strip().strip("“\"") for part in parts if len(part.strip()) > 12]


def parse_ficha(lines: list[str]) -> tuple[str, list[str]]:
    raw = "\n".join(lines)
    if re.search(r"Acciones sugeridas", raw, re.I):
        before, after = re.split(r"Acciones sugeridas", raw, maxsplit=1, flags=re.I)
        after_sents = sentences_from(after.splitlines())
        before_sents = [s for s in sentences_from(before.splitlines()) if not s.endswith("?")]
        title = after_sents[0] if after_sents and len(after_sents[0]) <= 180 else ""
        if not title and before_sents:
            # Salud / Habilidades: el lema suele ser la primera frase corta.
            short = [s for s in before_sents if len(s) <= 160]
            title = short[0] if short else before_sents[0]
        actions = before_sents
        if title:
            actions = [s for s in actions if s.rstrip(".") != title.rstrip(".")]
        if not title:
            title = actions[0] if actions else "Ficha"
        return title, actions

    sents = [s for s in sentences_from(lines) if not s.endswith("?")]
    title = sents[0] if sents else "Ficha"
    return title, [s for s in sents[1:]]


def parse_questions(lines: list[str]) -> list[str]:
    return [line for line in lines if useful(line) and "?" in line]


def parse_area(area: dict) -> dict:
    doc = pymupdf.open(PDFS / area["pdf"])
    topics = []
    seen = set()
    i = 0
    while i < doc.page_count:
        ficha_lines = page_lines(doc[i])
        question_lines: list[str] = []
        if i + 1 < doc.page_count:
            nxt = page_lines(doc[i + 1])
            nxt_text = " ".join(nxt).lower()
            if "preguntas orientadoras" in nxt_text or not any(l.lower().startswith("ficha") for l in nxt[:4]):
                question_lines = nxt
                i += 2
            else:
                i += 1
        else:
            i += 1

        number = ficha_number(ficha_lines) or ficha_number(question_lines)
        if not number or number in seen:
            continue
        seen.add(number)
        title, actions = parse_ficha(ficha_lines)
        questions = parse_questions(question_lines)
        body = title
        if questions:
            body += "\n\nPreguntas orientadoras:\n" + "\n".join(f"• {q}" for q in questions)
        topics.append(
            {
                "id": f"{area['id']}-{number}",
                "title": f"{int(number)}. {title}",
                "body": body,
                "activities": [
                    {"id": f"{area['id']}-{number}-a{idx + 1}", "title": action}
                    for idx, action in enumerate(actions)
                ],
            }
        )
    return {
        "id": area["id"],
        "name": area["name"],
        "color": area["color"],
        "topics": topics,
    }


def main() -> None:
    catalog = {"version": 2, "areas": [parse_area(area) for area in AREAS]}
    dest = ROOT / "content" / "areas.json"
    dest.write_text(json.dumps(catalog, ensure_ascii=False, indent=2), encoding="utf-8")
    for area in catalog["areas"]:
        acts = sum(len(t["activities"]) for t in area["topics"])
        print(f"{area['name']}: {len(area['topics'])} fichas, {acts} acciones")
        print("  ", area["topics"][0]["title"][:90])


if __name__ == "__main__":
    main()
