import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "Tooltip",
    "id": "tooltip_test",
    "controlled": isControlled,
    "attributes": {
      "message": "Initial tooltip",
      "verticalOffset": 24.0,
      "preferBelow": true,
      "enableTapToDismiss": true,
      "triggerMode": "longPress",
    },
    "child": {
      "type": "Container",
      "id": "tooltip_child",
      "controlled": false,
      "attributes": {"width": 60.0, "height": 40.0, "color": "#DCDCDC"},
    },
  };
}

void main() {
  group("DuitTooltip widget tests", () {
    testWidgets("check widget", (tester) async {
      final driver = XDriver.static(
        _createWidget(),
      );
      
      await pumpDriver(tester, driver.asInternalDriver);

      final widget = find.byKey(const ValueKey("tooltip_test"));
      expect(widget, findsOneWidget);

      final tooltip = tester.widget<Tooltip>(widget);
      expect(tooltip.message, "Initial tooltip");
      expect(tooltip.triggerMode, TooltipTriggerMode.longPress);
      expect(tooltip.preferBelow, true);
    });

    testWidgets("must update attributes", (tester) async {
      final driver = XDriver.static(
        _createWidget(true),
      );

      await pumpDriver(tester, driver.asInternalDriver);

      final widget = find.byKey(const ValueKey("tooltip_test"));
      expect(widget, findsOneWidget);

      var tooltip = tester.widget<Tooltip>(widget);
      expect(tooltip.message, "Initial tooltip");
      expect(tooltip.triggerMode, TooltipTriggerMode.longPress);
      expect(tooltip.preferBelow, true);

      await driver.asInternalDriver.updateAttributes(
        "tooltip_test",
        {
          "message": "Updated tooltip",
          "triggerMode": 2,
          "preferBelow": false,
          "verticalOffset": 40.0,
        },
      );

      await tester.pumpAndSettle();

      tooltip = tester.widget<Tooltip>(widget);
      expect(tooltip.message, "Updated tooltip");
      expect(tooltip.triggerMode, TooltipTriggerMode.tap);
      expect(tooltip.preferBelow, false);
      expect(tooltip.verticalOffset, 40.0);
    });
  });
}
