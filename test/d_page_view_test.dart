import "package:flutter_duit/src/ui/widgets/index.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group(
    "PageViewConstructor tests",
    () {
      test(
        "PageViewConstructor must parse value",
        () {
          expect(
            PageViewConstructor.fromValue("common"),
            PageViewConstructor.common,
          );
          expect(PageViewConstructor.fromValue(0), PageViewConstructor.common);
          expect(
            PageViewConstructor.fromValue("builder"),
            PageViewConstructor.builder,
          );
          expect(PageViewConstructor.fromValue(1), PageViewConstructor.builder);
          expect(
            PageViewConstructor.fromValue("custom"),
            PageViewConstructor.custom,
          );
          expect(PageViewConstructor.fromValue(2), PageViewConstructor.custom);
        },
      );

            test(
        "PageViewConstructor must throw error",
        () {
          expect(() => PageViewConstructor.fromValue(true), throwsArgumentError);
        },
      );
    },
  );
}
