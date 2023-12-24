import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class AlignAttributes implements DuitAttributes<AlignAttributes> {
  final AlignmentGeometry? alignment;
  final double? widthFactor, heightFactor;

  const AlignAttributes({
    this.alignment,
    this.widthFactor,
    this.heightFactor,
  });

  factory AlignAttributes.fromJson(JSONObject json) {
    return AlignAttributes(
      alignment: ParamsMapper.convertToAlignment(json["alignment"]),
      widthFactor: NumUtils.toDouble(json["widthFactor"]),
      heightFactor: NumUtils.toDouble(json["heightFactor"]),
    );
  }

  @override
  AlignAttributes copyWith(AlignAttributes other) {
    return AlignAttributes(
      alignment: other.alignment ?? alignment,
      widthFactor: other.widthFactor ?? widthFactor,
      heightFactor: other.heightFactor ?? heightFactor,
    );
  }
}
