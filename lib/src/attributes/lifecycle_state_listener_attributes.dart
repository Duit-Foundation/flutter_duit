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
    );
  }

  factory LifecycleStateListenerAttributes.fromMap(Map<String, dynamic> map) {
    return LifecycleStateListenerAttributes(
      onStateChanged: ServerAction.fromJSON(map['onStateChanged']),
      onResumed: ServerAction.fromJSON(map['onResumed']),
      onInactive: ServerAction.fromJSON(map['onInactive']),
      onPaused: ServerAction.fromJSON(map['onPaused']),
      onDetached: ServerAction.fromJSON(map['onDetached']),
      onHidden: ServerAction.fromJSON(map['onHidden']),
    );
  }
}
