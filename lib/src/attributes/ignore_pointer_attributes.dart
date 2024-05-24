import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

class IgnorePointerAttributes
    implements DuitAttributes<IgnorePointerAttributes> {
  final bool? ignoring;

  IgnorePointerAttributes({
    this.ignoring,
  });

  factory IgnorePointerAttributes.fromJson(JSONObject json) {
    return IgnorePointerAttributes(
      ignoring: json["ignoring"],
    );
  }

  @override
  IgnorePointerAttributes copyWith(IgnorePointerAttributes other) {
    return IgnorePointerAttributes(
      ignoring: other.ignoring ?? ignoring,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName, {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
