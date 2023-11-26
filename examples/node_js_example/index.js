const http = require("http");
const express = require("express");
const WebSocket = require("ws");
const { DuitView, DuitElementType, ColoredBoxUiElement, UpdateEvent, CustomTreeElement } = require("duit_js");
const { WebSocketAction } = require("duit_js");
const { SizedBoxUiElement } = require("duit_js");
const { TextUiElement } = require("duit_js");
const { CenterUiElement } = require("duit_js");
const { RowUiElement } = require("duit_js");
const { ElevatedButtonUiElement } = require("duit_js");
const { HttpAction } = require("duit_js");
const { ColumnUiElement } = require("duit_js");
const { randomUUID } = require("crypto");
const { TextFieldUiElement } = require("duit_js");
const bodyParser = require("body-parser");

const app = express();

class ExampleCustomWidget extends CustomTreeElement {

   constructor(attrs, tag, id, action, controlled) {
      super(attrs, tag, id, action, controlled);
   }
}

app.use(bodyParser.json())

const router = new express.Router();

router.get("/layout", function (req, res) {
   console.log(req.headers);
   const layout = createDynamicDuitViewHttp();
   res.status(200).send(layout);
});
router.get("/test1", function (req, res) {
   console.log("ACTION OK")
   res.status(200).send(JSON.stringify(new UpdateEvent({ "mainRow": {mainAxisAlignment: "spaceEvenly"} })));
});
router.post("/action1", function (req, res) {
   console.log(req.body);
   console.log(req.url);
   console.log(req.method);
   res.send({});
});
app.use(router);

const server = http.createServer(app);

const webSocketServer = new WebSocket.Server({ server });

function createDynamicDuitViewHttp() {
   //create UIBuilder instance
   const builder = DuitView.builder();

   const customWidget = new ExampleCustomWidget({"random": "string from custom widget"}, "ExampleCustomWidget");

   //create child elements tree
   const sizedBoxWithCentredText = new RowUiElement({ mainAxisAlignment: "center" }, "mainRow", undefined, true)
      .addChild(new SizedBoxUiElement({ width: 300, height: 450 })
         .addChild(new ColoredBoxUiElement({ color: "#DCDCDC" })
            .addChild(new ColumnUiElement({mainAxisAlignment: "spaceEvenly"})
               .addChild(new ColumnUiElement({})
                  .addChild(new TextUiElement({
                     data: "Акция!",
                     textAlign: "center",
                     style: {
                        fontSize: 26,
                        color: "#FFFFFF",
                        
                     }
                  }))
                  .addChild(new TextUiElement({
                     data: "ТОЛЬКО СЕГОДНЯ И БОЛЬШЕ НИКОГДА!!!!!!!!", 
                     textAlign: "center", 
                     style: {
                        fontSize: 21, 
                        color: "#3d1717",
                     }
                  }))
               )
               .addChild(new ColumnUiElement({})
               .addChildren([
                  new TextUiElement({data: "КУПИ 3 ПИРОЖКА ПО ЦЕНЕ 4!"}),
                  customWidget,
                  new TextUiElement({data: "АКЦИЯ ЧТО НАДО!"}),
                  new SizedBoxUiElement({width: 250, height: 45})
                     .addChild(new TextFieldUiElement({
                     maxLines: 1,
                     decoration: {
                        focusedBorder: {
                           type: "outline",
                              options: {
                              borderSide: {
                                 color: "#50782f",
                                 width: 10.0
                              },
                              borderRadius: 2.1,
                              },
               
                        },
                        border: {
                           type: "outline",
                           options: {
                           borderSide: {
                              color: "#4287f5",
                              width: 3.0
                           },
                           borderRadius: 2.1
                        },
                        },
                     }
                     }, "input")),
                     new ElevatedButtonUiElement({}, undefined, new HttpAction("/action1", {method: "POST"}, [{id: "input", target: "input_value"}]))
                        .addChild(new TextUiElement({data: "Подтвертить"}))
               ])
               )
            )
         )
      )

   //create view root and assing child/children to him
   builder.createRootOfExactType(DuitElementType.column, {})
      .addChild(sizedBoxWithCentredText)

   //return json string
   return builder.build();
}

function createDynamicDuitView() {
   //create UIBuilder instance
   const builder = DuitView.builder();

   //create child elements tree
   const sizedBoxWithCentredText = new RowUiElement({ mainAxisAlignment: "spaceEvenly" }).addChild(new SizedBoxUiElement({ width: 100, height: 400 }).addChild(new ColoredBoxUiElement({ color: "#DCDCDC" }).addChild(new CenterUiElement({}).addChild(new TextUiElement({ data: "1123" }))))).addChild(new SizedBoxUiElement({ width: 120, height: 300 }).addChild(new ColoredBoxUiElement({ color: "#9e2f2f" }).addChild(new CenterUiElement({}).addChild(new ElevatedButtonUiElement({}, "button1", new WebSocketAction("event1", [])).addChild(new TextUiElement({ data: "button" }))))))

   //create view root and assing child/children to him
   builder.createRootOfExactType(DuitElementType.column, {}).addChild(sizedBoxWithCentredText)

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
