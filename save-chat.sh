#!/bin/bash
# save-chat.sh - Automatisches Speichern und Download der aktuellen Cloud Session JSONL
# Findet die JSONL, speichert sie, und stellt sie zum Download bereit
#
# Usage: bash save-chat.sh
# Or from anywhere: alias save-chat='bash ~/path/to/save-chat.sh'

set -e

echo "🔍 Suche Cloud Session JSONL..."

# Versuche den Pfad zu finden
PROJECT_PATH=""
SESSION_ID=""

# 1. Versuche aus environment variable
if [ -n "$CLAUDE_PROJECT_PATH" ] && [ -n "$CLAUDE_SESSION_ID" ]; then
    PROJECT_PATH="$CLAUDE_PROJECT_PATH"
    SESSION_ID="$CLAUDE_SESSION_ID"
    echo "✓ Gefunden via Environment: $PROJECT_PATH / $SESSION_ID"
fi

# 2. Versuche aus .claude/settings.local.json (wenn nicht gefunden)
if [ -z "$SESSION_ID" ] && [ -f ".claude/settings.local.json" ]; then
    SESSION_ID=$(grep -o '"sessionId":"[^"]*"' .claude/settings.local.json 2>/dev/null | head -1 | cut -d'"' -f4)
    if [ -n "$SESSION_ID" ]; then
        echo "✓ Session ID gefunden: $SESSION_ID"
    fi
fi

# 3. Versuche Project Path aus pwd zu erkennen
if [ -z "$PROJECT_PATH" ]; then
    # Der aktuelle Pfad wird zu URL-encoded Project Path
    CURRENT_DIR=$(pwd)
    # Konvertiere /home/user/Repo zu -home-user-Repo (mit - am Anfang!)
    PROJECT_PATH=$(echo "$CURRENT_DIR" | sed 's|^/||g' | sed 's|/|-|g')
    PROJECT_PATH="-$PROJECT_PATH"  # Füge - am Anfang hinzu
    echo "✓ Project Path erkannt: $PROJECT_PATH"
fi

# 4. Wenn SESSION_ID immer noch nicht bekannt, versuche zu finden
if [ -z "$SESSION_ID" ]; then
    echo "⚠️  Session ID nicht automatisch gefunden. Versuche manuell..."
    SESSION_ID=$(ls /root/.claude/sessions/ 2>/dev/null | tail -1)
    if [ -z "$SESSION_ID" ]; then
        echo "❌ FEHLER: Kann Session ID nicht finden!"
        echo ""
        echo "Bitte helfen Sie mir mit einer der folgenden Optionen:"
        echo "1. Environment Variable setzen: export CLAUDE_SESSION_ID='your-id'"
        echo "2. Die Session ID direkt angeben: bash save-chat.sh c092cc3e-e43d-5ad6-99c9-14bafd460883"
        exit 1
    fi
fi

# Erlauben, dass Session ID als Argument übergeben wird
if [ -n "$1" ]; then
    SESSION_ID="$1"
fi

JSONL_SOURCE="/root/.claude/projects/$PROJECT_PATH/$SESSION_ID.jsonl"

# Prüfe ob die Datei existiert
if [ ! -f "$JSONL_SOURCE" ]; then
    echo "❌ JSONL nicht gefunden: $JSONL_SOURCE"
    echo ""
    echo "Verfügbare Sessions in /root/.claude/projects/$PROJECT_PATH/:"
    ls -la "/root/.claude/projects/$PROJECT_PATH/" 2>/dev/null || echo "  (Verzeichnis nicht gefunden)"
    exit 1
fi

echo "✓ JSONL gefunden: $JSONL_SOURCE"
echo ""

# Speicherconfiguration
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
CHAT_FILENAME="conversation_${TIMESTAMP}.jsonl"

# Speichere in Scratchpad
SCRATCHPAD_DIR="/tmp/claude-0/-home-user-Aria-Auroras-Abenteuer-Wunderland/c092cc3e-e43d-5ad6-99c9-14bafd460883/scratchpad"
mkdir -p "$SCRATCHPAD_DIR"

DOWNLOAD_PATH="$SCRATCHPAD_DIR/$CHAT_FILENAME"

echo "💾 Speichere JSONL..."
cp "$JSONL_SOURCE" "$DOWNLOAD_PATH"

# Größe anzeigen
SIZE=$(ls -lh "$DOWNLOAD_PATH" | awk '{print $5}')
echo "✓ Gespeichert: $DOWNLOAD_PATH ($SIZE)"
echo ""

# Konvertiere auch zu Markdown
echo "📝 Konvertiere zu Markdown..."
MD_FILENAME="conversation_${TIMESTAMP}.md"
MD_PATH="$SCRATCHPAD_DIR/$MD_FILENAME"

PARSER_PATH="$HOME/.claude/skills/conversation-logger/scripts/parse-conversation.py"
if [ -f "$PARSER_PATH" ]; then
    python3 "$PARSER_PATH" "$DOWNLOAD_PATH" "$MD_PATH" "$SESSION_ID" 2>/dev/null && {
        MD_SIZE=$(ls -lh "$MD_PATH" | awk '{print $5}')
        echo "✓ Markdown erstellt: $MD_PATH ($MD_SIZE)"
    } || {
        echo "⚠️  Markdown-Konvertierung fehlgeschlagen (ignoriert)"
    }
else
    echo "⚠️  Parser nicht gefunden, überspringe Markdown"
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "✅ FERTIG! Dein Chat ist zum Download bereit!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📊 Zusammenfassung:"
echo "   JSONL:     $DOWNLOAD_PATH ($SIZE)"
if [ -f "$MD_PATH" ]; then
    echo "   Markdown:  $MD_PATH ($MD_SIZE)"
fi
echo ""
echo "🎯 Nächste Schritte:"
echo "   1. Die Datei steht zum Download bereit (ohne ins Hub zu gehen)"
echo "   2. Zur Sicherung speichern:"
echo "      cp $DOWNLOAD_PATH ~/.claude/conversation-logs/$CHAT_FILENAME"
echo ""
