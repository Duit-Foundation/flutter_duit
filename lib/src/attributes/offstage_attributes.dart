import 'package:flutter_duit/flutter_duit.dart';

final class OffstageAttributes extends AnimatedPropertyOwner
    implements DuitAttributes<OffstageAttributes> {
  final bool offstage;

  OffstageAttributes(
      {required this.offstage,
      required super.affectedProperties,
      required super.parentBuilderId});

  factory OffstageAttributes.fromJson(Map<String, dynamic> json) {
    final view = AnimatedPropHelper(json);
    return OffstageAttributes(
      offstage: json["offstage"],
      affectedProperties: view.affectedProperties,
      parentBuilderId: view.parentBuilderId,
    );
  }

  @override
  OffstageAttributes copyWith(OffstageAttributes other) {
    return OffstageAttributes(
      offstage: assignIfNotNull(other.offstage, offstage),
      affectedProperties:
          assignIfNotNull(other.affectedProperties, affectedProperties),
      parentBuilderId: assignIfNotNull(other.parentBuilderId, parentBuilderId),
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName,
      {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    return switch (methodName) {
      'fromJson' => this as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
