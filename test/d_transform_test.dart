import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group("DuitTransform widget tests", () {
    testWidgets("renders scale transform", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform1",
          "controlled": true,
          "attributes": {
            "type": "scale",
            "data": {
              "scale": 2.0,
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container1",
            "attributes": {
              "color": "#FF0000",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform1"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.getMaxScaleOnAxis(), 2.0);
    });

    testWidgets("renders rotate transform", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform2",
          "controlled": true,
          "attributes": {
            "type": "rotate",
            "data": {
              "angle": 1.57,
            },
          },
          "child": {
            "type": "Container",
            "id": "container2",
            "attributes": {
              "color": "#00FF00",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform2"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      // Проверяем, что матрица содержит угол поворота (sin/cos)
      expect(widget.transform.storage[0], closeTo(0.0, 0.01)); // cos(90°) ~ 0
    });

    testWidgets("renders translate transform", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform3",
          "controlled": true,
          "attributes": {
            "type": "translate",
            "data": {
              "offset": {"dx": 5.0, "dy": 10.0},
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container3",
            "attributes": {
              "color": "#0000FF",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform3"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.getTranslation().x, 5.0);
      expect(widget.transform.getTranslation().y, 10.0);
    });

    testWidgets("renders flip transform", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform4",
          "controlled": true,
          "attributes": {
            "type": "flip",
            "data": {
              "flipX": true,
              "flipY": false,
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container4",
            "attributes": {
              "color": "#FFFF00",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform4"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      // flipX = true => scaleX = -1
      expect(widget.transform.storage[0], -1.0);
    });

    testWidgets("controlled: updates transform attributes", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform5",
          "controlled": true,
          "attributes": {
            "type": "scale",
            "data": {
              "scale": 1.0,
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container5",
            "attributes": {
              "color": "#FF00FF",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform5"));
      expect(transformFinder, findsOneWidget);
      var widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.getMaxScaleOnAxis(), 1.0);
      await driver.updateAttributes("transform5", {
        "type": "scale",
        "data": {
          "scale": 3.0,
          "parentBuilderId": "",
          "affectedProperties": [],
        },
      });
      await tester.pumpAndSettle();
      widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.getMaxScaleOnAxis(), 3.0);
    });

    testWidgets("renders scale transform (controlled: false)", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform_nc1",
          "controlled": false,
          "attributes": {
            "type": "scale",
            "data": {
              "scale": 1.5,
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container_nc1",
            "attributes": {
              "color": "#FF0000",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform_nc1"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.getMaxScaleOnAxis(), 1.5);
    });

    testWidgets("renders rotate transform (controlled: false)", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform_nc2",
          "controlled": false,
          "attributes": {
            "type": "rotate",
            "data": {
              "angle": 0.5,
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container_nc2",
            "attributes": {
              "color": "#00FF00",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform_nc2"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.storage[0], closeTo(0.877, 0.01)); // cos(0.5)
    });

    testWidgets("renders translate transform (controlled: false)",
        (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform_nc3",
          "controlled": false,
          "attributes": {
            "type": "translate",
            "data": {
              "offset": {"dx": 3.0, "dy": 7.0},
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container_nc3",
            "attributes": {
              "color": "#0000FF",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform_nc3"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      expect(widget.transform.getTranslation().x, 3.0);
      expect(widget.transform.getTranslation().y, 7.0);
    });

    testWidgets("renders flip transform (controlled: false)", (tester) async {
      final driver = DuitDriver.static(
        {
          "type": "Transform",
          "id": "transform_nc4",
          "controlled": false,
          "attributes": {
            "type": "flip",
            "data": {
              "flipX": false,
              "flipY": true,
              "parentBuilderId": "",
              "affectedProperties": [],
            },
          },
          "child": {
            "type": "Container",
            "id": "container_nc4",
            "attributes": {
              "color": "#FFFF00",
              "width": 10.0,
              "height": 10.0,
            },
          },
        },
        transportOptions: EmptyTransportOptions(),
      );
      await pumpDriver(tester, driver);
      final transformFinder = find.byKey(const ValueKey("transform_nc4"));
      expect(transformFinder, findsOneWidget);
      final widget = tester.widget<Transform>(transformFinder);
      // flipY = true => scaleY = -1
      expect(widget.transform.storage[5], -1.0);
    });
  });
}
