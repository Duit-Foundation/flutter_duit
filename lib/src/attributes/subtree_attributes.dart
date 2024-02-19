import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/utils/index.dart';

final class SubtreeAttributes implements DuitAttributes<SubtreeAttributes> {
  final Map<String, dynamic>? data;

  SubtreeAttributes({
    this.data,
  });

  factory SubtreeAttributes.fromJson(JSONObject json) {
    return SubtreeAttributes(
      data: json,
    );
  }

  @override
  SubtreeAttributes copyWith(SubtreeAttributes other) {
    return SubtreeAttributes(
      data: other.data ?? data,
    );
  }
}
