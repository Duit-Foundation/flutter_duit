import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for an elevated button widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
final class ElevatedButtonAttributes
    implements DuitAttributes<ElevatedButtonAttributes> {
  final bool? autofocus;
  final Clip? clipBehavior;

  ElevatedButtonAttributes({
    this.autofocus,
    this.clipBehavior,
  });

  factory ElevatedButtonAttributes.fromJson(JSONObject json) {
    return ElevatedButtonAttributes(
      autofocus: json["autofocus"],
      clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
    );
  }

  @override
  ElevatedButtonAttributes copyWith(ElevatedButtonAttributes other) {
    return ElevatedButtonAttributes(
      autofocus: other.autofocus ?? autofocus,
      clipBehavior: other.clipBehavior ?? clipBehavior,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        ElevatedButtonAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
