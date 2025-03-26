import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_duit/flutter_duit.dart';

import 'utils.dart';

void main() {
  group(
    'DuitScaffold tests',
    () {
      testWidgets(
        'must build with default attributes',
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "attributes": {
                "backgroundColor": "#00FF00",
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final scaffold = find.byType(Scaffold);
          expect(scaffold, findsOneWidget);

          final scaffoldWidget = tester.widget<Scaffold>(scaffold);

          expect(scaffoldWidget.backgroundColor, const Color(0xFF00FF00));
          expect(scaffoldWidget.extendBody, false);
          expect(scaffoldWidget.extendBodyBehindAppBar, false);
          expect(scaffoldWidget.primary, true);
        },
      );

      testWidgets(
        "must build with body widget",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "attributes": {
                "body": {
                  "type": "Text",
                  "id": "text",
                  "controlled": false,
                  "attributes": {
                    "data": "Hello, world!",
                  },
                },
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final text = find.byKey(const Key("text"));
          expect(text, findsOneWidget);

          final textWidget = tester.widget<Text>(text);
          expect(textWidget.data, "Hello, world!");
        },
      );

      testWidgets(
        "must build with AppBar widget",
        (tester) async {
          await pumpDriver(
            tester,
            DuitDriver.static(
              {
                "type": "Scaffold",
                "id": "scaffold",
                "attributes": {
                  "appBar": {
                    "type": "AppBar",
                    "id": "appBar",
                    "controlled": true,
                    "attributes": {},
                  },
                },
              },
              transportOptions: EmptyTransportOptions(),
            ),
          );

          final appBar = find.byKey(const Key("appBar"));
          expect(appBar, findsOneWidget);
        },
      );

      testWidgets(
        "must build with bottomsheet widget",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "attributes": {
                "bottomSheet": {
                  "type": "Container",
                  "id": "bottom",
                  "controlled": false,
                  "attributes": {"height": 100, "color": "#00FF00"},
                },
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final container = find.byKey(const Key("bottom"));
          expect(container, findsOneWidget);

          final containerWidget = tester.widget<Container>(container);
          expect(containerWidget.color, const Color(0xFF00FF00));
        },
      );

      testWidgets(
        "must build with FAB widget",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "Scaffold",
              "id": "scaffold",
              "attributes": {
                "floatingActionButton": {
                  "type": "Container",
                  "id": "bottom",
                  "controlled": false,
                  "attributes": {
                    "height": 25,
                    "width": 25,
                    "color": "#00FF00",
                  },
                },
              },
            },
            transportOptions: EmptyTransportOptions(),
          );

          await pumpDriver(tester, driver);

          final container = find.byKey(const Key("bottom"));
          expect(container, findsOneWidget);

          final containerWidget = tester.widget<Container>(container);
          expect(containerWidget.color, const Color(0xFF00FF00));
        },
      );
    },
  );
}
