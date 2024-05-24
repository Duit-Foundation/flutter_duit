import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a center widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class CenterAttributes implements DuitAttributes<CenterAttributes> {
  final double? widthFactor;
  final double? heightFactor;

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

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName, {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
