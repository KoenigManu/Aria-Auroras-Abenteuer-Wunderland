#!/bin/bash
# tenet.sh - JSONL instant Download (blind, no words, in one move)
# bash tenet.sh → JSONL zum Download bereit. FERTIG!

set -e

# Pfade
PROJECT_PATH="-home-user-Aria-Auroras-Abenteuer-Wunderland"
SESSION_ID="${1:-c092cc3e-e43d-5ad6-99c9-14bafd460883}"
JSONL_SOURCE="/root/.claude/projects/$PROJECT_PATH/$SESSION_ID.jsonl"

# Versuche den echten Chat-Namen zu finden
CHAT_NAME=""
if [ -f ".claude/settings.local.json" ]; then
    CHAT_NAME=$(grep -o '"name":"[^"]*"' .claude/settings.local.json 2>/dev/null | head -1 | cut -d'"' -f4 || echo "")
fi

# Fallback: Session Name aus /root/.claude/sessions/
if [ -z "$CHAT_NAME" ]; then
    CHAT_NAME=$(cat "/root/.claude/sessions/${SESSION_ID}.json" 2>/dev/null | grep -o '"name":"[^"]*"' | head -1 | cut -d'"' -f4 || echo "")
fi

# Fallback: Branch Name aus Git (ersetze / mit -)
if [ -z "$CHAT_NAME" ]; then
    CHAT_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null | sed 's|/|-|g' || echo "")
fi

# Fallback: Generic Name
if [ -z "$CHAT_NAME" ]; then
    CHAT_NAME="Chat_$(date +%Y-%m-%d_%H-%M-%S)"
else
    CHAT_NAME="${CHAT_NAME}_$(date +%Y-%m-%d_%H-%M-%S)"
fi

DOWNLOAD_PATH="/tmp/claude-0/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883/scratchpad/${CHAT_NAME}.jsonl"

# Speichere JSONL
cp "$JSONL_SOURCE" "$DOWNLOAD_PATH"

# Bereit für Download (keine words, nur die Datei)
echo "$DOWNLOAD_PATH"
