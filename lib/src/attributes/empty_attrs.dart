import 'package:duit_kernel/duit_kernel.dart';

/// Represents the attributes for an empty widget.
///
/// This class can be used to represent an empty widget that has no specific attributes or properties.
final class EmptyAttributes implements DuitAttributes<EmptyAttributes> {
  @override
  EmptyAttributes copyWith(EmptyAttributes other) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(String methodName, {Iterable? positionalParams, Map<String, dynamic>? namedParams}) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
