#!/bin/sh
# Usage: ./add-photo.sh ~/Desktop/IMG_1234.HEIC 3d/my-print   (folders: projects, manufacturing, 3d)
# Converts any photo (HEIC/PNG/JPG) to a web-sized JPEG at images/<name>.jpg
# and strips location/camera metadata. Uses macOS built-in sips, nothing to install.
set -e
[ $# -eq 2 ] || { echo "usage: $0 <photo> <name, e.g. sunland-1 or print-3>"; exit 1; }
out="$(dirname "$0")/images/$2.jpg"
sips -s format jpeg -s formatOptions 80 -Z 1600 "$1" --out "$out" >/dev/null
python3 -c "import sys;from PIL import Image,ImageOps;i=ImageOps.exif_transpose(Image.open(sys.argv[1]));i.save(sys.argv[1],quality=80)" "$out"  # drops EXIF incl. GPS, keeps rotation
echo "saved $out"
