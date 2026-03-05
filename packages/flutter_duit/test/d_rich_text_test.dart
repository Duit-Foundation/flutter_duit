import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget({
  bool isControlled = false,
  Map<String, dynamic>? textSpan,
}) {
  return {
    "type": "RichText",
    "id": "richTextId",
    "controlled": isControlled,
    "attributes": {
      "textSpan": textSpan ??
          {
            "text": "Hello, RichText!",
            "style": {"color": "#075eeb", "fontSize": 16.0},
          },
    },
  };
}

void main() {
  group("DuitRichText widget tests", () {
    testWidgets("check widget", (tester) async {
      final driver = XDriver.static(
        _createWidget(),
      );
      await pumpDriver(tester, driver.asInternalDriver);
      expect(find.byKey(const Key("richTextId")), findsOneWidget);
      expect(find.text("Hello, RichText!"), findsOneWidget);
    });

    testWidgets("controlled widget renders and updates textSpan",
        (tester) async {
      final driver = XDriver.static(
        _createWidget(isControlled: true),
      );
      await pumpDriver(tester, driver.asInternalDriver);
      expect(find.byKey(const Key("richTextId")), findsOneWidget);
      expect(find.text("Hello, RichText!"), findsOneWidget);

      await driver.asInternalDriver.updateAttributes(
        "richTextId",
        {
          "textSpan": {
            "text": "Updated RichText!",
            "style": {"color": "#03fcc2", "fontSize": 18.0},
          },
        },
      );
      await tester.pumpAndSettle();
      expect(find.text("Updated RichText!"), findsOneWidget);
    });

    testWidgets("renders deeply nested textSpans", (tester) async {
      final nestedSpan = {
        "text": "Root ",
        "children": [
          {
            "text": "Level 1 ",
            "style": {"color": "#075eeb", "fontSize": 14.0},
            "children": [
              {
                "text": "Level 2 ",
                "style": {"color": "#03fcc2", "fontSize": 12.0},
                "children": [
                  {
                    "text": "Level 3",
                    "style": {"color": "#ff0000", "fontSize": 10.0},
                  }
                ],
              }
            ],
          },
          {
            "text": "Sibling 1",
            "style": {"color": "#00ff00", "fontSize": 14.0},
          }
        ],
      };

      final driver = XDriver.static(
        _createWidget(textSpan: nestedSpan),
      );
      await pumpDriver(tester, driver.asInternalDriver);

      final textWidget =
          tester.widget<Text>(find.byKey(const Key("richTextId")));
      final rootSpan = textWidget.textSpan;
      expect(rootSpan, isNotNull);

      final texts = <String>[];

      void collectTexts(InlineSpan? span) {
        if (span is TextSpan) {
          if (span.text != null) texts.add(span.text!);
          if (span.children != null) {
            for (final child in span.children!) {
              collectTexts(child);
            }
          }
        }
      }

      collectTexts(rootSpan);
      expect(
        texts,
        containsAll(
          ["Root ", "Level 1 ", "Level 2 ", "Level 3", "Sibling 1"],
        ),
      );
    });
  });
}
