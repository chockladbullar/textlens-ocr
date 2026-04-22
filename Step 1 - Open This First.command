#!/bin/bash

# TextLens OCR - Bootstrap
# Fixes permissions and launches the installer

DIR="$(cd "$(dirname "$0")" && pwd)"

clear
echo ""
echo "  ╔══════════════════════════════════════╗"
echo "  ║        TextLens OCR Setup            ║"
echo "  ║     Setting up permissions...        ║"
echo "  ╚══════════════════════════════════════╝"
echo ""

# Fix permissions on all .command files in the folder
chmod +x "$DIR/"*.command 2>/dev/null

echo "  Ready! Launching the installer now..."
echo ""
sleep 1

# Launch the real installer
open "$DIR/Install TextLens OCR.command"

# Close this window
exit 0
