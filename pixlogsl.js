const webhook = process.env.WH;
export default async function handler(req, res) {
  await fetch(webhook, {
    method: 'POST',
    body: JSON.stringify({ content: `${Date()}: \`${req.socket.remoteAddress}\`, \`${req.url}\`` }),
    headers: { 'Content-Type' : 'application/json' }
  }).then(
    () => console.log('Success:', req.socket.remoteAddress, req.url),
    err => console.error('Fail:', err)
  );
  
  res.status(200).setHeader('Content-Type', 'image/png');
  res.end(Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAAtJREFUGFdjYAACAAAFAAGq1chRAAAAAElFTkSuQmCC', 'base64'));
}
