import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/index.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group(
    "DuitElement tests",
    () {
      late XDriver mockDriver;

      setUp(() {
        mockDriver = XDriver.static({});
        ServerAction.setActionParser(const DefaultActionParser());
      });
      test("must throw NullTagException on component handling", () {
        expect(
          () => DuitElement.fromJson(
            {"type": ElementType.component, "id": "id"},
            mockDriver.asInternalDriver,
          ),
          throwsA(isA<NullTagException>()),
        );
      });

      test("must throw NullTagException on fragment handling", () {
        expect(
          () => DuitElement.fromJson(
            {
              "type": ElementType.fragment,
              "id": "id",
            },
            mockDriver.asInternalDriver,
          ),
          throwsA(isA<NullTagException>()),
        );
      });

      test(
        "getters must return valid data",
        () {
          final element = DuitElement.fromJson(
            {
              "type": "Align",
              "id": "id",
              "controlled": false,
              "attributes": <String, dynamic>{},
            },
            mockDriver.asInternalDriver,
          );

          expect(element.attributes, isA<ViewAttribute>());
          expect(element.child, null);
          expect(element.type, ElementType.align);
          expect(element.toString(), isNotEmpty);

          final element2 = DuitElement.fromJson(
            {
              "type": "Column",
              "id": "123",
              "controlled": false,
              "attributes": <String, dynamic>{},
              "children": <ElementTreeEntry>[],
            },
            mockDriver.asInternalDriver,
          );

          expect(element2.children, isA<List>());
        },
      );
    },
  );
}
