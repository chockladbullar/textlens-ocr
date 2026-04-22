#!/bin/bash

# TextLens OCR - One-click installer
# Installs everything needed to run the app

set -e

DESKTOP="$HOME/Desktop"
APP_DIR="$DESKTOP/AzerbaijaniOCR"
LOG="$DESKTOP/textlens_install_log.txt"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

log() { echo "$1" | tee -a "$LOG"; }
step() { echo -e "\n${BLUE}${BOLD}▶ $1${NC}" | tee -a "$LOG"; }
ok() { echo -e "${GREEN}✔ $1${NC}" | tee -a "$LOG"; }
warn() { echo -e "${YELLOW}⚠ $1${NC}" | tee -a "$LOG"; }
fail() { echo -e "${RED}✘ $1${NC}" | tee -a "$LOG"; }

clear
echo -e "${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║        TextLens OCR Installer        ║"
echo "  ║     Azerbaijani Text Recognition     ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"
echo "This will install everything needed to run TextLens OCR."
echo "It may take 10-15 minutes. Please leave this window open."
echo ""
echo "A log will be saved to: $LOG"
echo ""

# Start log
echo "TextLens OCR Install Log - $(date)" > "$LOG"
echo "======================================" >> "$LOG"

# ── Step 1: Xcode Command Line Tools ──────────────────────────────────────────
step "Step 1/7: Checking Xcode Command Line Tools..."
if xcode-select -p &>/dev/null; then
  ok "Xcode Command Line Tools already installed."
else
  warn "Installing Xcode Command Line Tools (a dialog may appear)..."
  xcode-select --install 2>> "$LOG" || true
  echo ""
  echo "  A dialog box may have appeared asking you to install developer tools."
  echo "  Please click Install and wait for it to finish, then press Enter here."
  read -p "  Press Enter when the Xcode tools installation is complete... "
fi

# ── Step 2: Homebrew ───────────────────────────────────────────────────────────
step "Step 2/7: Installing Homebrew..."
if command -v brew &>/dev/null; then
  ok "Homebrew already installed."
else
  warn "Installing Homebrew (this may take a few minutes)..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> "$LOG" 2>&1

  # M1/M2 Macs need PATH setup
  if [[ $(uname -m) == "arm64" ]]; then
    if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile 2>/dev/null; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Ensure brew is on PATH
if ! command -v brew &>/dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null
fi

ok "Homebrew ready."

# ── Step 3: Tesseract ──────────────────────────────────────────────────────────
step "Step 3/7: Installing Tesseract OCR engine..."
if command -v tesseract &>/dev/null; then
  ok "Tesseract already installed."
else
  brew install tesseract >> "$LOG" 2>&1
  ok "Tesseract installed."
fi

# ── Step 4: Azerbaijani language pack ─────────────────────────────────────────
step "Step 4/7: Installing Azerbaijani language pack..."
if tesseract --list-langs 2>/dev/null | grep -q "^aze$"; then
  ok "Azerbaijani language pack already installed."
else
  brew install tesseract-lang-aze >> "$LOG" 2>&1 || {
    warn "tesseract-lang-aze not found via brew, trying full language pack..."
    brew install tesseract-lang >> "$LOG" 2>&1
  }
  ok "Azerbaijani language pack installed."
fi

# ── Step 5: Python libraries ───────────────────────────────────────────────────
step "Step 5/7: Installing Python libraries..."
pip3 install pytesseract pillow pdf2image --break-system-packages --quiet >> "$LOG" 2>&1 || \
pip3 install pytesseract pillow pdf2image --quiet >> "$LOG" 2>&1
ok "Python libraries installed."

# ── Step 6: Poppler ────────────────────────────────────────────────────────────
step "Step 6/7: Installing Poppler (PDF support)..."
if command -v pdftoppm &>/dev/null; then
  ok "Poppler already installed."
else
  brew install poppler >> "$LOG" 2>&1
  ok "Poppler installed."
fi

# ── Step 7: Set up app folder ─────────────────────────────────────────────────
step "Step 7/7: Setting up the app..."

# Create app folder if it doesn't exist
mkdir -p "$APP_DIR"

# Copy app files from same directory as this installer
INSTALLER_DIR="$(cd "$(dirname "$0")" && pwd)"

for f in "ocr_app.html" "ocr_server.py" "Start OCR App.command"; do
  if [ -f "$INSTALLER_DIR/$f" ]; then
    cp "$INSTALLER_DIR/$f" "$APP_DIR/$f"
  else
    fail "Missing file: $f — make sure it is in the same folder as this installer."
    echo ""
    echo "Please contact the person who sent you this installer for a complete copy."
    read -p "Press Enter to exit..."
    exit 1
  fi
done

# Make launcher executable
chmod +x "$APP_DIR/Start OCR App.command"
ok "App files copied to Desktop."

# ── Done ───────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║       Installation Complete!         ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${NC}"
echo "  TextLens OCR is ready to use."
echo ""
echo "  To open the app:"
echo "  1. Go to your Desktop"
echo "  2. Open the AzerbaijaniOCR folder"
echo "  3. Double-click 'Start OCR App.command'"
echo ""
echo "  The app will open in your web browser."
echo ""
read -p "  Press Enter to close this window..."
