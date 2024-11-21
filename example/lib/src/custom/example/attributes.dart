import 'package:duit_kernel/duit_kernel.dart';

class ExampleCustomWidgetAttributes
    implements DuitAttributes<ExampleCustomWidgetAttributes> {
  String? random;

  ExampleCustomWidgetAttributes({
    required this.random,
  });

  @override
  ExampleCustomWidgetAttributes copyWith(other) {
    return ExampleCustomWidgetAttributes(
      random: other.random ?? random,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    // TODO: implement dispatchInternalCall
    throw UnimplementedError();
  }
}
