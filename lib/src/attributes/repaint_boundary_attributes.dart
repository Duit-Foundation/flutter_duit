import "package:duit_kernel/duit_kernel.dart";

final class RepaintBoundaryAttributes
    implements DuitAttributes<RepaintBoundaryAttributes> {
  final int? childIndex;

  const RepaintBoundaryAttributes({
    required this.childIndex,
  });

  factory RepaintBoundaryAttributes.fromJson(Map<String, dynamic> json) {
    return RepaintBoundaryAttributes(
      childIndex: json['childIndex'],
    );
  }

  @override
  RepaintBoundaryAttributes copyWith(RepaintBoundaryAttributes other) {
    return RepaintBoundaryAttributes(
      childIndex: other.childIndex,
    );
  }
}
