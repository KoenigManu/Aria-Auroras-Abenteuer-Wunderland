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
