import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class CenterAttributes implements DUITAttributes<CenterAttributes> {
  double? widthFactor;
  double? heightFactor;

  CenterAttributes({
    this.widthFactor,
    this.heightFactor,
  });

  factory CenterAttributes.fromJson(JSONObject json) {
    return CenterAttributes(
      widthFactor: json["widthFactor"],
      heightFactor: json["heightFactor"],
    );
  }

  @override
  CenterAttributes copyWith(CenterAttributes other) {
    return CenterAttributes(
      widthFactor: other.widthFactor ?? widthFactor,
      heightFactor: other.heightFactor ?? heightFactor,
    );
  }
}
