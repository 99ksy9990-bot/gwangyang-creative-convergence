let slideState = globalThis.__gwangyangSlideState || {
  type: 'slide-change',
  index: 1,
  sourceId: 'initial',
  at: 0
};

globalThis.__gwangyangSlideState = slideState;

function setHeaders(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Private-Network', 'true');
  res.setHeader('Cache-Control', 'no-store');
}

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

function parseBody(body) {
  if (!body) return {};
  if (typeof body === 'object') return body;
  return JSON.parse(body);
}

module.exports = function handler(req, res) {
  setHeaders(res);

  if (req.method === 'OPTIONS') {
    res.status(204).end();
    return;
  }

  if (req.method === 'POST') {
    try {
      const payload = parseBody(req.body);
      slideState = normalizeMessage(payload);
      globalThis.__gwangyangSlideState = slideState;
    } catch (error) {
      res.status(400).json({ error: 'Invalid slide sync payload' });
      return;
    }
  }

  res.status(200).json(slideState);
};
