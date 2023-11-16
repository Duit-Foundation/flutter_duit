const http = require("http");
const express = require( "express");
const WebSocket = require( "ws");

const app = express();

const server = http.createServer(app);

const webSocketServer = new WebSocket.Server({ server });

webSocketServer.on('connection', ws => {

   ws.on('message', m => {
webSocketServer.clients.forEach(client => client.send(m));
   });

   ws.on("error", e => ws.send(e));

   setTimeout(() => {
    ws.send(JSON.stringify({
      "type": "Text",
      "uncontrolled": false,
      "id": "ddf",
      "attributes": {"data": "TEST TEXT"},
      "action": {},
    }));
   }, 3000);

   setTimeout(() => {
    ws.send(JSON.stringify({
      "updates": {
        "ddf": {"data": "received!"}
      }
    }));
   }, 5000);
});

server.listen(8999, () => console.log("Server started"))