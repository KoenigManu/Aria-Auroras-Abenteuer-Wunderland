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
- `claude-conversation-saver-plugin-yzh6pb_2026-09-02_14-45-10.jsonl` (raw data)
- `claude-conversation-saver-plugin-yzh6pb_2026-09-02_14-45-10.md` (human-readable)

Both filenames use your current Git branch name for easy identification. The Markdown version personalizes the conversation with character names instead of generic "User/Assistant".
