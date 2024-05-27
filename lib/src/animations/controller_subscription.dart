import 'dart:async';

import 'package:duit_kernel/duit_kernel.dart';

import 'animation_command.dart';

extension ControllerSubcriptionExtension on UIElementController {
  static final Map<String, StreamController<AnimationCommand>>
      _commandChannels = {};

  void listenCommand(Future<void> Function(AnimationCommand command) callback) {
    final sc = StreamController<AnimationCommand>();
    _commandChannels[id] = sc;

    sc.stream.listen(callback);
  }

  void emitCommand(AnimationCommand command) {
    final channel = _commandChannels[command.controllerId];

    if (channel != null) {
      channel.add(command);
    }
  }

  void removeCommandListener() {
    _commandChannels.remove(id)?.close();
  }
}
