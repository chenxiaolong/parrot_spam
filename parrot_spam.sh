#!/bin/bash

avail=4000
total=0

for item in "${@}"; do
    let "total += ${#item}"
done

if [[ "${total}" -eq 0 ]]; then
    echo 'Nothing to repeat' >&2
    exit 1
fi

while true; do
    for item in "${@}"; do
        if [[ "${avail}" -lt "${#item}" ]]; then
            exit 0
        fi
        echo -n "${item}"
        let "avail -= ${#item}"
    done
done
