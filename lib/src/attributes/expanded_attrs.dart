import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

class ExpandedAttributes implements DUITAttributes<ExpandedAttributes> {
  int? flex;

  ExpandedAttributes({
    required this.flex,
  });

  @override
  ExpandedAttributes copyWith(ExpandedAttributes other) {
    return ExpandedAttributes(
      flex: other.flex ?? flex,
    );
  }

  factory ExpandedAttributes.fromJson(JSONObject map) {
    num flx = map['flex'] ?? 1;

    return ExpandedAttributes(
      flex: flx.toInt(),
    );
  }
}
