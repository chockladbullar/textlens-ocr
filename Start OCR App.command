#!/bin/bash

# Get the folder where this script lives
DIR="$(cd "$(dirname "$0")" && pwd)"

# Start the Python server in the background
python3 "$DIR/ocr_server.py" &
SERVER_PID=$!

# Wait a moment for the server to start
sleep 1.5

# Open the app in the default browser
open "http://localhost:7777"

# Wait for the server process (keeps the window open)
wait $SERVER_PID
