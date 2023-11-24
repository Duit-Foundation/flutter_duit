const http = require("http");
const express = require("express");
const WebSocket = require("ws");
const { DuitView, DuitElementType, Widgets, ColoredBoxUiElement, UpdateEvent } = require("duit_js");
const { WebSocketAction } = require("duit_js");
const { SizedBoxUiElement } = require("duit_js");
const { TextUiElement } = require("duit_js");
const { CenterUiElement } = require("duit_js");
const { RowUiElement } = require("duit_js");
const { ElevatedButtonUiElement } = require("duit_js");
const { HttpAction } = require("duit_js");

const app = express();

app.get("/layout", function (req, res) {
   console.log(req.headers);
   const layout = createDynamicDuitViewHttp();
   res.status(200).send(layout);
});

app.use("/test1", function (req, res) {
   console.log("ACTION OK")
   res.status(200).send(JSON.stringify(new UpdateEvent({ "mainRow": {mainAxisAlignment: "spaceEvenly"} })));
});

const server = http.createServer(app);

const webSocketServer = new WebSocket.Server({ server });

function createDynamicDuitViewHttp() {
   //create UIBuilder instance
   const builder = DuitView.builder();

   //create child elements tree
   const sizedBoxWithCentredText = new RowUiElement({ mainAxisAlignment: "end" }, "mainRow", undefined, true).addChild(new SizedBoxUiElement({ width: 100, height: 400 }).addChild(new ColoredBoxUiElement({ color: "#DCDCDC" }).addChild(new CenterUiElement({}).addChild(new TextUiElement({ data: "1123" }))))).addChild(new SizedBoxUiElement({ width: 120, height: 300 }).addChild(new ColoredBoxUiElement({ color: "#9e2f2f" }).addChild(new CenterUiElement({}).addChild(new ElevatedButtonUiElement({}, "button1", new HttpAction("/test1", {})).addChild(new TextUiElement({ data: "button" }))))))

   //create view root and assing child/children to him
   builder.createRootOfExactType(DuitElementType.column, {}).addChild(sizedBoxWithCentredText);

   //return json string
   return builder.build();
}

function createDynamicDuitView() {
   //create UIBuilder instance
   const builder = DuitView.builder();

   //create child elements tree
   const sizedBoxWithCentredText = new RowUiElement({ mainAxisAlignment: "spaceEvenly" }).addChild(new SizedBoxUiElement({ width: 100, height: 400 }).addChild(new ColoredBoxUiElement({ color: "#DCDCDC" }).addChild(new CenterUiElement({}).addChild(new TextUiElement({ data: "1123" }))))).addChild(new SizedBoxUiElement({ width: 120, height: 300 }).addChild(new ColoredBoxUiElement({ color: "#9e2f2f" }).addChild(new CenterUiElement({}).addChild(new ElevatedButtonUiElement({}, "button1", new WebSocketAction("event1", [])).addChild(new TextUiElement({ data: "button" }))))))

   //create view root and assing child/children to him
   builder.createRootOfExactType(DuitElementType.column, {}).addChild(sizedBoxWithCentredText);

   //return json string
   return builder.build();
}


webSocketServer.on('connection', ws => {
   ws.on('message', m => {
      // webSocketServer.clients.forEach(client => client.send(m));
      console.log(JSON.parse(m));
   });

   ws.on("error", e => ws.send(e));

   setTimeout(() => {
      ws.send(createDynamicDuitView());

   }, 3000);
});

server.listen(8999, () => console.log("Server started"))
