import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

void main() {
  testWidgets("test", (tester) async {
    final driver = DuitDriver.static(
      {
        "type": "Column",
        "id": "col1",
        "controlled": false,
        "children": [
          {
            'type': 'TextField',
            'id': 'textField1',
            'controlled': true,
            'attributes': {
              'value': 'Hello',
              'autofocus': false,
              'enabled': true,
              'readOnly': false,
              'maxLength': 20,
            },
          },
          {
            'type': 'TextField',
            'id': 'textField2',
            'controlled': true,
            'attributes': {
              'value': 'World',
              'autofocus': false,
              'enabled': true,
              'readOnly': false,
              'maxLength': 20,
            },
          }
        ]
      },
      transportOptions: EmptyTransportOptions(),
    );

    await pumpDriver(tester, driver);

    final data = driver.preparePayload([
      ActionDependency(target: "val1", id: "textField1"),
      ActionDependency(target: "val2", id: "textField2"),
    ]);

    expect(data["val1"], "Hello");
    expect(data["val2"], "World");
  });
}
