#!/usr/bin/env sh

set -eu

status=0

for source in README.md chapter-*.md; do
    awk '
        {
            line = $0
            while (match(line, /\]\(\.\/[^)]*\.md\)/)) {
                link = substr(line, RSTART + 2, RLENGTH - 3)
                print link
                line = substr(line, RSTART + RLENGTH)
            }
        }
    ' "$source" | while IFS= read -r target; do
        if [ ! -f "$target" ]; then
            printf '%s: missing local Markdown target %s\n' "$source" "$target" >&2
            exit 1
        fi
    done || status=1
done

exit "$status"
