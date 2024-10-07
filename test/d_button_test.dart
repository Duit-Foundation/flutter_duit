import "package:alchemist/alchemist.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget() {
  return {
    "type": "ElevatedButton",
    "id": "bId",
    "controlled": true,
    "action": {
      "executionType": 1, //local
      "event": "local_exec",
      "payload": {
        "type": "update",
        "updates": {
          "t1": {
            "data": "Pressed!",
            "style": {
              "fontSize": 24.0,
              "fontWeight": 800,
            }
          },
        }
      }
    },
    "attributes": {
      "autofocus": false,
    },
    "child": {
      "type": "Text",
      "id": "t1",
      "controlled": true,
      "attributes": {
        "data": "Press me!",
        "style": {
          "fontSize": 12.0,
          "fontWeight": 400,
        }
      },
    }
  };
}

void main() {
  group(
    "DuitButton widget tests",
    () {
      testWidgets("DuitButton pressed and key assignment", (t) async {
        await t.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost(
              driver: DuitDriver.static(
                _createWidget(),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              ),
            ),
          ),
        );

        await t.pumpAndSettle();

        final button = find.byKey(const Key("bId"));

        expect(button, findsOneWidget);

        await t.tap(button);

        await t.pumpAndSettle();

        expect(find.text("Pressed!"), findsOneWidget);
      });

      goldenTest("DuitButton base variant", fileName: "d_button", builder: () {
        return GoldenTestScenario(
          name: "Base variant",
          child: DuitViewHost(
            driver: DuitDriver.static(
              _createWidget(),
              transportOptions: HttpTransportOptions(),
              enableDevMetrics: false,
            ),
          ),
        );
      });

      final driver = DuitDriver.static(
        _createWidget(),
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
      );

      goldenTest(
        "DuitButton update",
        fileName: "d_button_upd",
        pumpBeforeTest: (t) async {
          await t.pumpAndSettle();
          final button = find.byKey(const Key("bId"));
          await t.tap(button);
          await t.pumpAndSettle();
        },
        builder: () {
          return GoldenTestScenario(
            name: "After update",
            child: DuitViewHost(
              driver: driver,
            ),
          );
        },
      );
    },
  );
}
