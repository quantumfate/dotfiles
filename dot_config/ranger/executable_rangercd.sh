#!/bin/sh
function ranger-cd {
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$PWD" ]]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}   