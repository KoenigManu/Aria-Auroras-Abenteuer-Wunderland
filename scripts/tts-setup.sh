#!/usr/bin/env bash
# Setup + Test fuer KittenTTS (lokale, offline TTS-Engine, laeuft ohne GPU)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
VENV_DIR="$PLUGIN_ROOT/.venv-tts"
KITTEN_WHEEL_URL="https://github.com/KittenML/KittenTTS/releases/download/0.8.1/kittentts-0.8.1-py3-none-any.whl"
OUT_DIR="$PLUGIN_ROOT/tts-output"
SAY_SCRIPT="$SCRIPT_DIR/tts_say.py"

VOICES=(Bella Jasper Luna Bruno Rosie Hugo Kiki Leo)

VOICE="Luna"
SPEED="1.0"
TEXT=""
LIST_VOICES=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --voice)
      VOICE="$2"; shift 2 ;;
    --speed)
      SPEED="$2"; shift 2 ;;
    --list-voices)
      LIST_VOICES=1; shift ;;
    *)
      TEXT="${TEXT:+$TEXT }$1"; shift ;;
  esac
done

if [[ -z "$TEXT" ]]; then
  TEXT="Hallo, hier spricht Aria aus dem Wunderland. Kitten TTS ist bereit."
fi

echo "== KittenTTS Setup =="
echo "Plugin-Root: $PLUGIN_ROOT"
echo "Venv:        $VENV_DIR"

if [[ ! -d "$VENV_DIR" ]]; then
  echo "-- Erstelle virtuelle Umgebung..."
  python3 -m venv "$VENV_DIR"
fi

# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

if ! python -c "import kittentts" >/dev/null 2>&1; then
  echo "-- Installiere KittenTTS (einmalig, ~25MB Modell wird beim ersten Lauf geladen)..."
  pip install --quiet --upgrade pip
  pip install --quiet "$KITTEN_WHEEL_URL"
else
  echo "-- KittenTTS bereits installiert."
fi

mkdir -p "$OUT_DIR"

cat > "$SAY_SCRIPT" <<'PYEOF'
#!/usr/bin/env python3
"""Text-zu-Sprache mit KittenTTS. Wird von tts-setup.sh erzeugt."""
import argparse
import sys
from pathlib import Path

from kittentts import KittenTTS
import soundfile as sf

VOICES = ["Bella", "Jasper", "Luna", "Bruno", "Rosie", "Hugo", "Kiki", "Leo"]


def main():
    parser = argparse.ArgumentParser(description="KittenTTS Sprachausgabe")
    parser.add_argument("text", help="Zu sprechender Text")
    parser.add_argument("--voice", default="Luna", choices=VOICES)
    parser.add_argument("--speed", type=float, default=1.0)
    parser.add_argument("--out", default=None, help="Ausgabe-Wav-Datei")
    args = parser.parse_args()

    out_path = Path(args.out) if args.out else Path("tts-output") / "output.wav"
    out_path.parent.mkdir(parents=True, exist_ok=True)

    model = KittenTTS("KittenML/kitten-tts-mini-0.8")
    audio = model.generate(args.text, voice=args.voice, speed=args.speed)
    sf.write(str(out_path), audio, 24000)
    print(f"Gespeichert: {out_path}")


if __name__ == "__main__":
    sys.exit(main())
PYEOF
chmod +x "$SAY_SCRIPT"

if [[ "$LIST_VOICES" -eq 1 ]]; then
  echo "-- Verfuegbare Stimmen: ${VOICES[*]}"
  deactivate
  exit 0
fi

echo "-- Generiere Test-Ausgabe (Stimme: $VOICE, Speed: $SPEED)..."
OUT_FILE="$OUT_DIR/test_${VOICE,,}.wav"
python "$SAY_SCRIPT" "$TEXT" --voice "$VOICE" --speed "$SPEED" --out "$OUT_FILE"

deactivate

echo ""
echo "== Fertig =="
echo "Test-Audio: $OUT_FILE"
echo "Verfuegbare Stimmen: ${VOICES[*]}"
echo ""
echo "Erneut sprechen lassen:"
echo "  source \"$VENV_DIR/bin/activate\" && python \"$SAY_SCRIPT\" \"Dein Text\" --voice Bella --speed 1.0"
