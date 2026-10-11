#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
if [[ "$(uname -s)" != "Darwin" ]]; then echo "ERROR: Run on macOS"; exit 1; fi
python3 -m pip install pyinstaller customtkinter tkinterdnd2 pillow mutagen yt-dlp ytmusicapi certifi
mkdir -p output
for lang in ja en; do
  python3 -m PyInstaller --noconfirm --clean --windowed --name "ATRAC_Converter_${lang}" --collect-all customtkinter "ATRAC_Converter_${lang}.pyw"
  test -d "dist/ATRAC_Converter_${lang}.app"
  hdiutil create -volname "ATRAC Converter ${lang}" -srcfolder "dist/ATRAC_Converter_${lang}.app" -ov -format UDZO "output/ATRAC_Converter_${lang}.dmg"
done
