import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/models/attended_model.dart';

final class MetaAttributes extends AttendedModel<Map<String, dynamic>>
    implements DuitAttributes<MetaAttributes> {
  MetaAttributes({
    required super.value,
  });

  factory MetaAttributes.fromJson(Map<String, dynamic> json) {
    return MetaAttributes(
      value: json,
    );
  }

  @override
  MetaAttributes copyWith(MetaAttributes other) {
    return MetaAttributes(
      value: other.value,
    );
  }
}
