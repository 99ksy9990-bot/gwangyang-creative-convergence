const http = require('http');

const host = '127.0.0.1';
const port = 4184;

let slideState = {
  type: 'slide-change',
  index: 1,
  sourceId: 'local-initial',
  at: 0
};

const headers = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'Content-Type',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Access-Control-Allow-Private-Network': 'true',
  'Cache-Control': 'no-store',
  'Content-Type': 'application/json; charset=utf-8'
};

function normalizeSlide(index) {
  const numeric = Number(index);
  if (!Number.isFinite(numeric)) return 1;
  return Math.max(1, Math.min(19, Math.round(numeric)));
}

function normalizeDelta(delta) {
  const numeric = Number(delta);
  if (!Number.isFinite(numeric) || numeric === 0) return 1;
  return numeric > 0 ? 1 : -1;
}

function normalizeMessage(payload) {
  const type = payload.type === 'slide-advance' ? 'slide-advance' : 'slide-change';
  const base = {
    type,
    sourceId: String(payload.sourceId || 'audience'),
    at: Number(payload.at) || Date.now()
  };
  if (type === 'slide-advance') {
    return {
      ...base,
      delta: normalizeDelta(payload.delta)
    };
  }
  return {
    ...base,
    index: normalizeSlide(payload.index)
  };
}

function send(res, statusCode, body) {
  res.writeHead(statusCode, headers);
  res.end(JSON.stringify(body));
}

const server = http.createServer((req, res) => {
  if (req.method === 'OPTIONS') {
    res.writeHead(204, headers);
    res.end();
    return;
  }

  if (!req.url.startsWith('/slide-sync')) {
    send(res, 404, { error: 'Not found' });
    return;
  }

  if (req.method === 'POST') {
    let raw = '';
    req.on('data', (chunk) => {
      raw += chunk;
      if (raw.length > 2048) req.destroy();
    });
    req.on('end', () => {
      try {
        const payload = JSON.parse(raw || '{}');
        slideState = normalizeMessage(payload);
        send(res, 200, slideState);
      } catch (error) {
        send(res, 400, { error: 'Invalid payload' });
      }
    });
    return;
  }

  send(res, 200, slideState);
});

server.on('error', (error) => {
  if (error.code === 'EADDRINUSE') process.exit(0);
  console.error(error);
  process.exit(1);
});

server.listen(port, host, () => {
  console.log(`Gwangyang B3 slide sync server: http://${host}:${port}/slide-sync`);
});
