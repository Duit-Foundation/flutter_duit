import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  group("XDriver addDataSource tests", () {
    testWidgets("dispose", (tester) async {
      final driver = XDriver.static(
        {
          "type": "Column",
          "id": "col1",
          "controlled": false,
          "children": [
            {
              "type": "TextField",
              "id": "textField1",
              "controlled": true,
              "attributes": {
                "value": "Initial",
              },
            }
          ],
        },
      );

      await driver.init();

      driver.dispose();
    });
    testWidgets("should successfully process valid events from data source",
        (tester) async {
      final driver = XDriver.static(
        {
          "type": "Column",
          "id": "col1",
          "controlled": false,
          "children": [
            {
              "type": "TextField",
              "id": "textField1",
              "controlled": true,
              "attributes": {
                "value": "Initial",
              },
            }
          ],
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      // Add data source
      driver.addExternalEventStream(
        Stream.value(
          {
            "type": "update",
            "updates": {
              "textField1": {
                "value": "Updated from data source",
              },
            },
          },
        ),
      );

      await tester.pumpAndSettle();

      // Check that the value was updated through payload
      final data = driver.asInternalDriver.preparePayload([
        ActionDependency(target: "val1", id: "textField1"),
      ]);
      expect(data["val1"], "Updated from data source");
    });

    testWidgets("should handle NullEvent by throwing NullEventException",
        (tester) async {
      final driver = XDriver.static(
        {
          "type": "Column",
          "id": "col1",
          "controlled": false,
          "children": [],
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      await runZonedGuarded(() async {
        driver.addExternalEventStream(Stream.value({"type": "null"}));
      }, (error, stack) {
        expect(error, isA<NullEventException>());
      });
    });

    testWidgets("should handle multiple data sources simultaneously",
        (tester) async {
      final driver = XDriver.static(
        {
          "type": "Column",
          "id": "col1",
          "controlled": false,
          "children": [
            {
              "type": "TextField",
              "id": "textField1",
              "controlled": true,
              "attributes": {
                "value": "Initial1",
              },
            },
            {
              "type": "TextField",
              "id": "textField2",
              "controlled": true,
              "attributes": {
                "value": "Initial2",
              },
            }
          ],
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      // Add both data sources
      driver.addExternalEventStream(
        Stream.value({
          "type": "update",
          "updates": {
            "textField1": {"value": "Updated from source 1"},
          },
        }),
      );
      driver.addExternalEventStream(
        Stream.value({
          "type": "update",
          "updates": {
            "textField2": {"value": "Updated from source 2"},
          },
        }),
      );

      await tester.pumpAndSettle();

      // Check that both fields were updated
      final data = driver.asInternalDriver.preparePayload([
        ActionDependency(target: "val1", id: "textField1"),
        ActionDependency(target: "val2", id: "textField2"),
      ]);

      expect(data["val1"], "Updated from source 1");
      expect(data["val2"], "Updated from source 2");
    });

    testWidgets("should handle different event types from data source",
        (tester) async {
      final driver = XDriver.static(
        {
          "type": "Column",
          "id": "col1",
          "controlled": false,
          "children": [
            {
              "type": "TextField",
              "id": "textField1",
              "controlled": true,
              "attributes": {
                "value": "Initial",
              },
            }
          ],
        },
      );

      await pumpDriver(tester, driver.asInternalDriver);

      // Create stream
      final streamController = StreamController<Map<String, dynamic>>();

      // Add data source
      driver.addExternalEventStream(streamController.stream);

      // Test CustomEvent
      streamController.add({
        "type": "custom",
        "key": "test_key",
        "extra": {"data": "test_data"},
      });

      await tester.pumpAndSettle();

      // Test UpdateEvent
      streamController.add({
        "type": "update",
        "updates": {
          "textField1": {"value": "Updated by custom event"},
        },
      });

      await tester.pumpAndSettle();

      // Check that update worked
      final data = driver.asInternalDriver.preparePayload([
        ActionDependency(target: "val1", id: "textField1"),
      ]);
      expect(data["val1"], "Updated by custom event");

      // Cleanup
      await streamController.close();
    });
  });

  testWidgets("must prepare valid payload", (tester) async {
    final driver = XDriver.static(
      {
        "type": "Column",
        "id": "col1",
        "controlled": false,
        "children": [
          {
            "type": "TextField",
            "id": "textField1",
            "controlled": true,
            "attributes": {
              "value": "Hello",
              "autofocus": false,
              "enabled": true,
              "readOnly": false,
              "maxLength": 20,
            },
          },
          {
            "type": "TextField",
            "id": "textField2",
            "controlled": true,
            "attributes": {
              "value": "World",
              "autofocus": false,
              "enabled": true,
              "readOnly": false,
              "maxLength": 20,
            },
          }
        ],
      },
    );

    await pumpDriver(tester, driver.asInternalDriver);

    final data = driver.asInternalDriver.preparePayload([
      ActionDependency(target: "val1", id: "textField1"),
      ActionDependency(target: "val2", id: "textField2"),
    ]);

    expect(data["val1"], "Hello");
    expect(data["val2"], "World");
  });
}
