import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a SizedBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class SizedBoxAttributes implements DuitAttributes<SizedBoxAttributes> {
  num? width, height;

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
