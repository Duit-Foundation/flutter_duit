import "package:flutter/material.dart";
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_duit/flutter_duit.dart';

void main() {
  group("DuitHost widget tests", () {
    group("Host error builder tests", () {
      testWidgets("Has error builder", (WidgetTester tester) async {
        final driver = DuitDriver.static(
          {
            "type": "invalid_type",
            "id": "1",
          },
          transportOptions: HttpTransportOptions(),
        );

        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost(
              driver: driver,
              errorWidgetBuilder: (context, error) {
                return Text(error.toString());
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final errorText = find.text(
          "Invalid argument(s): Cant infer element type from json schema: invalid_type with id= 1",
        );

        expect(errorText, findsOneWidget);
      });
      testWidgets("Error builder undefined", (WidgetTester tester) async {
        final driver = DuitDriver.static(
          {
            "type": "invalid_type",
            "id": "1",
          },
          transportOptions: HttpTransportOptions(),
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

        expect(tester.takeException(), isInstanceOf<ArgumentError>());
      });
    });

    testWidgets("check show child instead of placeholder",
        (WidgetTester tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Container",
          "id": "1",
          "controlled": false,
          "attributes": {
            "width": 250,
            "height": 250,
          },
        },
        transportOptions: HttpTransportOptions(),
      );

      const childKey = ValueKey("child");

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
            showChildInsteadOfPlaceholder: true,
            placeholder: const CircularProgressIndicator(),
            child: Container(
              key: childKey,
            ),
          ),
        ),
      );

      final child = find.byKey(childKey);

      expect(child, findsOneWidget);
    });

    testWidgets("check show placeholder correctly",
        (WidgetTester tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Container",
          "id": "1",
          "controlled": false,
          "attributes": {
            "width": 250,
            "height": 250,
          },
        },
        transportOptions: HttpTransportOptions(),
      );

      const childKey = ValueKey("child");

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost(
            driver: driver,
            showChildInsteadOfPlaceholder: false,
            placeholder: const CircularProgressIndicator(),
            child: Container(
              key: childKey,
            ),
          ),
        ),
      );

      final child = find.byType(CircularProgressIndicator);

      expect(child, findsOneWidget);
    });
  });
}
