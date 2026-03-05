import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget({
  bool controlled = false,
  int? flex,
  String? fit,
}) {
  final attributes = <String, dynamic>{};
  if (flex != null) {
    attributes["flex"] = flex;
  }
  if (fit != null) {
    attributes["fit"] = fit;
  }

  return {
    "type": "Flexible",
    "id": "flexible",
    "controlled": controlled,
    "attributes": attributes,
    "child": {
      "type": "Container",
      "id": "con",
      "controlled": false,
      "attributes": {
        "color": "#DCDCDC",
        "width": 50,
        "height": 50,
      },
    },
  };
}

void main() {
  group(
    "DuitFlexible widget tests",
    () {
      testWidgets(
        "must renders correctly with default values",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.flex, 1);
          expect(flexibleWidget.fit, FlexFit.loose);
        },
      );

      testWidgets(
        "must renders correctly with custom flex value",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(flex: 2),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.flex, 2);
          expect(flexibleWidget.fit, FlexFit.loose);
        },
      );

      testWidgets(
        "must renders correctly with tight fit",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(fit: "tight"),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.flex, 1);
          expect(flexibleWidget.fit, FlexFit.tight);
        },
      );

      testWidgets(
        "must renders correctly with FlexFit.tight string",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(fit: "FlexFit.tight"),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.fit, FlexFit.tight);
        },
      );

      testWidgets(
        "must renders correctly with loose fit",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(fit: "loose"),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.fit, FlexFit.loose);
        },
      );

      testWidgets(
        "must renders correctly with fit as int (0 = tight)",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                {
                  "type": "Flexible",
                  "id": "flexible",
                  "controlled": false,
                  "attributes": {
                    "fit": 0,
                  },
                  "child": {
                    "type": "Container",
                    "id": "con",
                    "controlled": false,
                    "attributes": {
                      "color": "#DCDCDC",
                      "width": 50,
                      "height": 50,
                    },
                  },
                },
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.fit, FlexFit.tight);
        },
      );

      testWidgets(
        "must renders correctly with fit as int (1 = loose)",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                {
                  "type": "Flexible",
                  "id": "flexible",
                  "controlled": false,
                  "attributes": {
                    "fit": 1,
                  },
                  "child": {
                    "type": "Container",
                    "id": "con",
                    "controlled": false,
                    "attributes": {
                      "color": "#DCDCDC",
                      "width": 50,
                      "height": 50,
                    },
                  },
                },
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.fit, FlexFit.loose);
        },
      );

      testWidgets(
        "must renders correctly with both flex and fit",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(flex: 3, fit: "tight"),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          final widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          final flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.flex, 3);
          expect(flexibleWidget.fit, FlexFit.tight);
        },
      );

      testWidgets(
        "must update attributes for controlled widget",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                _createWidget(controlled: true, flex: 1, fit: "loose"),
              ],
            },
          );

          await pumpDriver(
            tester,
            driver.asInternalDriver,
          );

          var widget = find.byKey(const ValueKey("flexible"));

          expect(widget, findsOneWidget);

          var flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.flex, 1);
          expect(flexibleWidget.fit, FlexFit.loose);

          await driver.asInternalDriver.updateAttributes(
            "flexible",
            {
              "flex": 2,
              "fit": "tight",
            },
          );

          await tester.pumpAndSettle();

          widget = find.byKey(const ValueKey("flexible"));
          flexibleWidget = tester.widget<Flexible>(widget);
          expect(flexibleWidget.flex, 2);
          expect(flexibleWidget.fit, FlexFit.tight);
        },
      );

      testWidgets(
        "must work correctly in Row layout with multiple Flexible widgets",
        (tester) async {
          final driver = XDriver.static(
            {
              "type": "Row",
              "controlled": false,
              "id": "row",
              "children": [
                {
                  "type": "Flexible",
                  "id": "flex1",
                  "controlled": false,
                  "attributes": {
                    "flex": 1,
                    "fit": "loose",
                  },
                  "child": {
                    "type": "Container",
                    "id": "con1",
                    "controlled": false,
                    "attributes": {
                      "color": Colors.black,
                      "width": 50,
                      "height": 50,
                    },
                  },
                },
                {
                  "type": "Flexible",
                  "id": "flex2",
                  "controlled": false,
                  "attributes": {
                    "flex": 2,
                    "fit": "tight",
                  },
                  "child": {
                    "type": "Container",
                    "id": "con2",
                    "controlled": false,
                    "attributes": {
                      "color": Colors.green,
                      "width": 50,
                      "height": 50,
                    },
                  },
                },
                {
                  "type": "Flexible",
                  "id": "flex3",
                  "controlled": false,
                  "attributes": {
                    "flex": 1,
                    "fit": "loose",
                  },
                  "child": {
                    "type": "Container",
                    "id": "con3",
                    "controlled": false,
                    "attributes": {
                      "color": Colors.red,
                      "width": 50,
                      "height": 50,
                    },
                  },
                },
              ],
            },
          );

          await tester.pumpWidget(
            MaterialApp(
              home: DuitViewHost.withDriver(driver: driver),
            ),
          );

          await tester.pumpAndSettle();

          final flex1Widget = tester.widget<Flexible>(
            find.byKey(const ValueKey("flex1")),
          );
          final flex2Widget = tester.widget<Flexible>(
            find.byKey(const ValueKey("flex2")),
          );
          final flex3Widget = tester.widget<Flexible>(
            find.byKey(const ValueKey("flex3")),
          );

          expect(flex1Widget.flex, 1);
          expect(flex1Widget.fit, FlexFit.loose);
          expect(flex2Widget.flex, 2);
          expect(flex2Widget.fit, FlexFit.tight);
          expect(flex3Widget.flex, 1);
          expect(flex3Widget.fit, FlexFit.loose);
        },
      );
    },
  );
}
