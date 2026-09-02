---
name: tenetmd
description: Download the current conversation as JSONL + Markdown (blind, no words, instant download)
---

# /tenetmd - Instant JSONL + Markdown Download

Speichere den aktuellen Chat als JSONL und lesbare Markdown-Datei zum Download - blind, ohne Worte, in einem Zug.

## Usage

Simply type `/tenetmd` in Claude Code chat to download the current conversation as both JSONL and Markdown.

The command:
- Finds the current cloud session JSONL
- Creates a readable Markdown version with "Manu Vayvasvata 🧑" & "Aria Aurora ✨" sections
- Copies both to the download folder with Git-branch-based filenames
- Makes them ready for instant download

## Output

Downloads two files:
- `conversation_2026-09-02_14-45-10.jsonl` (raw data)
- `conversation_2026-09-02_14-45-10.md` (human-readable)

Both files are automatically ready in your download folder. The Markdown version personalizes the conversation with "Manu Vayvasvata" and "Aria Aurora" instead of generic labels.
