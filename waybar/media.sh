#!/usr/bin/env bash

status="$(playerctl status 2>/dev/null)"
text="$(playerctl metadata --format '{{artist}} - {{title}}' 2>/dev/null)"

case "$status" in
    Playing)
        class="playing"
        ;;
    Paused)
        class="paused"
        ;;
    *)
        class="stopped"
        ;;
esac

printf '{"text":"%s","class":"%s"}\n' \
    "${text//\"/\\\"}" \
    "$class"
