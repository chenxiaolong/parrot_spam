#!/bin/bash

avail=4000

ifs="$IFS"; IFS=""
if [ -z "$*" ]; then
    echo 'Nothing to repeat' >&2
    exit 1
fi
IFS="$ifs"; unset ifs

while true; do
    for item in "${@}"; do
        (( avail -= ${#item} ))
        if (( avail < 0 )); then
            exit 0
        fi

        echo -n "${item}"
    done
done
