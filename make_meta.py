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

output_data = {}

output_data["source_size"] = source_path.stat().st_size
output_data["result_size"] = modded_path.stat().st_size

with open(source, "rb") as f:
    source_digest_sha256 = hashlib.file_digest(f, "sha256")
    f.seek(0)
    source_digest_md5 = hashlib.file_digest(f, "md5")

output_data["source_sha256"] = source_digest_sha256.hexdigest()
output_data["source_md5"] = source_digest_md5.hexdigest()

with open(modded, "rb") as f:
    result_digest_sha256 = hashlib.file_digest(f, "sha256")
    f.seek(0)
    result_digest_md5 = hashlib.file_digest(f, "md5")

output_data["result_sha256"] = result_digest_sha256.hexdigest()
output_data["result_md5"] = result_digest_md5.hexdigest()

output_data["version"] = version

with open(output, "w") as f:
    f.write(json.dumps(output_data))