#!/usr/bin/python

# This script is free of copyright restrictions.

import zlib
import sys

with open(sys.argv[1]) as f:
    content = f.readlines()

compressed = ''.join(content)

decompress = zlib.decompressobj(-zlib.MAX_WBITS)
inflated = decompress.decompress(compressed[14:])
inflated += decompress.flush()

print (inflated[:-1])

