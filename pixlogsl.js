const webhook = process.env.WH;
export default async function handler(req, res) {
  if(req.url == '/' || req.url.startsWith('/favicon'))
    return res.status(404).end();
  const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
  await fetch(webhook, {
    method: 'POST',
    body: JSON.stringify({ content: `${Date().slice(0, -38)}: \`${ip}\`, \`${req.url.substring(1)}\`` }),
    headers: { 'Content-Type' : 'application/json' }
  }).then(
    () => console.log('Success:', ip, req.url.substring(1)),
    err => console.error('Fail:', err)
  );
  res.status(200).setHeader('Content-Type', 'image/png');
  res.end(Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAAtJREFUGFdjYAACAAAFAAGq1chRAAAAAElFTkSuQmCC', 'base64'));
}
