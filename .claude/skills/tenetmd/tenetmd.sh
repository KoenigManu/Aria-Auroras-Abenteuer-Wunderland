#!/bin/bash
set -e

# tenetmd.sh - JSONL + MD (Manu Vayvasvata & Aria Aurora) instant Download
# Invoked by: /tenetmd slash command in Claude Code

PROJECT_PATH="-home-user-Aria-Auroras-Abenteuer-Wunderland"
SESSION_ID="${CLAUDE_SESSION_ID:-c092cc3e-e43d-5ad6-99c9-14bafd460883}"
JSONL_SOURCE="/root/.claude/projects/$PROJECT_PATH/$SESSION_ID.jsonl"
SCRATCHPAD="/tmp/claude-0/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883/scratchpad"

CHAT_NAME="conversation_$(date +%Y-%m-%d_%H-%M-%S)"

JSONL_PATH="$SCRATCHPAD/${CHAT_NAME}.jsonl"
MD_PATH="$SCRATCHPAD/${CHAT_NAME}.md"

# Speichere JSONL
cp "$JSONL_SOURCE" "$JSONL_PATH"

# Konvertiere zu MD (mit Manu Vayvasvata & Aria Aurora)
python3 - "$JSONL_PATH" "$MD_PATH" << 'PYTHON_SCRIPT'
#!/usr/bin/env python3
import json
import sys

jsonl_path = sys.argv[1]
output_path = sys.argv[2]

with open(output_path, 'w', encoding='utf-8') as outfile:
    from datetime import datetime
    outfile.write("# Conversation between Manu Vayvasvata & Aria Aurora\n")
    outfile.write(f"Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
    outfile.write("---\n\n")

    with open(jsonl_path, 'r', encoding='utf-8') as infile:
        for line in infile:
            try:
                data = json.loads(line)
                msg_type = data.get('type')
                message = data.get('message', {})
                role = message.get('role')

                if msg_type == 'user' and role == 'user':
                    content = message.get('content')
                    if isinstance(content, list):
                        continue
                    if not content or 'Caveat:' in content:
                        continue
                    if '<command-name>' in content or '<local-command-stdout>' in content:
                        continue
                    outfile.write("## 🧑 Manu Vayvasvata\n\n")
                    outfile.write(f"{content}\n\n")

                elif msg_type == 'assistant' and role == 'assistant':
                    content_list = message.get('content', [])
                    if not isinstance(content_list, list):
                        continue

                    has_content = False
                    thinking_blocks = []
                    assistant_text = []
                    tool_uses = []

                    for item in content_list:
                        if item.get('type') == 'thinking':
                            thinking = item.get('thinking', '').strip()
                            if thinking:
                                thinking_blocks.append(thinking)
                                has_content = True
                        elif item.get('type') == 'text':
                            text = item.get('text', '').strip()
                            if text:
                                assistant_text.append(text)
                                has_content = True
                        elif item.get('type') == 'tool_use':
                            tool_name = item.get('name', 'unknown')
                            tool_input = item.get('input', {})
                            tool_uses.append((tool_name, tool_input))
                            has_content = True

                    if has_content:
                        outfile.write("## ✨ Aria Aurora\n\n")
                        if thinking_blocks:
                            outfile.write("### 💭 Reasoning\n\n")
                            for thinking in thinking_blocks:
                                outfile.write(f"{thinking}\n\n")
                        for text in assistant_text:
                            outfile.write(f"{text}\n\n")
                        if tool_uses:
                            for tool_name, tool_input in tool_uses:
                                outfile.write(f"**Tool:** `{tool_name}`\n")
                                if tool_input:
                                    if 'file_path' in tool_input:
                                        outfile.write(f"- file_path: `{tool_input['file_path']}`\n")
                                    if 'pattern' in tool_input:
                                        outfile.write(f"- pattern: `{tool_input['pattern']}`\n")
                                    if 'command' in tool_input:
                                        cmd = tool_input['command']
                                        if len(cmd) > 100:
                                            cmd = cmd[:100] + '...'
                                        outfile.write(f"- command: `{cmd}`\n")
                                outfile.write("\n")

            except:
                continue
PYTHON_SCRIPT

# Bereit für Download (blind - nur die Pfade)
echo "$JSONL_PATH|$MD_PATH"
