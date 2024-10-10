#!/usr/bin/env python

from __future__ import print_function

import itertools
import sys

def main():
    items = sys.argv[1:]

    if all(not x for x in items):
        print('Nothing to repeat', file=sys.stderr)
        return 1

    avail = 4000

    for item in itertools.cycle(items):
        if avail >= len(item):
            if sys.version_info.major >= 3:
                sys.stdout.buffer.write(item)
            else:
                sys.stdout.write(item)
            avail -= len(item)
        else:
            break

    return 0

if __name__ == '__main__':
    sys.exit(main())
