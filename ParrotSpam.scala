#! /usr/bin/env scala

val MAX_CHARS = 4000

val parrots = args.filter(_.nonEmpty)
if (parrots.isEmpty) {
    Console.err.println("Nothing to repeat")
    System.exit(1)
}

var used = 0
Stream.continually(parrots).flatten.takeWhile(p => {
    used += p.length
    used <= MAX_CHARS
}).foreach(print)
