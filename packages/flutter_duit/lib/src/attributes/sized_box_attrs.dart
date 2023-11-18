import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SizedBoxAttributes implements DUITAttributes<SizedBoxAttributes> {
  double? width;
  double? height;

  SizedBoxAttributes({
    this.height,
    this.width,
  });

  factory SizedBoxAttributes.fromJson(JSONObject json) {
    return SizedBoxAttributes(
      width: json["width"],
      height: json["height"],
    );
  }

  @override
  SizedBoxAttributes copyWith(SizedBoxAttributes other) {
    return SizedBoxAttributes(
      width: other.width ?? width,
      height: other.height ?? height,
    );
  }
}
