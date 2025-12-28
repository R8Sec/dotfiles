#!/usr/bin/env bash

# Kill existing bars
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u "$UID" -x polybar >/dev/null; do
  sleep 0.1
done

# Give XRandR a moment after reload
sleep 0.5

if command -v xrandr >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR="$m" polybar --reload toph &
  done
else
  polybar --reload toph &
fi
