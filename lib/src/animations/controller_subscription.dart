import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';

import 'animation_command.dart';

/// The UIElementController extension allows the driver to interact with DuitAnimationBuilder,
/// sending AnimationCommand objects via stream, and DuitAnimationBuilder to subscribe
/// to new commands by registering an event handler
extension AnimationCommandChannelExtension on UIElementController {
  /// Map of command streams
  static final Map<String, StreamController<AnimationCommand>>
      _commandChannels = {};

  /// The method creates a new stream controller and adds an event listener for it
  void listenCommand(Future<void> Function(AnimationCommand command) callback) {
    final sc = StreamController<AnimationCommand>();
    _commandChannels[id] = sc;

    sc.stream.listen(callback);
  }

  /// The method selects the desired controller from the pool
  /// and passes it the AnimationCommand object
  void emitCommand(AnimationCommand command) {
    final channel = _commandChannels[command.controllerId];

    if (channel != null) {
      channel.add(command);
    }
  }

  /// Removes and close the controller from the pool
  void removeCommandListener() {
    _commandChannels.remove(id)?.close();
  }
}
