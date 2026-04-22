# TextLens OCR

**Read text from Azerbaijani images and PDFs on your Mac.**

TextLens OCR is a free, local app that extracts text from images and PDF files using Tesseract. It runs entirely on your Mac — no internet connection needed after setup, and your files never leave your computer.

---

## Download

1. Click the green **Code** button at the top of this page
2. Choose **Download ZIP**
3. Unzip the downloaded file — you will get a folder called `textlens-ocr-main`
4. Follow the setup instructions below

---

## Requirements

- Mac with Apple Silicon (M1, M2, M3) or Intel
- macOS 12 or later
- Internet connection during setup (not needed afterwards)
- About 1 GB of free storage

---

## Setup (One Time Only)

> **Before you start:** Because these files were downloaded from the internet, Mac will show a security warning the first time you open them. This is normal — follow step 1 carefully.

### Step 1 — Run the installer

1. Open the `textlens-ocr-main` folder
2. Find the file called **Step 1 - Open This First.command**
3. **Right-click** it and choose **Open** from the menu *(do not double-click)*

   ![Right-click menu showing Open option](screenshots/right-click-open.png)

4. A dialog will appear saying the file is from an unidentified developer — click **Open**

   ![Mac security dialog](screenshots/security-dialog.png)

5. A Terminal window will open, fix permissions automatically, and launch the installer
6. A second Terminal window will appear showing installation progress — **leave it open**

   ![Installer running](screenshots/installer-running.png)

7. If a dialog appears asking to install developer tools, click **Install** and wait for it to finish, then press **Enter** in the Terminal window
8. When you see **Installation Complete**, press Enter to close the window

> The installation takes about 10–15 minutes. You can leave it running in the background.

---

## Using the App

After setup, an **AzerbaijaniOCR** folder will appear on your Desktop.

1. Open the **AzerbaijaniOCR** folder on your Desktop
2. Double-click **Start OCR App.command**
3. A Terminal window will open — leave it alone while using the app
4. Your browser will open with the TextLens app

   ![TextLens app in browser](screenshots/app-browser.png)

5. Select a language from the dropdown (Azerbaijani is default)
6. Drag and drop an image or PDF, or click to browse
7. Click **Extract Text**
8. For PDFs, a progress bar shows which page is being processed

   ![PDF processing progress](screenshots/pdf-progress.png)

9. When done, save the result as **TXT**, **Word**, **PDF**, or **EPUB**

   ![Export options](screenshots/export-options.png)

> To stop the app, close the Terminal window. The browser tab can be closed any time.

---

## Supported Languages

| Option | Use for |
|--------|---------|
| Azerbaijani | Azerbaijani text (Latin script) |
| Azerbaijani + English | Documents mixing both languages |
| English only | English-only documents |

---

## Supported File Types

| Input | Output |
|-------|--------|
| PNG, JPG, TIFF | TXT |
| PDF (multi-page) | Word (.docx) |
| | PDF |
| | EPUB (e-book) |

---

## Troubleshooting

**Mac says the file cannot be opened because it is from an unidentified developer**
→ Right-click the file and choose **Open**, then click **Open** in the dialog. Do not double-click.

**Step 1 opens and closes immediately**
→ Make sure all five files are in the same folder before running Step 1.

**A dialog appeared asking to install developer tools**
→ Click **Install**, wait for it to finish, then press **Enter** in the Terminal window to continue.

**"Could not connect to server" in the app**
→ Close the browser tab and double-click **Start OCR App.command** again. Keep the Terminal window open while using the app.

**PDF processing is very slow**
→ This is normal for large files. A 400-page book may take 45–60 minutes. The app shows a live page counter and estimated time remaining. You can use your Mac normally while it runs.

**The app stopped working after a macOS update**
→ Run **Step 1 - Open This First.command** again. It will skip anything already installed and only fix what is needed.

---

## How It Works

TextLens OCR uses [Tesseract](https://github.com/tesseract-ocr/tesseract), a free open-source OCR engine developed by Google. Everything runs locally on your Mac — no data is sent to any server.

---

## License

Free to use for personal use.
