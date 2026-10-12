const fs = require('fs');
const http = require('http');
const path = require('path');

const host = '127.0.0.1';
const port = 4183;
const root = __dirname;

const types = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.cjs': 'text/plain; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.webp': 'image/webp',
  '.svg': 'image/svg+xml',
  '.otf': 'font/otf',
  '.pdf': 'application/pdf'
};

function send(res, statusCode, body, contentType = 'text/plain; charset=utf-8') {
  res.writeHead(statusCode, {
    'Content-Type': contentType,
    'Cache-Control': 'no-store',
    'X-Content-Type-Options': 'nosniff'
  });
  res.end(body);
}

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${host}:${port}`);
  const requested = decodeURIComponent(url.pathname === '/' ? '/index.html' : url.pathname);
  const resolved = path.resolve(root, '.' + requested);

  if (!resolved.startsWith(root)) {
    send(res, 403, 'Forbidden');
    return;
  }

  fs.readFile(resolved, (error, data) => {
    if (error) {
      send(res, 404, 'Not found');
      return;
    }
    send(res, 200, data, types[path.extname(resolved).toLowerCase()] || 'application/octet-stream');
  });
});

server.on('error', (error) => {
  if (error.code === 'EADDRINUSE') process.exit(0);
  console.error(error);
  process.exit(1);
});

server.listen(port, host, () => {
  console.log(`Gwangyang B3 local site: http://${host}:${port}/index.html?present=1#/1`);
});
