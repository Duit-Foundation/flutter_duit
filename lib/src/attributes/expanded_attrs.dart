import 'package:flutter_duit/flutter_duit.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a Expanded widget.
///
/// This class implements the [DUITAttributes] interface, allowing it to be used with DUIT widgets.
class ExpandedAttributes implements DUITAttributes<ExpandedAttributes> {
  final int? flex;

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
