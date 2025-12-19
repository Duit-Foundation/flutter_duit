// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group(
    "DuitFocusNodeManager tests",
    () {
      testWidgets(
        "manager methods",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Container",
              "id": "pdng",
              "attributes": {
                "margin": [16, 16],
                "color": Colors.amber,
              },
              "child": {
                "type": "Column",
                "id": "1",
                "children": [
                  {
                    "type": "Text",
                    "id": "txt1",
                    "attributes": {"data": "Input 1"},
                  },
                  {
                    "type": "TextField",
                    "id": "tf1",
                    "attributes": {
                      "focusNode": {
                        "debugLabel": "tf1_label",
                      },
                      "inputDecoration": const InputDecoration(
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                      ),
                    },
                  },
                  {
                    "type": "Text",
                    "id": "txt2",
                    "attributes": {"data": "Input 2"},
                  },
                  {
                    "type": "TextField",
                    "id": "tf2",
                    "attributes": const {
                      "focusNode": {
                        "debugLabel": "tf2_label",
                      },
                      "inputDecoration": InputDecoration(
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                      ),
                    },
                  },
                ],
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Directionality(
                textDirection: TextDirection.ltr,
                child: Material(
                  child: FocusScope(
                    child: DuitViewHost(
                      driver: driver,
                    ),
                  ),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final node = driver.getNode("tf1");
          expect(node, isA<FocusNode>());

          driver.focusInDirection("tf1", TraversalDirection.down);
          driver.nextFocus("tf1");
          driver.previousFocus("tf1");
          driver.unfocus("tf1");
          driver.requestFocus("tf2");

          expect(
            () => driver.focusInDirection("", TraversalDirection.down),
            throwsA(isA<MissingFocusNodeException>()),
          );
          expect(
            () => driver.nextFocus(""),
            throwsA(isA<MissingFocusNodeException>()),
          );
          expect(
            () => driver.previousFocus(""),
            throwsA(isA<MissingFocusNodeException>()),
          );
          expect(
            () => driver.unfocus(""),
            throwsA(isA<MissingFocusNodeException>()),
          );
          expect(
            () => driver.requestFocus(""),
            throwsA(isA<MissingFocusNodeException>()),
          );
        },
      );

      testWidgets(
        "focus commands",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Container",
              "id": "pdng",
              "attributes": {
                "margin": [16, 16],
                "color": Colors.amber,
              },
              "child": {
                "type": "Column",
                "id": "1",
                "children": [
                  {
                    "type": "Text",
                    "id": "txt1",
                    "attributes": {"data": "Input 1"},
                  },
                  {
                    "type": "TextField",
                    "id": "tf1",
                    "attributes": {
                      "focusNode": {
                        "debugLabel": "tf1_label",
                      },
                      "inputDecoration": const InputDecoration(
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                      ),
                    },
                  },
                  {
                    "type": "Text",
                    "id": "txt2",
                    "attributes": {"data": "Input 2"},
                  },
                  {
                    "type": "TextField",
                    "id": "tf2",
                    "attributes": const {
                      "focusNode": {
                        "debugLabel": "tf2_label",
                      },
                      "inputDecoration": InputDecoration(
                        focusColor: Colors.red,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        filled: true,
                      ),
                    },
                  },
                ],
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await tester.pumpWidget(
            MaterialApp(
              home: Directionality(
                textDirection: TextDirection.ltr,
                child: Material(
                  child: FocusScope(
                    child: DuitViewHost(
                      driver: driver,
                    ),
                  ),
                ),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final nextFocus = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "tf1",
                "commandData": {
                  "type": "focusNode",
                  "action": "nextFocus",
                },
              },
            },
          );

          final prevFocus = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "tf2",
                "commandData": {
                  "type": "focusNode",
                  "action": "previousFocus",
                },
              },
            },
          );

          final unfocus = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "tf2",
                "commandData": {
                  "type": "focusNode",
                  "action": "unfocus",
                },
              },
            },
          );

          final inDir = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "tf2",
                "commandData": {
                  "type": "focusNode",
                  "action": "focusInDirection",
                  "direction": "down",
                },
              },
            },
          );

          final reqFocus = ServerAction.parse(
            {
              "executionType": 1, //local
              "event": "local_exec",
              "payload": {
                "type": "command",
                "controllerId": "tf1",
                "commandData": {
                  "type": "focusNode",
                  "action": "requestFocus",
                },
              },
            },
          );

          final node = driver.getNode("tf1");
          final node2 = driver.getNode("tf2");
          expect(node, isA<FocusNode>());
          expect(node2, isA<FocusNode>());

          await driver.execute(nextFocus);
          await tester.pump();
          expect(node!.hasFocus, true);
          expect(node2!.hasFocus, false);

          await driver.execute(prevFocus);
          await tester.pump();
          expect(node.hasFocus, false);
          expect(node2.hasFocus, true);

          await driver.execute(unfocus);
          await tester.pump();
          expect(node.hasFocus, false);
          expect(node2.hasFocus, false);

          await driver.execute(inDir);
          await tester.pump();
          expect(node.hasFocus, false);
          expect(node2.hasFocus, true);

          await driver.execute(reqFocus);
          await tester.pump();
          expect(node.hasFocus, true);
          expect(node2.hasFocus, false);
        },
      );
    },
  );
}
