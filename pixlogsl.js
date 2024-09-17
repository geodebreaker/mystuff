const webhook = process.env.WH;
export default async function handler(req, res) {
  const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
  await fetch(webhook, {
    method: 'POST',
    body: JSON.stringify({ content: `${Date().slice(0, -33)}: \`${ip}\`, \`${req.url}\`` }),
    headers: { 'Content-Type' : 'application/json' }
  }).then(
    () => console.log('Success:', ip, req.url),
    err => console.error('Fail:', err)
  );
  
  res.status(200).setHeader('Content-Type', 'image/png');
  res.end(Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAAtJREFUGFdjYAACAAAFAAGq1chRAAAAAElFTkSuQmCC', 'base64'));
}
