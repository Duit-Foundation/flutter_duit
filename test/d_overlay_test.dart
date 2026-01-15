import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "OverlayTriggerListener test",
    () {
      group("Dialog", () {
        testWidgets(
          "must open, close and evaluate action on Dialog close",
          (tester) async {
            final driver = XDriver.static(
              {
                "type": "ElevatedButton",
                "id": "bId",
                "controlled": true,
                "action": {
                  "executionType": 1, //local
                  "event": "local_exec",
                  "payload": {
                    "type": "command",
                    "controllerId": overlayTriggerId,
                    "commandData": {
                      "type": "dialog",
                      "action": "open",
                      "onClose": {
                        "executionType": 1, //local
                        "event": "local_exec",
                        "payload": {
                          "type": "update",
                          "updates": {
                            "button_text": {
                              "data": "Dialog closed",
                            },
                          },
                        },
                      },
                      "content": {
                        "type": "Column",
                        "id": "col1",
                        "children": [
                          {
                            "type": "Text",
                            "id": "bs_text",
                            "controlled": true,
                            "attributes": {
                              "data": "Dialog",
                              "style": <String, dynamic>{
                                "fontSize": 24.0,
                                "fontWeight": 800,
                              },
                            },
                          },
                          {
                            "type": "ElevatedButton",
                            "id": "closeButton",
                            "controlled": true,
                            "action": {
                              "executionType": 1, //local
                              "event": "local_exec",
                              "payload": {
                                "type": "command",
                                "controllerId": overlayTriggerId,
                                "commandData": {
                                  "type": "dialog",
                                  "action": "close",
                                },
                              },
                            },
                          }
                        ],
                      },
                    },
                  },
                },
                "attributes": {
                  "autofocus": false,
                },
                "child": {
                  "type": "Text",
                  "id": "button_text",
                  "controlled": true,
                  "attributes": {
                    "data": "Press me!",
                    "style": <String, dynamic>{
                      "fontSize": 12.0,
                      "fontWeight": 400,
                    },
                  },
                },
              },
            );

            await pumpDriver(tester, driver.asInternalDriver);

            var dialogContentKey = find.byKey(const ValueKey("bs_text"));
            var dialogText = find.text("Dialog");
            var buttonText = find.text("Press me!");

            expect(dialogContentKey, findsNothing);
            expect(dialogText, findsNothing);
            expect(buttonText, findsOneWidget);

            await tester.tap(find.byKey(const ValueKey("bId")));
            await tester.pumpAndSettle();

            dialogContentKey = find.byKey(const ValueKey("bs_text"));
            dialogText = find.text("Dialog");

            expect(dialogContentKey, findsOneWidget);
            expect(dialogText, findsOneWidget);

            await tester.tap(find.byKey(const ValueKey("closeButton")));
            await tester.pumpAndSettle();

            dialogContentKey = find.byKey(const ValueKey("bs_text"));
            dialogText = find.text("Dialog");
            buttonText = find.text("Press me!");
            final closedText = find.text("Dialog closed");

            expect(dialogContentKey, findsNothing);
            expect(dialogText, findsNothing);
            expect(buttonText, findsNothing);
            expect(closedText, findsOneWidget);
          },
        );
      });
      group(
        "BottomSheet",
        () {
          testWidgets(
            "must open, close and evaluate action on BottomSheet close",
            (tester) async {
              final driver = XDriver.static(
                {
                  "type": "ElevatedButton",
                  "id": "bId",
                  "controlled": true,
                  "action": {
                    "executionType": 1, //local
                    "event": "local_exec",
                    "payload": {
                      "type": "command",
                      "controllerId": overlayTriggerId,
                      "commandData": {
                        "type": "bottomSheet",
                        "action": "open",
                        "onClose": {
                          "executionType": 1, //local
                          "event": "local_exec",
                          "payload": {
                            "type": "update",
                            "updates": {
                              "button_text": {
                                "data": "BottomSheet closed",
                              },
                            },
                          },
                        },
                        "content": {
                          "type": "Column",
                          "id": "col1",
                          "children": [
                            {
                              "type": "Text",
                              "id": "bs_text",
                              "controlled": true,
                              "attributes": {
                                "data": "BottomSheet",
                                "style": <String, dynamic>{
                                  "fontSize": 24.0,
                                  "fontWeight": 800,
                                },
                              },
                            },
                            {
                              "type": "ElevatedButton",
                              "id": "closeButton",
                              "controlled": true,
                              "action": {
                                "executionType": 1, //local
                                "event": "local_exec",
                                "payload": {
                                  "type": "command",
                                  "controllerId": overlayTriggerId,
                                  "commandData": {
                                    "type": "bottomSheet",
                                    "action": "close",
                                  },
                                },
                              },
                            }
                          ],
                        },
                      },
                    },
                  },
                  "attributes": {
                    "autofocus": false,
                  },
                  "child": {
                    "type": "Text",
                    "id": "button_text",
                    "controlled": true,
                    "attributes": {
                      "data": "Press me!",
                      "style": <String, dynamic>{
                        "fontSize": 12.0,
                        "fontWeight": 400,
                      },
                    },
                  },
                },
              );

              await pumpDriver(tester, driver.asInternalDriver);

              var bottomSheetContentKey = find.byKey(const ValueKey("bs_text"));
              var bottomSheetText = find.text("BottomSheet");
              var buttonText = find.text("Press me!");

              expect(bottomSheetContentKey, findsNothing);
              expect(bottomSheetText, findsNothing);
              expect(buttonText, findsOneWidget);

              await tester.tap(find.byKey(const ValueKey("bId")));
              await tester.pumpAndSettle();

              bottomSheetContentKey = find.byKey(const ValueKey("bs_text"));
              bottomSheetText = find.text("BottomSheet");

              expect(bottomSheetContentKey, findsOneWidget);
              expect(bottomSheetText, findsOneWidget);

              await tester.tap(find.byKey(const ValueKey("closeButton")));
              await tester.pumpAndSettle();

              bottomSheetContentKey = find.byKey(const ValueKey("bs_text"));
              bottomSheetText = find.text("BottomSheet");
              buttonText = find.text("Press me!");
              final closedText = find.text("BottomSheet closed");

              expect(bottomSheetContentKey, findsNothing);
              expect(bottomSheetText, findsNothing);
              expect(buttonText, findsNothing);
              expect(closedText, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
