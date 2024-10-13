#!/usr/bin/env tclsh

proc spam { chars_left parrots } {
    while true {
        foreach parrot $parrots {
            incr chars_left -[string length $parrot]
            if {$chars_left < 0} {
                puts ""
                return
            }
            puts -nonewline $parrot
        }
    }
}

set parrots {}
foreach arg $argv {
    if {[string length $arg] > 0} {
        lappend parrots $arg
    }
}
if {[llength $parrots] == 0} {
    puts stderr "Nothing to repeat"
    exit 1
}

spam 4000 $parrots
