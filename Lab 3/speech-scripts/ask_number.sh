#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VOICES_DIR="$SCRIPT_DIR/../voices"

python3 -m piper \
  --model en_US-lessac-medium \
  --data-dir "$VOICES_DIR" \
  --output-file "$SCRIPT_DIR/question.wav" \
  -- "How many coffees did you drink today? Please say your answer now."
aplay "$SCRIPT_DIR/question.wav"

echo "Listening for five seconds..."
arecord -D plughw:3,0 -d 5 -f S16_LE -c 1 -r 16000 "$SCRIPT_DIR/answer.wav"
echo "Saved your response to $SCRIPT_DIR/answer.wav"
