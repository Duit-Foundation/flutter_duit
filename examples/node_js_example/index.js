const http = require("http");
const express = require("express");
const WebSocket = require("ws");
const { DuitView, DuitElementType, Widgets, ColoredBoxUiElement } = require("duit_js");
const { WebSocketAction } = require("duit_js");
const { SizedBoxUiElement } = require("duit_js");
const { TextUiElement } = require("duit_js");
const { CenterUiElement } = require("duit_js");
const { RowUiElement } = require("duit_js");
const { ElevatedButtonUiElement } = require("duit_js");

const app = express();

const server = http.createServer(app);

const webSocketServer = new WebSocket.Server({ server });

function createDynamicDuitView() {
   //create UIBuilder instance
   const builder = DuitView.builder();

   //create child elements tree
   const sizedBoxWithCentredText = new RowUiElement({ mainAxisAlignment: "spaceEvenly" }).addChild(new SizedBoxUiElement({ width: 100, height: 400 }).addChild(new ColoredBoxUiElement({ color: "#DCDCDC" }).addChild(new CenterUiElement({}).addChild(new TextUiElement({ data: "1123" }))))).addChild(new SizedBoxUiElement({ width: 120, height: 300 }).addChild(new ColoredBoxUiElement({ color: "#9e2f2f" }).addChild(new CenterUiElement({}).addChild(new ElevatedButtonUiElement({}, "button1", new WebSocketAction("event1", [])).addChild(new TextUiElement({ data: "1" }))))))

   //create view root and assing child/children to him
   builder.createRootOfExactType(DuitElementType.column, {}).addChild(sizedBoxWithCentredText);

   //return json string
   return builder.build();
}


webSocketServer.on('connection', ws => {
   ws.on('message', m => {
      webSocketServer.clients.forEach(client => client.send(m));
   });

   ws.on("error", e => ws.send(e));

   setTimeout(() => {
      ws.send(createDynamicDuitView());

   }, 3000);
});

server.listen(8999, () => console.log("Server started"))
