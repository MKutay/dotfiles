#!/usr/bin/env bash
RUNNING=$(osascript -e 'if application "Music" is running then return 0')
if [ "$RUNNING" == "" ]; then
  sketchybar -m --set $NAME drawing=off
  exit 0
fi

PLAYING=0
if [ "$(osascript -e 'if application "Music" is running then tell application "Music" to get player state')" == "playing" ]; then
  PLAYING=1
fi

TRACK=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null || echo "unknown track")
ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null || echo "unknown artist")
ALBUM=$(osascript -e 'tell application "Music" to get album of current track as string' 2>/dev/null || echo "unknown album")

if [ "$TRACK" == "unknown track" ]; then
  sketchybar -m --set $NAME drawing=off
  exit 0
fi

LABEL=""
if [ "$ARTIST" == "unknown artist" ]; then
  LABEL="$TRACK - $ALBUM"
else
  LABEL="$TRACK - $ARTIST"
fi

if [ $PLAYING -eq 0 ]; then
  LABEL="$LABEL (NP)"
fi

sketchybar -m --set $NAME label="$LABEL"