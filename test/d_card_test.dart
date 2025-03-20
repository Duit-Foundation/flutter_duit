import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "DuitCard widget tests",
    () {
      testWidgets("must build widget with default attributes", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "Card",
            "id": "card",
            "attributes": {
              "child": {
                "type": "Text",
                "id": "text",
                "attributes": {
                  "data": "Test Card",
                },
                "controlled": false
              }
            },
            "controlled": false,
          },
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

        final card = find.byKey(const ValueKey("card"));
        expect(card, findsOneWidget);

        final cWidget = tester.widget<Card>(card);
        expect(cWidget.color, isNull);
        expect(cWidget.shadowColor, isNull);
      });

      testWidgets("must build widget with custom attributes", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "Card",
            "id": "card",
            "attributes": {
              "color": "#FF0000",
              "elevation": 8.0,
              "margin": [16.0, 16.0, 16.0, 16.0],
              "shape": {
                "type": "RoundedRectangleBorder",
                "borderRadius": {
                  "topLeft": {
                    "radius": 8.0,
                    "side": {
                      "color": "#000000",
                      "width": 2.0,
                      "style": "solid",
                    }
                  },
                  "bottomRight": {
                    "radius": 8.0,
                  }
                }
              },
              "child": {
                "type": "Text",
                "id": "text",
                "attributes": {
                  "data": "Custom Card",
                },
                "controlled": false
              }
            },
            "controlled": false,
          },
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

        final card = find.byKey(const ValueKey("card"));
        expect(card, findsOneWidget);
      });

      testWidgets("must update controlled widget", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "Card",
            "id": "card",
            "attributes": {
              "color": "#FF0000",
              "elevation": 4.0,
              "child": {
                "type": "Text",
                "id": "text",
                "attributes": {
                  "data": "Card",
                },
                "controlled": false
              }
            },
            "controlled": true,
          },
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

        var card = find.byKey(const ValueKey("card"));
        expect(card, findsOneWidget);

        await driver.updateTestAttributes("card", {
          "color": "#00FF00",
          "elevation": 8.0,
        });

        await tester.pumpAndSettle();

        card = find.byKey(const ValueKey("card"));
        expect(card, findsOneWidget);

        final cardWidget = tester.widget<Card>(card);
        expect(cardWidget.color, const Color(0xFF00FF00));
      });
    },
  );
}
