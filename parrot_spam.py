#!/usr/bin/env python

from __future__ import print_function

import sys

if sys.version_info.major == 2:
    range_generator = xrange
else:
    range_generator = range

def repeated(generator):
    while True:
        for i in generator:
            yield i

def main():
    if len(sys.argv) < 2:
        print('Nothing to repeat', file=sys.stderr)
        return 1

    items = list()
    for i in range_generator(1, len(sys.argv)):
        items.append((sys.argv[i], len(sys.argv[i])))

    avail = 4000

    for item, length in repeated(items):
        if avail >= length:
            sys.stdout.write(item)
            avail -= length
        else:
            break

    return 0

if __name__ == '__main__':
    sys.exit(main())
