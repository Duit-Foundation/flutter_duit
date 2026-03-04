import "package:flutter_duit/src/utils/image_type.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test(
    "ImageType must parse correctly",
    () {
      expect(ImageType.fromString("network"), ImageType.network);
      expect(ImageType.fromString("123123"), ImageType.network);
      expect(ImageType.fromString("memory"), ImageType.memory);
      expect(ImageType.fromString("asset"), ImageType.asset);
    },
  );
}
