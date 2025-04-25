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
  final ButtonStyle? style;
  final ServerAction? onLongPress;
  // final FocusNode? focusNode;

  ElevatedButtonAttributes({
    this.autofocus,
    this.clipBehavior,
    this.style,
    this.onLongPress,
  });

  factory ElevatedButtonAttributes.fromJson(JSONObject json) {
    return ElevatedButtonAttributes(
      autofocus: json["autofocus"],
      style: AttributeValueMapper.toButtonStyle(json["style"]),
      clipBehavior: AttributeValueMapper.toClip(json["clipBehavior"]),
      onLongPress: JsonUtils.nullOrParse(
        "onLongPress",
        json,
        ServerAction.parse,
      ),
    );
  }

  @override
  ElevatedButtonAttributes copyWith(ElevatedButtonAttributes other) {
    return ElevatedButtonAttributes(
      autofocus: other.autofocus ?? autofocus,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      style: other.style ?? style,
      onLongPress: other.onLongPress ?? onLongPress,
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
