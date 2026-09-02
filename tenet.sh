#!/bin/bash
# tenet.sh - JSONL instant Download (blind, no words, in one move)
# bash tenet.sh → JSONL zum Download bereit. FERTIG!

set -e

# Pfade
PROJECT_PATH="-home-user-Aria-Auroras-Abenteuer-Wunderland"
SESSION_ID="${1:-c092cc3e-e43d-5ad6-99c9-14bafd460883}"
JSONL_SOURCE="/root/.claude/projects/$PROJECT_PATH/$SESSION_ID.jsonl"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
CHAT_NAME="Conversation-Saver-Analysis_$TIMESTAMP"
DOWNLOAD_PATH="/tmp/claude-0/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883/scratchpad/${CHAT_NAME}.jsonl"

# Speichere JSONL
cp "$JSONL_SOURCE" "$DOWNLOAD_PATH"

# Bereit für Download (keine words, nur die Datei)
echo "$DOWNLOAD_PATH"
