import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "Visibility",
    "id": "visibility_test",
    "controlled": isControlled,
    "attributes": {"visible": true},
    "children": [
      {
        "type": "Container",
        "id": "con",
        "controlled": false,
        "attributes": {"color": "#DCDCDC", "width": 50, "height": 50},
      },
      null,
    ],
  };
}

Map<String, dynamic> _createWidgetWithReplacement([bool isControlled = false]) {
  return {
    "type": "Visibility",
    "id": "visibility_with_replacement",
    "controlled": isControlled,
    "attributes": {"visible": true},
    "children": [
      {
        "type": "Container",
        "id": "visible_container",
        "controlled": false,
        "attributes": {"color": "#FF0000", "width": 50, "height": 50},
      },
      {
        "type": "Container",
        "id": "replacement_container",
        "controlled": false,
        "attributes": {"color": "#00FF00", "width": 50, "height": 50},
      },
    ],
  };
}

void main() {
  group("DuitVisibility widget tests", () {
    testWidgets("check widget", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost.withDriver(
            driver: XDriver.static(
              _createWidget(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final widget = find.byKey(const ValueKey("visibility_test"));

      expect(widget, findsOneWidget);
    });

    testWidgets(
      "must update attributes",
      (tester) async {
        final driver = XDriver.static(
          _createWidget(true),
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final widget = find.byKey(const ValueKey("visibility_test"));
        expect(widget, findsOneWidget);

        final visibility = tester.widget<Visibility>(widget);
        expect(visibility.visible, true);

        await driver.asInternalDriver.updateAttributes(
          "visibility_test",
          {
            "visible": false,
          },
        );

        await tester.pumpAndSettle();

        final updatedVisibility = tester.widget<Visibility>(widget);
        expect(updatedVisibility.visible, false);
      },
    );

    testWidgets(
      "must show replacement when visible is false",
      (tester) async {
        final driver = XDriver.static(
          _createWidgetWithReplacement(true),
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final widget =
            find.byKey(const ValueKey("visibility_with_replacement"));
        expect(widget, findsOneWidget);

        final visibility = tester.widget<Visibility>(widget);
        expect(visibility.visible, true);

        // Visible container should be present
        expect(
          find.byKey(const ValueKey("visible_container")),
          findsOneWidget,
        );

        // Replacement container should not be visible
        expect(
          find.byKey(const ValueKey("replacement_container")),
          findsNothing,
        );

        // Change visibility to false
        await driver.asInternalDriver.updateAttributes(
          "visibility_with_replacement",
          {
            "visible": false,
          },
        );

        await tester.pumpAndSettle();

        final updatedVisibility = tester.widget<Visibility>(widget);
        expect(updatedVisibility.visible, false);

        // Visible container should now be hidden
        expect(
          find.byKey(const ValueKey("visible_container")),
          findsNothing,
        );

        // Replacement should be visible (visible in widget tree)
        expect(
          find.byKey(const ValueKey("replacement_container")),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      "must update maintain properties",
      (tester) async {
        final driver = XDriver.static(
          _createWidget(true),
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final widget = find.byKey(const ValueKey("visibility_test"));
        expect(widget, findsOneWidget);

        // Check initial state (default values)
        final visibility = tester.widget<Visibility>(widget);
        expect(visibility.maintainState, false);
        expect(visibility.maintainAnimation, false);
        expect(visibility.maintainSize, false);
        expect(visibility.maintainSemantics, false);
        expect(visibility.maintainInteractivity, false);

        // Update maintain properties
        await driver.asInternalDriver.updateAttributes(
          "visibility_test",
          {
            "maintainState": true,
            "maintainAnimation": true,
            "maintainSize": true,
            "maintainSemantics": true,
            "maintainInteractivity": true,
          },
        );

        await tester.pumpAndSettle();

        final updatedVisibility = tester.widget<Visibility>(widget);
        expect(updatedVisibility.maintainState, true);
        expect(updatedVisibility.maintainAnimation, true);
        expect(updatedVisibility.maintainSize, true);
        expect(updatedVisibility.maintainSemantics, true);
        expect(updatedVisibility.maintainInteractivity, true);
      },
    );
  });
}
