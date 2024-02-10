import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

class FittedBoxAttributes implements DuitAttributes<FittedBoxAttributes> {
  final BoxFit? fit;
  final Clip? clipBehavior;
  final AlignmentGeometry? alignment;

  FittedBoxAttributes({
    required this.clipBehavior,
    required this.alignment,
    required this.fit,
  });

  factory FittedBoxAttributes.fromJson(Map<String, dynamic> json) {
    return FittedBoxAttributes(
      fit: ParamsMapper.convertToBoxFit(json['fit']),
      clipBehavior: ParamsMapper.convertToClip(json['clipBehavior']),
      alignment: ParamsMapper.convertToAlignment(json['alignment']),
    );
  }

  @override
  FittedBoxAttributes copyWith(FittedBoxAttributes other) {
    return FittedBoxAttributes(
      fit: other.fit ?? fit,
      clipBehavior: other.clipBehavior ?? clipBehavior,
      alignment: other.alignment ?? alignment,
    );
  }
}
