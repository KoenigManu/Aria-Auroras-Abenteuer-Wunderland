# Claude Conversation Saver Plugin - Deep Analysis

**Branch:** `claude/conversation-saver-plugin-yzh6pb`  
**Date:** 2026-09-01  
**Analysis Focus:** How data is stored, size limits, and what actually gets saved

---

## Executive Summary

The Claude Conversation Saver Plugin is a **real-time conversation backup system** that:
- ✅ Saves **EVERYTHING** from the conversation (no filtering)
- ✅ Triggers automatically after **each Claude response** via Stop hook
- ✅ Stores as JSONL (raw) + Markdown (readable) + metadata JSON
- ⚠️ **No hard size limits** - grows indefinitely with conversation depth
- ⚠️ **No selection algorithm** - it's all-or-nothing (not selective like the original README suggested)

---

## Architecture Overview

```
┌─────────────────────────────────────────┐
│   Claude Code Session (any app)         │
└──────────────────┬──────────────────────┘
                   │
        Stop hook fires after each response
                   ↓
┌─────────────────────────────────────────┐
│  Plugin: conversation-saver/             │
│  hooks/stop.sh                          │
│  - Reads hook context (JSONL path)      │
│  - Calls skill's save-conversation.sh   │
└──────────────────┬──────────────────────┘
                   │
                   ↓
┌─────────────────────────────────────────┐
│  Skill: conversation-logger/            │
│  scripts/save-conversation.sh           │
│  - Copies full JSONL transcript         │
│  - Parses to markdown                   │
│  - Creates session metadata             │
└──────────────────┬──────────────────────┘
                   │
                   ↓
┌─────────────────────────────────────────┐
│  ~/.claude/conversation-logs/           │
│  - conversation_YYYY-MM-DD_HH-MM-SS.jsonl
│  - conversation_YYYY-MM-DD_HH-MM-SS.md  │
│  - session_YYYY-MM-DD_HH-MM-SS.json     │
│  - conversation_latest.md (symlink)     │
└─────────────────────────────────────────┘
```

---

## What Gets Saved (Complete List)

### JSONL Transcript (conversation_YYYY-MM-DD_HH-MM-SS.jsonl)
Exact copy of the session's transcript JSONL file, containing:

1. **User Messages**
   - All text input from user
   - Embedded tool results
   - System messages passed through

2. **Assistant Messages**
   - Thinking blocks (if enabled)
   - Text responses
   - Tool calls (with parameters)
   - Tool results processing

3. **System Context**
   - System reminders (at start of each turn)
   - Environment variables
   - MCP server instructions
   - Model identity info
   - All system metadata

4. **Tool Operations**
   - Bash commands (with full parameters)
   - File reads/edits (complete file content)
   - Git operations
   - API calls
   - Tool results and errors

5. **Everything Else**
   - Context compression signals
   - Conversation state
   - Error messages
   - Warnings and debug output

**Result:** The JSONL is a **complete and unfiltered** transcript of everything that happened.

