import 'package:flutter/material.dart';
import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "DuitPhysicalModel widget tests",
    () {
      testWidgets("must build widget", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "PhysicalModel",
            "id": "physical_model",
            "attributes": {
              "elevation": 8.0,
              "color": [255, 0, 0, 1],
              "shadowColor": [0, 0, 0, 1],
              "clipBehavior": "antiAlias",
              "borderRadius": {
                "topLeft": {"x": 10, "y": 10},
                "topRight": {"x": 10, "y": 10},
                "bottomLeft": {"x": 10, "y": 10},
                "bottomRight": {"x": 10, "y": 10}
              }
            },
            "controlled": false,
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 100,
                "height": 100,
              }
            }
          },
          transportOptions: EmptyTransportOptions(),
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

        final physicalModel = find.byKey(const ValueKey("physical_model"));

        expect(physicalModel, findsOneWidget);
        expect(
          tester.widget<PhysicalModel>(physicalModel).elevation,
          8.0,
        );
        expect(
          tester.widget<PhysicalModel>(physicalModel).color,
          const Color.fromARGB(255, 255, 0, 0),
        );
        expect(
          tester.widget<PhysicalModel>(physicalModel).shadowColor,
          Colors.black,
        );
        expect(
          tester.widget<PhysicalModel>(physicalModel).clipBehavior,
          Clip.antiAlias,
        );
      });

      testWidgets("must update widget", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "PhysicalModel",
            "id": "physical_model",
            "attributes": {
              "elevation": 4.0,
              "color": [0, 255, 0, 1],
              "shadowColor": [0, 0, 0, 1],
              "clipBehavior": "hardEdge",
            },
            "controlled": true,
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 100,
                "height": 100,
              }
            }
          },
          transportOptions: EmptyTransportOptions(),
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

        var physicalModel = find.byKey(const ValueKey("physical_model"));

        expect(physicalModel, findsOneWidget);
        expect(
          tester.widget<PhysicalModel>(physicalModel).elevation,
          4.0,
        );
        expect(
          tester.widget<PhysicalModel>(physicalModel).color,
          const Color.fromARGB(255, 0, 255, 0),
        );

        await driver.updateTestAttributes("physical_model", {
          "elevation": 12.0,
          "color": [0, 0, 255, 1],
        });

        await tester.pumpAndSettle();

        physicalModel = find.byKey(const ValueKey("physical_model"));

        expect(
          tester.widget<PhysicalModel>(physicalModel).elevation,
          12.0,
        );
        expect(
          tester.widget<PhysicalModel>(physicalModel).color,
          const Color.fromARGB(255, 0, 0, 255),
        );
      });

      testWidgets("must handle clipBehavior", (tester) async {
        final driver = DuitDriver.static(
          {
            "type": "PhysicalModel",
            "id": "physical_model",
            "attributes": {
              "elevation": 2.0,
              "color": [128, 128, 128, 1],
              "shadowColor": [0, 0, 0, 1],
              "clipBehavior": "none",
            },
            "controlled": false,
            "child": {
              "type": "Container",
              "id": "child_container",
              "attributes": {
                "width": 50,
                "height": 50,
              }
            }
          },
          transportOptions: EmptyTransportOptions(),
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

        final physicalModel = find.byKey(const ValueKey("physical_model"));

        expect(physicalModel, findsOneWidget);
        expect(
          tester.widget<PhysicalModel>(physicalModel).clipBehavior,
          Clip.none,
        );
        expect(
          tester.widget<PhysicalModel>(physicalModel).color,
          const Color.fromARGB(255, 128, 128, 128),
        );
      });
    },
  );
}
