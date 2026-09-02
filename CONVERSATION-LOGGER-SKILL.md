---
name: conversation-logger
description: This skill should be used when users need to save, search, or retrieve Claude Code conversation transcripts. Use this skill when users ask to save the current conversation, search through past conversations for context, or retrieve information from previous sessions. Also use when appropriate to proactively save important conversations at natural breakpoints (e.g., after completing a major feature, fixing a critical bug, or when the user indicates they're done with a session).
---

# 🗂️ Conversation Logger

---

## ⚡ 🚨 QUICK START: Cloud Sessions (READ THIS FIRST!) 🚨 ⚡

**Are you running in a cloud/remote Claude Code session?** ➡️ **START HERE** ⬇️

### Two Simple Commands to Save Your Chat:

```bash
# Step 1: Copy the JSONL transcript
cp /root/.claude/projects/<project-path>/<session-id>.jsonl \
   ~/.claude/conversation-logs/conversation_$(date +%Y-%m-%d_%H-%M-%S).jsonl

# Step 2: Convert to readable markdown
python3 ~/.claude/skills/conversation-logger/scripts/parse-conversation.py \
  ~/.claude/conversation-logs/conversation_complete_$(date +%Y-%m-%d_%H-%M-%S).jsonl \
  ~/.claude/conversation-logs/conversation_complete_$(date +%Y-%m-%d_%H-%M-%S).md
```

**👉 Full details & how to find your session ID → See "Working with Cloud Sessions" section below**

---

## Overview

This skill enables systematic saving, searching, and retrieving of Claude Code conversation transcripts. It converts raw JSONL transcripts into readable markdown format and provides search capabilities across all saved conversations.

## When to Use This Skill

Use this skill when:
- User explicitly asks to save the current conversation
- User wants to search through past conversations for context or information
- User asks about previous sessions or work done in earlier conversations
- Proactively saving important conversations at natural breakpoints (completed features, major bug fixes, end of work session)
- User needs to find when a specific topic, command, or issue was discussed

---

## 🌩️ WORKING WITH CLOUD SESSIONS (DETAILED GUIDE)

> ⭐ **This is the primary use case for this skill** ⭐
>
> When running Claude Code in a **cloud/remote environment** (not on your local machine), use these exact commands to save your conversations.

### 1️⃣ Finding the Transcript Path

The JSONL transcript in cloud sessions is **always** at:
```
/root/.claude/projects/<project-path>/<session-id>.jsonl
```

**This is the SECRET PATH** 🔑 - Remember it!

**Example path:**
```
/root/.claude/projects/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883.jsonl
```

### 2️⃣ SAVE YOUR CONVERSATION (Copy-Paste Ready)

#### 🟢 STEP 1: Copy the JSONL transcript

```bash
cp /root/.claude/projects/<project-path>/<session-id>.jsonl \
   ~/.claude/conversation-logs/conversation_$(date +%Y-%m-%d_%H-%M-%S).jsonl
```

**✅ Real world example (copy & paste this!):**
```bash
cp /root/.claude/projects/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883.jsonl \
   ~/.claude/conversation-logs/conversation_complete_$(date +%Y-%m-%d_%H-%M-%S).jsonl && \
ls -lh ~/.claude/conversation-logs/ | tail -5
```

#### 🟢 STEP 2: Convert to readable markdown

```bash
python3 ~/.claude/skills/conversation-logger/scripts/parse-conversation.py \
  ~/.claude/conversation-logs/conversation_complete_$(date +%Y-%m-%d_%H-%M-%S).jsonl \
  ~/.claude/conversation-logs/conversation_complete_$(date +%Y-%m-%d_%H-%M-%S).md && \
ls -lh ~/.claude/conversation-logs/*.md
```

**Result:** You now have both `.jsonl` (raw) and `.md` (readable) versions! ✨

### 3️⃣ Finding Your Session ID & Project Path

Need to find your `<session-id>` and `<project-path>`? Use these commands:

#### Find Session ID:
```bash
env | grep -i session
```
Or from session files:
```bash
cat /root/.claude/sessions/*/json | grep -o '"sessionId":"[^"]*"' | head -1
```

#### Find Project Path:
```bash
ls /root/.claude/projects/ | head -5
```

Your path will look like: `-home-user-Aria-Auroras-Abenteuer-Wunderland` (URL-encoded)

### 📍 Cloud Session Paths Explained

| Component | Example | Notes |
|-----------|---------|-------|
| **Project path** | `-home-user-Aria-Auroras-Abenteuer-Wunderland` | URL-encoded git repo path |
| **Session ID** | `c092cc3e-e43d-5ad6-99c9-14bafd460883` | Unique UUID for this cloud session |
| **JSONL source** | `/root/.claude/projects/<path>/<id>.jsonl` | WHERE to find the transcript |
| **Output dir** | `~/.claude/conversation-logs/` | WHERE to save it |

✅ **TL;DR:** Copy FROM `/root/.claude/projects/...` → TO `~/.claude/conversation-logs/`

## Core Capabilities

### 1. Save Current Conversation

To save the current conversation, use the `save-conversation.sh` script with the transcript path and optional session ID.

**Script location:** `scripts/save-conversation.sh`

**Usage:**
```bash
bash scripts/save-conversation.sh <transcript-path> [session-id]
```

**Important:** The transcript path is typically available as an environment variable or in the session context. Common locations:
- `$CLAUDE_TRANSCRIPT_PATH` (if set)
- `~/.claude/sessions/<session-id>/transcript.jsonl`
- Check the current session directory for transcript files

**What it does:**
- Copies the JSONL transcript to `~/.claude/conversation-logs/`
- Converts the transcript to readable markdown format
- Creates session metadata file
- Creates symlinks to the latest conversation for easy access

**Output files created:**
- `conversation_YYYY-MM-DD_HH-MM-SS.jsonl` - Raw transcript
- `conversation_YYYY-MM-DD_HH-MM-SS.md` - Human-readable markdown
- `session_YYYY-MM-DD_HH-MM-SS.json` - Session metadata
- `conversation_latest.jsonl` and `conversation_latest.md` - Symlinks to most recent

**Example workflow:**
When a user says "save this conversation" or "log our work", first locate the transcript path, then execute the save script.

### 2. Search Through Saved Conversations

To search through saved conversations for specific terms or topics, use the `search-conversations.sh` script.

**Script location:** `scripts/search-conversations.sh`

**Usage:**
```bash
# Search for a term
bash scripts/search-conversations.sh "search-term"

# Search with more context lines
bash scripts/search-conversations.sh "search-term" --context 5

# List all saved conversations
bash scripts/search-conversations.sh --list

# Show recent conversations
bash scripts/search-conversations.sh --recent 5
```

**Common search scenarios:**

**Finding when a topic was discussed:**
```bash
bash scripts/search-conversations.sh "docker configuration"
```

**Finding command usage:**
```bash
bash scripts/search-conversations.sh "git commit" --context 10
```

**Browsing recent work:**
```bash
bash scripts/search-conversations.sh --recent 3
```

**Example workflow:**
When a user asks "when did we work on the authentication bug?" or "find conversations about database migrations", use the search script to locate relevant conversations, then read the full conversation file if needed.

### 3. Retrieve Full Conversations

To read a complete saved conversation, access the markdown files directly in `~/.claude/conversation-logs/`.

**Typical workflow:**
1. Use search to find relevant conversations
2. Note the timestamp from search results
3. Read the full markdown file: `~/.claude/conversation-logs/conversation_YYYY-MM-DD_HH-MM-SS.md`

**Quick access to latest:**
```bash
cat ~/.claude/conversation-logs/conversation_latest.md
```

## Conversation Format

Saved conversations are stored in two formats:

**JSONL (Raw):** Complete conversation data including all API messages, tool calls, and metadata. Used by the parser and for programmatic access.

**Markdown (Readable):** Human-friendly format with:
- Clear USER/ASSISTANT sections
- Tool usage summary (shows tool name and key parameters)
- Filtered system messages and noise
- Timestamps and session IDs

## Proactive Usage Guidelines

Consider saving conversations proactively when:
- A complex feature or bug fix is completed
- User indicates they're wrapping up (phrases like "that's all for now", "thanks, I'm done")
- A significant amount of work has been accomplished in the session
- User switches context significantly (new project, different task domain)

**Important:** Always ask first before saving proactively. Example: "This looks like a good stopping point. Would you like me to save this conversation for future reference?"

## Requirements

**System dependencies:**
- `python3` - Required for parsing JSONL to markdown
- `bash` - For running the scripts
- `jq` - Optional, for working with JSON metadata

**Installation check:**
```bash
command -v python3 && echo "✓ Python installed" || echo "✗ Python required"
```

## Troubleshooting

**Cannot find transcript path:**
- Check session directory: `ls -la ~/.claude/sessions/`
- Look for environment variables: `env | grep CLAUDE`
- Ask user for the transcript location

**Parser fails:**
- Verify python3 is installed and accessible
- Check that the JSONL file is valid (not corrupted)
- Fallback: Save only the JSONL file, skip markdown conversion

**Search finds nothing:**
- Verify conversations exist: `ls ~/.claude/conversation-logs/`
- Check that search term is spelled correctly
- Try broader search terms or use `--list` to see available conversations

## Resources

### scripts/

- **save-conversation.sh** - Main script to save and parse conversations
- **search-conversations.sh** - Search utility for finding past conversations
- **parse-conversation.py** - Python parser that converts JSONL to markdown

All scripts are executable and can be run directly from the skill directory.
