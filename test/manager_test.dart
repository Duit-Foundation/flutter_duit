// ignore_for_file: deprecated_member_use_from_same_package

import "package:flutter/material.dart";
import "package:flutter_duit/src/view_manager/index.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets(
    "SimpleViewManager must render view from struct",
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
          child: mng.build("123"),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey("text")), findsOneWidget);
    },
  );

  testWidgets(
    "SimpleViewManager must render view from root",
    (tester) async {
      final mng = SimpleViewManager();

      mng.driver = MockUIDriver();

      final view = await mng.prepareLayout(
        {
          "root": {
            "type": "Text",
            "id": "text",
            "attributes": {
              "data": "Text",
            },
          },
        },
      );

      expect(view, isNotNull);
      expect(mng.isWidgetReady("123"), false);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: mng.build("123"),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey("text")), findsOneWidget);
    },
  );

  test(
    "MultiViewManager must fail parsing with super method",
    () async {
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
    },
  );

  test(
    "MultiViewManager must fail parsing with invalid object pattern ",
    () async {
      final mng = MultiViewManager();

      mng.driver = MockUIDriver();

      final view = await mng.prepareLayout(
        {
          "widgets": [],
        },
      );

      expectLater(view, null);
    },
  );

  testWidgets(
    "MultiViewManager must parse and build widget",
    (tester) async {
      final mng = MultiViewManager();

      mng.driver = MockUIDriver();

      await mng.prepareLayout(
        {
          "widgets": {
            "1": {
              "type": "Text",
              "id": "text1",
              "attributes": {
                "data": "Tex1",
              },
            },
            "2": {
              "type": "Text",
              "id": "text2",
              "attributes": {
                "data": "Text2",
              },
            },
          },
        },
      );

      expect(mng.isWidgetReady("1"), false);

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: mng.build("1"),
        ),
      );
      await tester.pumpAndSettle();
      mng.notifyWidgetDisplayStateChanged("1", 1);

      expect(find.byKey(const ValueKey("text1")), findsOneWidget);
      expect(mng.isWidgetReady("1"), true);
    },
  );
}
