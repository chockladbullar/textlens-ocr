#!/usr/bin/env python3
import http.server
import json
import base64
import tempfile
import os
import subprocess
from pathlib import Path

PORT = 7777

class OCRHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass  # silence logs

    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            html_path = Path(__file__).parent / 'ocr_app.html'
            self.wfile.write(html_path.read_bytes())

    def do_POST(self):
        if self.path == '/ocr':
            length = int(self.headers['Content-Length'])
            body = json.loads(self.rfile.read(length))
            image_data = base64.b64decode(body['image'])
            lang = body.get('lang', 'aze')

            with tempfile.NamedTemporaryFile(suffix='.png', delete=False) as f:
                f.write(image_data)
                tmp_path = f.name

            out_path = tmp_path + '_out'
            try:
                result = subprocess.run(
                    ['tesseract', tmp_path, out_path, '-l', lang],
                    capture_output=True, text=True
                )
                text = Path(out_path + '.txt').read_text()
            except Exception as e:
                text = f'Error: {e}'
            finally:
                os.unlink(tmp_path)
                try: os.unlink(out_path + '.txt')
                except: pass

            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({'text': text}).encode())

    def do_OPTIONS(self):
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        self.end_headers()

print(f"OCR server running — open http://localhost:{PORT} in your browser")
http.server.HTTPServer(('', PORT), OCRHandler).serve_forever()
