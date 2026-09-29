import sys
import hashlib

if len(sys.argv) != 3:
    sys.exit(1)

file = sys.argv[1]
output = sys.argv[2]

with open(file, "rb") as f:
    digest = hashlib.file_digest(f, "sha256")

hash_value = digest.hexdigest()

with open(output, "w") as f:
    f.write(hash_value)