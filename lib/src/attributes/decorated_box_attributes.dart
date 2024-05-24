import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents the attributes for a DecoratedBox widget.
///
/// This class implements the [DuitAttributes] interface, allowing it to be used with DUIT widgets.
class DecoratedBoxAttributes implements DuitAttributes<DecoratedBoxAttributes> {
  final Decoration? decoration;

  DecoratedBoxAttributes({
    required this.decoration,
  });

  factory DecoratedBoxAttributes.fromJson(JSONObject json) {
    return DecoratedBoxAttributes(
      decoration: ParamsMapper.convertToDecoration(json["decoration"]),
    );
  }

  @override
  DecoratedBoxAttributes copyWith(other) {
    return DecoratedBoxAttributes(
      decoration: other.decoration ?? decoration,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName, {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
