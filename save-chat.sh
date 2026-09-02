#!/bin/bash
# Export current chat as JSONL for download

TRANSCRIPT="/root/.claude/projects/-home-user-Aria-Auroras-Abenteuer-Wunderland/39ea592d-0bf0-5f2b-8b24-1676039651d6.jsonl"
OUTPUT="/home/user/Aria-Auroras-Abenteuer-Wunderland/Ens-Kitty-Chat-$(date +%Y%m%d_%H%M%S).jsonl"

if [ -f "$TRANSCRIPT" ]; then
    cp "$TRANSCRIPT" "$OUTPUT"
    echo "✓ Chat exported to: $OUTPUT"
    ls -lh "$OUTPUT"
else
    echo "✗ Transcript not found at: $TRANSCRIPT"
    exit 1
fi
