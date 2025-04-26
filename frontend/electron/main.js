import { app, BrowserWindow } from 'electron';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

function createWindow() {
  const win = new BrowserWindow({
    width: 425,
    height: 650,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
    },
  });

  win.loadURL('http://localhost:5173');
}

app.whenReady().then(createWindow);
// tweak 2025-04-24 commit #1
// tweak 2025-04-24 commit #1
// tweak 2025-04-24 commit #2
// tweak 2025-04-24 commit #3
// tweak 2025-04-24 commit #4
// tweak 2025-04-24 commit #5
// tweak 2025-04-25 commit #1
// tweak 2025-04-25 commit #2
// tweak 2025-04-25 commit #3
// tweak 2025-04-25 commit #4
// tweak 2025-04-25 commit #5
// tweak Fri Apr 25 03:11:55 IST 2025 commit #1
// tweak Fri Apr 25 03:11:55 IST 2025 commit #2
// tweak Fri Apr 25 03:11:55 IST 2025 commit #3
// tweak Fri Apr 25 03:11:55 IST 2025 commit #4
// tweak Fri Apr 25 03:11:55 IST 2025 commit #5
// tweak 2025-04-26 commit #1
// tweak 2025-04-26 commit #2
// tweak 2025-04-26 commit #3
