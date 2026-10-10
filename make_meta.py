import hashlib
import json
import sys

from pathlib import Path

if len(sys.argv) != 5:
    sys.exit(1)

source = sys.argv[1]
modded = sys.argv[2]
version = sys.argv[3]
output = sys.argv[4]

source_path = Path(source)
modded_path = Path(modded)

source_root = source_path.parent

output_data = {}

total_size = 0

item_list = []

source_hash = hashlib.new("sha256")

for entry in sorted(source_root.iterdir(), key=lambda entry: entry.name):
    if not entry.is_file():
        continue
    item_list.append(entry.name)
    total_size += entry.stat().st_size
    source_hash.update(entry.name.encode("utf-8"))

    with open(entry, "rb") as f:
        file_hash = hashlib.file_digest(f, "sha256")

    source_hash.update(file_hash.digest()) 

output_data["source_total_size"] = total_size 
output_data["source_file_list"] = item_list
output_data["source_total_hash"] = source_hash.hexdigest()
output_data["source_data_size"] = source_path.stat().st_size
output_data["result_size"] = modded_path.stat().st_size

with open(source, "rb") as f:
    source_digest_sha256 = hashlib.file_digest(f, "sha256")

output_data["source_sha256"] = source_digest_sha256.hexdigest()

with open(modded, "rb") as f:
    result_digest_sha256 = hashlib.file_digest(f, "sha256")

output_data["result_sha256"] = result_digest_sha256.hexdigest()

output_data["version"] = version

with open(output, "w") as f:
    f.write(json.dumps(output_data))