### Markdown Version (conversation_YYYY-MM-DD_HH-MM-SS.md)
Human-readable parsed version from `parse-conversation.py`:
- User messages (## USER sections)
- Assistant responses (## ASSISTANT sections)
- Thinking blocks (### 💭 Thinking sections)
- Tool usage (Tool name + key parameters only)
- Skips metadata for readability

### Session Metadata (session_YYYY-MM-DD_HH-MM-SS.json)
```json
{
  "session_id": "c092cc3e-e43d-5ad6-99c9-14bafd460883",
  "timestamp": "2026-09-01_08-42-15",
  "date": "2026-09-01 08:42:15",
  "transcript_path": "/path/to/original/transcript.jsonl"
}
```

---

## Size Analysis

### Actual Storage Pattern

**What the README claims:**
- "~1KB per Memory"
- "a year stays under 5MB"
- "theoretically unlimited"

**What actually happens:**

Each time the Stop hook fires (after EVERY Claude response):
1. The **entire current JSONL** is copied to ~/.claude/conversation-logs/
2. A new markdown version is generated
3. Session metadata is created

**This means:**
- **First response:** ~5-50 KB (depends on response size)
- **Second response:** JSONL now includes first + second response, so ~10-100 KB
- **Tenth response:** JSONL is cumulative, ~50-500 KB
- **100th response:** Could be 1-5 MB or more

### Growth Pattern Example

For a typical conversation with ~2KB per turn average:

| Response # | Cumulative JSONL | Markdown | Total per save |
|-----------|------------------|----------|-----------------|
| 1         | 2 KB             | 3 KB     | 5 KB            |
| 10        | 20 KB            | 30 KB    | 50 KB           |
| 50        | 100 KB           | 150 KB   | 250 KB          |
| 100       | 200 KB           | 300 KB   | 500 KB          |
| 500       | 1 MB             | 1.5 MB   | 2.5 MB per save |

**Problem:** Each response trigger saves the **entire conversation so far** again, creating duplicate data in separate files!

### No Hard Limits

From examining the code:
- ✅ No size checks in `save-conversation.sh`
- ✅ No cleanup logic
- ✅ No automatic pruning
- ✅ No warnings when disk is full
- ⚠️ **Will keep saving until disk is full**

---

## The "Automatic Selection" Question

### Original Question
> "How does the system decide what's important to save?"

### Answer: **It doesn't. It saves everything.**

The plugin/skill has **NO algorithm** for selective saving:
- ❌ No content analysis
- ❌ No importance weighting
- ❌ No filtering by message type
- ❌ No compression of repeated data
- ✅ **All-or-nothing:** Either save the entire JSONL or save nothing

The Stop hook simply:
1. Reads the transcript path
2. Copies it verbatim
3. Parses to markdown
4. Saves metadata

---

## How the Plugin Actually Works (Step-by-Step)

### Step 1: Stop Hook Triggers
After each Claude response, the Stop hook fires with context:
```bash
# From plugin.json
"hooks": {
  "Stop": [{
    "type": "command",
    "command": "${PLUGIN_DIR}/hooks/stop.sh"
  }]
}
```

### Step 2: Hook Extracts Metadata
```bash
# From hooks/stop.sh
HOOK_DATA=$(cat)  # Reads stdin (hook context)
TRANSCRIPT_PATH=$(echo "$HOOK_DATA" | jq -r '.transcript_path')
SESSION_ID=$(echo "$HOOK_DATA" | jq -r '.session_id')
```

The hook data contains:
- `transcript_path`: Full path to current session's JSONL
- `session_id`: UUID of the session
- (potentially other metadata)

### Step 3: Skill Saves the Transcript
```bash
# From save-conversation.sh
cp "$TRANSCRIPT_PATH" "$LOG_DIR/conversation_$TIMESTAMP.jsonl"
```

This is a **direct copy** - no filtering, no selection, no compression.

### Step 4: Parse to Markdown
```bash
python3 "$PARSER_PATH" "$LOG_DIR/conversation_$TIMESTAMP.jsonl" \
    "$LOG_DIR/conversation_$TIMESTAMP.md" "$SESSION_ID"
```

The Python parser (`parse-conversation.py`):
- Reads the JSONL line by line
- Extracts user and assistant messages
- Formats them for readability
- Skips tool results details to keep files smaller

### Step 5: Create Metadata
Simple JSON file with session info and timestamp.

---

## Storage Location

All files go to: **`~/.claude/conversation-logs/`**

```
~/.claude/conversation-logs/
├── conversation_2026-09-01_08-15-30.jsonl
├── conversation_2026-09-01_08-15-30.md
├── session_2026-09-01_08-15-30.json
├── conversation_2026-09-01_08-16-45.jsonl
├── conversation_2026-09-01_08-16-45.md
├── session_2026-09-01_08-16-45.json
├── conversation_latest.jsonl -> conversation_2026-09-01_08-16-45.jsonl
└── conversation_latest.md -> conversation_2026-09-01_08-16-45.md
```

Each **save event creates new files** (doesn't append to existing ones).

---

## Important Findings

### 1. No Size Warnings
The plugin will happily fill your disk without any warnings or checks.

### 2. Duplicate Storage
Every response saves the entire conversation again:
- 10 responses = 10 separate JSONL files, each containing the full history
- This is **intentional** (for preservation) but creates massive redundancy

### 3. No Selective Saving
Despite what one might hope, there's **zero intelligence** about what to save:
- System reminders? Saved
- Tool outputs? Saved
- Thinking blocks? Saved
- Everything? **Yes**

### 4. Fast and Simple
On the plus side:
- ✅ No complex processing
- ✅ Very reliable
- ✅ Zero data loss risk
- ✅ Easy to implement and maintain

### 5. Search is Simple Too
The search functionality in `search-conversations.sh`:
- Uses `grep` to find patterns in JSONL files
- Full-text search across all conversations
- No indexing or optimization
- Works but scales linearly with file size

---

## Configuration Options

There are **NO configuration options** in the plugin:
- No size limits to set
- No file types to exclude
- No compression settings
- No archive policies
- No cleanup schedules

It's designed as a "save everything" system by philosophy.

---

## Comparison: Plugin vs Skill Only

### With Plugin Installed
- Automatic saves after each response
- Slash commands for search/list/recent
- Real-time backups (no data loss)
- More storage usage
- More disk I/O

### With Skill Only (No Plugin)
- Manual saves via Claude prompts
- Same search capabilities
- Requires explicit action
- Lower disk I/O
- Less automatic protection

---

## Practical Implications

### Best For
✅ Long-running sessions you want to reference  
✅ Projects where you want complete conversation history  
✅ Debugging and understanding previous decisions  
✅ Compliance/audit trails  

### Challenges
⚠️ Disk space grows linearly with conversation depth  
⚠️ No cleanup or archival built in  
⚠️ No compression of redundant data  
⚠️ Search gets slower as library grows  

### Recommendations
1. **Monitor disk usage** regularly
2. **Archive old conversations** manually to external storage
3. **Delete outdated logs** periodically: `rm ~/.claude/conversation-logs/conversation_2026-08-*.jsonl`
4. **Use the skill separately** if you only need manual saves
5. **Consider disabling Stop hook** if storage is limited, use manual saves instead

---

## Conclusion

The Claude Conversation Saver Plugin is:
- **Transparent:** Saves everything, no hidden logic
- **Simple:** Straightforward copy-parse-save pipeline
- **Reliable:** Zero data loss by design
- **Storage-heavy:** Intentionally keeps multiple copies for safety
- **Not selective:** No "smart" filtering despite the README's vague wording

It's perfect for important projects where you want complete preservation, but not ideal for constrained storage or if you only care about high-level summaries.

**The README's vagueness about "how it decides what to save" resolved:** It doesn't decide anything. It saves **everything**.

---

*Analysis created: 2026-09-01*  
*Repositories studied:*
- `github.com/sirkitree/claude-conversation-saver`
- `github.com/sirkitree/conversation-logger`
