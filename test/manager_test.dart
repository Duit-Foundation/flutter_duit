import "package:flutter/material.dart";
import "package:flutter_duit/src/view_manager/index.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "SimpleViewManager",
    (tester) async {
      final mng = SimpleViewManager();

      mng.driver = MockUIDriver();

      final view = await mng.prepareLayout(
        {
          "type": "Text",
          "id": "text",
          "attributes": {
            "data": "Text",
          },
        },
      );

      expect(view, isNotNull);
      expect(mng.isWidgetReady("123"), false);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: view!.build("123"),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey("text")), findsOneWidget);
    },
  );

  testWidgets(
    "MultiViewManager",
    (tester) async {
      final mng = MultiViewManager();

      mng.driver = MockUIDriver();

      final view = await mng.prepareLayout(
        {
          // "type": "Text",
          "id": "text",
          "attributes": {
            "data": "Text",
          },
        },
      );

      expect(view, null);

      final view2 = await mng.prepareLayout(
        {
          "widgets": [
            {
              "type": "Text",
              "id": "text1",
              "attributes": {
                "data": "Tex1",
              },
            },
            {
              "type": "Text",
              "id": "text2",
              "attributes": {
                "data": "Text2",
              },
            },
          ],
        },
      );


      expect(mng.isWidgetReady("123"), false);

      // await tester.pumpWidget(
      //   Directionality(
      //     textDirection: TextDirection.ltr,
      //     child: view!.build("123"),
      //   ),
      // );
      // await tester.pumpAndSettle();

      // expect(find.byKey(const ValueKey("text")), findsOneWidget);
    },
  );
}
