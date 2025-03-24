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

      const alignments = [
        "topLeft",
        "topCenter",
        "topRight",
        "centerLeft",
        "center",
        "centerRight",
        "bottomLeft",
        "bottomCenter",
        "bottomRight",
      ];

      const values = [
        Alignment.topLeft,
        Alignment.topCenter,
        Alignment.topRight,
        Alignment.centerLeft,
        Alignment.center,
        Alignment.centerRight,
        Alignment.bottomLeft,
        Alignment.bottomCenter,
        Alignment.bottomRight,
      ];

      testWidgets("check element alignment", (tester) async {
        final driver = DuitDriver.static(
          _createWidget(alignments.first, true),
          transportOptions: HttpTransportOptions(),
          enableDevMetrics: false,
        );

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox.square(
              dimension: dim,
              child: DuitViewHost(
                driver: driver,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        const key = ValueKey("alignId");

        for (var i = 1; i < alignments.length; i++) {
          final v = alignments[i];

          await driver.updateTestAttributes("alignId", {
            "alignment": v,
          });
          await tester.pumpAndSettle();

          final widget = tester.widget(find.byKey(key)) as Align;

          expect(widget.alignment, values[i]);
        }
      });

      testWidgets("check widget key assignment", (tester) async {
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

      testWidgets("must update attributes", (tester) async {
        final driver = DuitDriver.static(
          _createWidget("topLeft", true),
          transportOptions: EmptyTransportOptions(),
          enableDevMetrics: false,
        );
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost(
              driver: driver,
            ),
          ),
        );

        await tester.pumpAndSettle();

        await driver.updateTestAttributes("alignId", {
          "alignment": "bottomRight",
        });

        await tester.pumpAndSettle();

        final widget =
            tester.widget(find.byKey(const ValueKey("alignId"))) as Align;

        expect(widget.alignment, equals(Alignment.bottomRight));
      });
    },
  );
}
