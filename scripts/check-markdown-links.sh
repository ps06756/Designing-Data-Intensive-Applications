#!/usr/bin/env sh

set -eu

status=0

# Print the GitHub-style anchor for every heading in a Markdown file,
# skipping fenced code blocks so comments like "# Usage" are not headings.
anchors() {
    awk '
        /^[ \t]*(```|~~~)/ { fence = !fence; next }
        fence { next }
        /^#+[ \t]/ {
            text = $0
            sub(/^#+[ \t]+/, "", text)
            sub(/[ \t]+#*[ \t]*$/, "", text)
            text = tolower(text)
            gsub(/[^a-z0-9 _-]/, "", text)
            gsub(/ /, "-", text)
            slug = (seen[text]++) ? text "-" (seen[text] - 1) : text
            print slug
        }
    ' "$1"
}

for source in *.md; do
    awk '
        {
            line = $0
            while (match(line, /\]\(\.\/[^)#]*\.md(#[^)]*)?\)/)) {
                print substr(line, RSTART + 4, RLENGTH - 5)
                line = substr(line, RSTART + RLENGTH)
            }
        }
    ' "$source" | {
        fail=0
        while IFS= read -r link; do
            target=${link%%#*}
            if [ ! -f "$target" ]; then
                printf '%s: missing local Markdown target %s\n' "$source" "$target" >&2
                fail=1
                continue
            fi
            case "$link" in
                *#*)
                    anchor=${link#*#}
                    if ! anchors "$target" | grep -Fqx -- "$anchor"; then
                        printf '%s: missing anchor #%s in %s\n' "$source" "$anchor" "$target" >&2
                        fail=1
                    fi
                    ;;
            esac
        done
        exit "$fail"
    } || status=1
done

exit "$status"
