import 'package:duit_kernel/duit_kernel.dart';

class LifecycleStateListenerAttributes
    implements DuitAttributes<LifecycleStateListenerAttributes> {
  final ServerAction? onStateChanged,
      onResumed,
      onInactive,
      onPaused,
      onDetached,
      onHidden;

  LifecycleStateListenerAttributes({
    this.onStateChanged,
    this.onResumed,
    this.onInactive,
    this.onPaused,
    this.onDetached,
    this.onHidden,
  }) : super() {
    final haveStateCallbacks = onStateChanged != null ||
        onResumed != null ||
        onInactive != null ||
        onPaused != null ||
        onDetached != null ||
        onHidden != null;

    assert(
        !haveStateCallbacks && onStateChanged != null ||
            haveStateCallbacks && onStateChanged == null,
        'The attribute must contain at least one action to listen to '
        'the application lifecycle event, or a general callback');
  }

  @override
  copyWith(other) {
    return LifecycleStateListenerAttributes(
      onStateChanged: other.onStateChanged ?? onStateChanged,
      onResumed: other.onResumed ?? onResumed,
      onInactive: other.onInactive ?? onInactive,
      onPaused: other.onPaused ?? onPaused,
      onDetached: other.onDetached ?? onDetached,
      onHidden: other.onHidden ?? onHidden,
    );
  }

  factory LifecycleStateListenerAttributes.fromJson(Map<String, dynamic> json) {
    return LifecycleStateListenerAttributes(
      onStateChanged: json['onStateChanged'] != null
          ? ServerAction.parse(json['onStateChanged'])
          : null,
      onResumed: json['onResumed'] != null
          ? ServerAction.parse(json['onResumed'])
          : null,
      onInactive: json['onInactive'] != null
          ? ServerAction.parse(json['onInactive'])
          : null,
      onPaused: json['onPaused'] != null
          ? ServerAction.parse(json['onPaused'])
          : null,
      onDetached: json['onDetached'] != null
          ? ServerAction.parse(json['onDetached'])
          : null,
      onHidden: json['onHidden'] != null
          ? ServerAction.parse(json['onHidden'])
          : null,
    );
  }

  @override
  ReturnT dispatchInternalCall<ReturnT>(
    String methodName, {
    Iterable? positionalParams,
    Map<String, dynamic>? namedParams,
  }) {
    return switch (methodName) {
      "fromJson" =>
        LifecycleStateListenerAttributes.fromJson(positionalParams!.first)
            as ReturnT,
      String() => throw UnimplementedError("$methodName is not implemented"),
    };
  }
}
