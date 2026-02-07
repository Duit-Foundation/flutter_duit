import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group("DuitInteractiveViewer widget tests", () {
    testWidgets("must perform onInteractionStart action", (tester) async {
      final driver = XDriver.static(
        {
          "type": "InteractiveViewer",
          "id": "interactive_viewer",
          "controlled": true,
          "child": {
            "type": "Text",
            "controlled": true,
            "id": "target_text",
            "attributes": {
              "data": "Initial",
            },
          },
          "attributes": {
            "onInteractionStart": LocalAction(
              event: UpdateEvent(
                updates: {
                  "target_text": {
                    "data": "onInteractionStart",
                  },
                },
              ),
            ),
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("Initial"), findsOneWidget);

      final viewerFinder = find.byType(InteractiveViewer);
      final center = tester.getCenter(viewerFinder);

      // Симулируем начало взаимодействия (касание)
      await tester.startGesture(center);
      await tester.pumpAndSettle();

      expect(find.text("onInteractionStart"), findsOneWidget);
    });

    testWidgets("must perform onInteractionUpdate action", (tester) async {
      final driver = XDriver.static(
        {
          "type": "InteractiveViewer",
          "id": "interactive_viewer",
          "controlled": true,
          "child": {
            "type": "Text",
            "controlled": true,
            "id": "target_text",
            "attributes": {
              "data": "Initial",
            },
          },
          "attributes": {
            "onInteractionUpdate": LocalAction(
              event: UpdateEvent(
                updates: {
                  "target_text": {
                    "data": "onInteractionUpdate",
                  },
                },
              ),
            ),
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("Initial"), findsOneWidget);

      final viewerFinder = find.byType(InteractiveViewer);
      final center = tester.getCenter(viewerFinder);

      // Симулируем обновление взаимодействия (перемещение)
      final gesture = await tester.startGesture(center);
      await tester.pump();
      await gesture.moveBy(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.text("onInteractionUpdate"), findsOneWidget);
    });

    testWidgets("must perform onInteractionEnd action", (tester) async {
      final driver = XDriver.static(
        {
          "type": "InteractiveViewer",
          "id": "interactive_viewer",
          "controlled": true,
          "child": {
            "type": "Text",
            "controlled": true,
            "id": "target_text",
            "attributes": {
              "data": "Initial",
            },
          },
          "attributes": {
            "onInteractionEnd": LocalAction(
              event: UpdateEvent(
                updates: {
                  "target_text": {
                    "data": "onInteractionEnd",
                  },
                },
              ),
            ),
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("Initial"), findsOneWidget);

      final viewerFinder = find.byType(InteractiveViewer);
      final center = tester.getCenter(viewerFinder);

      // Симулируем окончание взаимодействия
      final gesture = await tester.startGesture(center);
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(find.text("onInteractionEnd"), findsOneWidget);
    });

    testWidgets("must update attributes dynamically", (tester) async {
      final driver = XDriver.static(
        {
          "type": "InteractiveViewer",
          "id": "interactive_viewer",
          "controlled": true,
          "attributes": {
            "panEnabled": true,
            "scaleEnabled": true,
            "minScale": 0.8,
            "maxScale": 2.5,
          },
          "child": {
            "type": "Container",
            "id": "container",
            "controlled": false,
            "attributes": {
              "width": 200,
              "height": 200,
              "color": "#FF00FF",
            },
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      var viewerFinder = find.byKey(const ValueKey("interactive_viewer"));
      var viewerWidget = tester.widget<InteractiveViewer>(viewerFinder);
      expect(viewerWidget.panEnabled, true);
      expect(viewerWidget.scaleEnabled, true);
      expect(viewerWidget.minScale, 0.8);
      expect(viewerWidget.maxScale, 2.5);

      // Обновляем атрибуты
      await driver.asInternalDriver.updateAttributes("interactive_viewer", {
        "panEnabled": false,
        "scaleEnabled": false,
        "minScale": 0.5,
        "maxScale": 3.0,
      });

      await tester.pumpAndSettle();

      viewerFinder = find.byKey(const ValueKey("interactive_viewer"));
      viewerWidget = tester.widget<InteractiveViewer>(viewerFinder);
      expect(viewerWidget.panEnabled, false);
      expect(viewerWidget.scaleEnabled, false);
      expect(viewerWidget.minScale, 0.5);
      expect(viewerWidget.maxScale, 3.0);
    });

    testWidgets("must handle all interaction callbacks together",
        (tester) async {
      final driver = XDriver.static(
        {
          "type": "InteractiveViewer",
          "id": "interactive_viewer",
          "controlled": true,
          "child": {
            "type": "Text",
            "controlled": true,
            "id": "target_text",
            "attributes": {
              "data": "Initial",
            },
          },
          "attributes": {
            "onInteractionStart": LocalAction(
              event: UpdateEvent(
                updates: {
                  "target_text": {
                    "data": "Start",
                  },
                },
              ),
            ),
            "onInteractionUpdate": LocalAction(
              event: UpdateEvent(
                updates: {
                  "target_text": {
                    "data": "Update",
                  },
                },
              ),
            ),
            "onInteractionEnd": LocalAction(
              event: UpdateEvent(
                updates: {
                  "target_text": {
                    "data": "End",
                  },
                },
              ),
            ),
          },
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      expect(find.text("Initial"), findsOneWidget);

      final viewerFinder = find.byKey(const ValueKey("interactive_viewer"));
      final center = tester.getCenter(viewerFinder);

      // Симулируем полный цикл взаимодействия
      final gesture = await tester.startGesture(center);
      await tester.pump();
      expect(find.text("Start"), findsOneWidget);

      await gesture.moveBy(const Offset(10, 10));
      await tester.pump();
      expect(find.text("Update"), findsOneWidget);

      await gesture.up();
      await tester.pumpAndSettle();
      expect(find.text("End"), findsOneWidget);
    });
  });
}
