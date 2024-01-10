import 'package:duit_kernel/duit_kernel.dart';

class LifecycleStateListenerAttributes extends DuitAttributes {
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
      onStateChanged: ServerAction.fromJSON(json['onStateChanged']),
      onResumed: ServerAction.fromJSON(json['onResumed']),
      onInactive: ServerAction.fromJSON(json['onInactive']),
      onPaused: ServerAction.fromJSON(json['onPaused']),
      onDetached: ServerAction.fromJSON(json['onDetached']),
      onHidden: ServerAction.fromJSON(json['onHidden']),
    );
  }
}
