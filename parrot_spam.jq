#!/bin/bash --
# \
exec jq -n -r -f "${0}" --args "${@}"

def spam(avail):
    # Recursive functions that take parameters are very slow, so pass in all
    # data via the input and use a recursive function with no parameters.
    def _spam:
        if .avail >= (.input[.index] | length) then
            .avail -= (.input[.index] | length)
            | .output += .input[.index]
            | .index += 1
            | .index %= (.input | length)
            | _spam
        end
    ;

    {input: ., output: "", avail: avail, index: 0} | _spam | .output
;

$ARGS.positional

| if . == [] then
    "Nothing to repeat\n" | halt_error(1)
else
    spam(4000)
end
