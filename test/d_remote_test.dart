import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group(
    "DuitRemoteWidget tests",
    () {
      testWidgets(
        "must load content",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "RemoteSubtree",
              "controlled": true,
              "id": "remote",
              "attributes": {
                "downloadPath": "/widgets/remote",
                "meta": {
                  "method": "GET",
                },
                "dependsOn": [],
              },
            },
            transportOptions: EmptyTransportOptions(),
          )..applyMockTransport(
              {
                "type": "Text",
                "id": "text",
                "controlled": false,
                "attributes": {
                  "data": "Hello, World!",
                  "style": {
                    "color": "#DCDCDC",
                    "fontSize": 14.0,
                    "fontWeight": 700,
                  },
                },
              },
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

          expect(find.byKey(const Key("remote")), findsOneWidget);

          await tester.pumpAndSettle(const Duration(seconds: 1));

          expect(find.byKey(const Key("text")), findsOneWidget);
        },
      );

      testWidgets(
        "must apply content update",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "RemoteSubtree",
              "controlled": true,
              "id": "remote",
              "attributes": {
                "downloadPath": "/widgets/remote",
                "meta": {
                  "method": "GET",
                },
                "dependsOn": [],
              },
            },
            transportOptions: EmptyTransportOptions(),
          )..applyMockTransport(
              {
                "type": "Text",
                "id": "text",
                "controlled": false,
                "attributes": {
                  "data": "Hello, World!",
                  "style": {
                    "color": "#DCDCDC",
                    "fontSize": 14.0,
                    "fontWeight": 700,
                  },
                },
              },
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

          expect(find.byKey(const Key("remote")), findsOneWidget);

          await tester.pumpAndSettle(const Duration(seconds: 1));

          expect(find.byKey(const Key("text")), findsOneWidget);

          await driver.updateAttributes(
            "remote",
            {
              "data": {
                "type": "Text",
                "id": "text_updated",
                "controlled": false,
                "attributes": {
                  "data": "Hello, World!",
                  "style": {
                    "color": "#DCDCDC",
                    "fontSize": 14.0,
                    "fontWeight": 700,
                  },
                },
              },
            },
          );

          await tester.pumpAndSettle();

          expect(find.byKey(const Key("text_updated")), findsOneWidget);
        },
      );
    },
  );
}
