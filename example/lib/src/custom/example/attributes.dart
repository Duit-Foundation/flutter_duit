import 'package:flutter_duit/flutter_duit.dart';

final class ExampleCustomWidgetAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<ExampleCustomWidgetAttributes> {
  final String? random;

  ExampleCustomWidgetAttributes({
    required this.random,
    required super.parentBuilderId,
    required super.affectedProperties,
  });

  factory ExampleCustomWidgetAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);

    return ExampleCustomWidgetAttributes(
      random: view["random"],
      parentBuilderId: view.parentBuilderId,
      affectedProperties: view.affectedProperties,
    );
  }

  @override
  ExampleCustomWidgetAttributes copyWith(other) {
    return ExampleCustomWidgetAttributes(
        random: other.random ?? random,
        parentBuilderId: other.parentBuilderId ?? parentBuilderId,
        affectedProperties: other.affectedProperties ?? affectedProperties);
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        ExampleCustomWidgetAttributes.fromJson(positionalParams!.first)
            as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
