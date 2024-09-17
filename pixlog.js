#!/usr/bin/env node
// geodebreaker 2024, MIT License
// please use Node 18 or higher

const http = require('http');
const webhook = process.argv[2];
const port = process.argv[3] ?? 8080;

if(!webhook) {
  console.error('You have not provided a Webhook URL for this script.\nPlease enter a Webhook URL as an argument.');
  process.exit(1);
}
if(!process.argv[3]) console.log('TIP: you can use the second argument as a port, otherwise it will default to 8080');

http.createServer((req, res) => {
  fetch(webhook, {
    method: 'POST',
    body: JSON.stringify({ content: `${Date()}: \`${req.socket.remoteAddress}\`, \`${req.url}\`` }),
    headers: { 'Content-Type' : 'application/json' }
  }).then(
    () => console.log('Success:', req.socket.remoteAddress, req.url),
    err => console.error('Fail:', err)
  );
  
  res.writeHead(200, { 'Content-Type': 'image/png' });
  res.end(Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAAtJREFUGFdjYAACAAAFAAGq1chRAAAAAElFTkSuQmCC', 'base64'));
}).listen(port, () => {
  console.log('Server running on port', port)
});
