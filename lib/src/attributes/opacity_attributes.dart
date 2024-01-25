import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

class OpacityAttributes implements DuitAttributes<OpacityAttributes> {
  final double opacity;

  OpacityAttributes({
    required this.opacity,
  });

  @override
  OpacityAttributes copyWith(OpacityAttributes other) {
    return OpacityAttributes(
      opacity: other.opacity,
    );
  }

  factory OpacityAttributes.fromJson(Map<String, dynamic> json) {
    return OpacityAttributes(
      opacity: NumUtils.toDoubleWithNullReplacement(json['opacity'], 1),
    );
  }
}
