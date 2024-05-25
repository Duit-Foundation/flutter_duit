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

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName,
      {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    return switch (methodName) {
      "fromJson" =>
        RepaintBoundaryAttributes.fromJson(positionalParams!.first) as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
