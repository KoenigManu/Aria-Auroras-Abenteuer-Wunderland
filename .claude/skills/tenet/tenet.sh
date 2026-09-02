#!/bin/bash
set -e

# tenet.sh - JSONL instant Download (blind, no words, in one move)
# Invoked by: /tenet slash command in Claude Code

PROJECT_PATH="-home-user-Aria-Auroras-Abenteuer-Wunderland"
SESSION_ID="${CLAUDE_SESSION_ID:-c092cc3e-e43d-5ad6-99c9-14bafd460883}"
JSONL_SOURCE="/root/.claude/projects/$PROJECT_PATH/$SESSION_ID.jsonl"
SCRATCHPAD="/tmp/claude-0/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883/scratchpad"

CHAT_NAME="conversation_$(date +%Y-%m-%d_%H-%M-%S)"

JSONL_PATH="$SCRATCHPAD/${CHAT_NAME}.jsonl"

# Speichere JSONL
cp "$JSONL_SOURCE" "$JSONL_PATH"

# Output path für Download (blind - nur Pfad)
echo "$JSONL_PATH"
