import sys
import bsdiff4

if len(sys.argv) != 4:
    sys.exit(1)

source = sys.argv[1]
modded = sys.argv[2]
output = sys.argv[3]

bsdiff4.file_diff(source, modded, output)
