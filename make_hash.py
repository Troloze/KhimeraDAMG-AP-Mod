import sys
import hashlib
import json


if len(sys.argv) != 5:
    sys.exit(1)

source = sys.argv[1]
modded = sys.argv[2]
version = sys.argv[3]
output = sys.argv[4]

hash_data = {}

with open(source, "rb") as f:
    digest_sha256 = hashlib.file_digest(f, "sha256")
    digest_md5 = hashlib.file_digest(f, "md5")

hash_data["source_sha256"] = digest_sha256.hexdigest()
hash_data["source_md5"] = digest_md5.hexdigest()

with open(modded, "rb") as f:
    digest_sha256 = hashlib.file_digest(f, "sha256")
    digest_md5 = hashlib.file_digest(f, "md5")

hash_data["result_sha256"] = digest_sha256.hexdigest()
hash_data["result_md5"] = digest_md5.hexdigest()

hash_data["version"] = version

with open(output, "w") as f:
    f.write(json.dumps(hash_data))