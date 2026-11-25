import express from 'express';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = Number(process.env.PORT) || 3000;
const HOST = '0.0.0.0';
const monitorDir = path.join(__dirname, 'monitor');

app.use((_req, res, next) => {
  res.setHeader('Permissions-Policy', 'serial=*');
  next();
});

app.use(express.static(monitorDir));

app.get('/', (_req, res) => {
  res.sendFile(path.join(monitorDir, 'index.html'));
});

app.listen(PORT, HOST, () => {
  console.log(`ESP Portal listening on http://${HOST}:${PORT}`);
});
