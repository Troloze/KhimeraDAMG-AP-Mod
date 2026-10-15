from pathlib import Path
import shutil
import sys
import zipfile

if len(sys.argv) != 2:
    sys.exit(1)

release_folder: Path = Path(sys.argv[1])

zip_path = release_folder.parent / f"{release_folder.name}.zip"

with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zf:
    for file in release_folder.rglob("*"):
        if file.is_file():
            zf.write(file, arcname=file.relative_to(release_folder).as_posix())

# Only remove folder after a full zip success.
shutil.rmtree(release_folder)