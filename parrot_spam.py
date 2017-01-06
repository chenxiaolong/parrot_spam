#!/usr/bin/env python

from __future__ import print_function

import itertools
import sys

if sys.version_info.major == 2:
    range_generator = xrange
else:
    range_generator = range

def main():
    if len(sys.argv) < 2:
        print('Nothing to repeat', file=sys.stderr)
        return 1

    items = list()
    for i in range_generator(1, len(sys.argv)):
        if sys.version_info.major >= 3:
            item = sys.argv[i].encode('UTF-8')
        else:
            item = sys.argv[i]
        items.append((item, len(item)))

    avail = 4000

    for item, length in itertools.cycle(items):
        if avail >= length:
            if sys.version_info.major >= 3:
                sys.stdout.buffer.write(item)
            else:
                sys.stdout.write(item)
            avail -= length
        else:
            break

    return 0

if __name__ == '__main__':
    sys.exit(main())
