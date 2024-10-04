import "package:alchemist/alchemist.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget(String value, [bool? controlled = false]) {
  return {
    "type": "Align",
    "id": "alignId",
    "controlled": controlled,
    "attributes": {
      "alignment": value,
    },
    "child": {
      "type": "Container",
      "id": "con",
      "controlled": false,
      "attributes": {
        "color": "#DCDCDC",
        "width": 50,
        "height": 50,
      },
    }
  };
}

void main() {
  group(
    "DuitAlign widget tests",
    () {
      const dim = 100.0;

      goldenTest("DuitAlign base variants", fileName: "d_align", builder: () {
        return GoldenTestGroup(children: [
          GoldenTestScenario(
            name: "topCenter align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("topCenter"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "topLeft align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("topLeft"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "topRight align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("topRight"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "bottomCenter align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("bottomCenter"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "bottomLeft align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("bottomLeft"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "bottomRight align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("bottomRight"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "center align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("center"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "centerLeft align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("centerLeft"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "centerRight align",
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget("centerRight"),
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
              ),
            ),
          ),
        ]);
      });

      final driver = DuitDriver.static(
        _createWidget("topLeft", true),
        transportOptions: HttpTransportOptions(),
        enableDevMetrics: false,
      );

      goldenTest(
        "DuitAlign update via controller",
        fileName: "d_align_update",
        pumpBeforeTest: (t) async {
          await t.pumpAndSettle();

          await driver.updateTestAttributes("alignId", {
            "alignment": "bottomRight",
          });

          await t.pumpAndSettle();
        },
        builder: () {
          return GoldenTestScenario(
            name: "DuitAlign update result",
            child: Container(
              width: dim,
              height: dim,
              color: Colors.black,
              child: DuitViewHost(
                driver: driver,
              ),
            ),
          );
        },
      );

      testWidgets("DuitAlign key assignment", (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost(
              driver: DuitDriver.static(
                _createWidget("topLeft"),
                transportOptions: HttpTransportOptions(),
                enableDevMetrics: false,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final widget = find.byKey(
          const ValueKey("alignId"),
        );

        expect(widget, findsOneWidget);
      });
    },
  );
}
