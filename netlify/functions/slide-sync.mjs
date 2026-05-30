let slideState = globalThis.__gwangyangSlideState || {
  type: 'slide-change',
  index: 1,
  sourceId: 'initial',
  at: 0
};

globalThis.__gwangyangSlideState = slideState;

const headers = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'Content-Type',
  'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
  'Cache-Control': 'no-store'
};

function normalizeSlide(index) {
  const numeric = Number(index);
  if (!Number.isFinite(numeric)) return 1;
  return Math.max(1, Math.min(16, Math.round(numeric)));
}

export async function handler(event) {
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 204, headers, body: '' };
  }

  if (event.httpMethod === 'POST') {
    try {
      const payload = JSON.parse(event.body || '{}');
      slideState = {
        type: 'slide-change',
        index: normalizeSlide(payload.index),
        sourceId: String(payload.sourceId || 'audience'),
        at: Number(payload.at) || Date.now()
      };
      globalThis.__gwangyangSlideState = slideState;
    } catch (error) {
      return {
        statusCode: 400,
        headers,
        body: JSON.stringify({ error: 'Invalid slide sync payload' })
      };
    }
  }

  return {
    statusCode: 200,
    headers,
    body: JSON.stringify(slideState)
  };
}
