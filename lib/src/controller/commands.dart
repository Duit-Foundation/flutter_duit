import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/controller/data.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A lookup table that maps command types to their corresponding factory constructors.
///
/// This constant map associates string identifiers with functions that can create
/// specialized command instances from generic [RemoteCommand] objects. Each entry
/// maps a command type string to a factory function that knows how to parse
/// the payload and create the appropriate command subclass.
///
/// Currently supports:
/// - `"animation"`: Creates [AnimationCommand] instances for animation control
const _commandLookup = <String, RemoteCommand Function(RemoteCommand)>{
  "animation": AnimationCommand.fromRemoteCommand,
  "bottomSheet": BottomSheetCommand.fromRemoteCommand,
};

/// An extension type that provides command specification functionality.
///
/// This extension type wraps a [RemoteCommand] and provides a method to convert
/// it into a specialized command instance based on its type. It uses the
/// [_commandLookup] table to find the appropriate factory constructor for
/// the command type.
extension type SpecCommand(RemoteCommand command) {
  /// Converts the generic [RemoteCommand] into a specialized command instance.
  ///
  /// This method looks up the command type in the [_commandLookup] table and
  /// uses the corresponding factory constructor to create a properly typed
  /// command instance. If the command type is not found in the lookup table,
  /// it throws an [ArgumentError] with details about the unknown command type.
  ///
  /// Returns a specialized command instance that corresponds to the original
  /// command's type.
  ///
  /// Throws an [ArgumentError] if the command type is not supported.
  @preferInline
  RemoteCommand specify() {
    final type = command.commandData["type"] as String;
    final ctor = _commandLookup[type];
    if (ctor == null) {
      throw Exception("Unknown command type: $type");
    }

    return ctor(command);
  }
}

/// A command that controls animation behavior for a specific animated property.
///
/// This command extends [RemoteCommand] to provide animation-specific functionality.
/// It contains information about which animated property to control and what
/// animation method to apply.
final class AnimationCommand extends RemoteCommand {
  /// The key identifying the animated property to be controlled.
  ///
  /// This key is used to match the animation with the corresponding
  /// animated property in the animation system.
  final String animatedPropKey;

  /// The animation method to be executed.
  ///
  /// Defines what action should be performed on the animation,
  /// such as play, pause, reverse, etc.
  final AnimationMethod method;

  final AnimationTrigger trigger;

  /// Creates an [AnimationCommand] with the specified parameters.
  ///
  /// All parameters are required to ensure the command has complete
  /// information for animation control.
  const AnimationCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required this.animatedPropKey,
    required this.method,
    required this.trigger,
  });

  /// Creates an [AnimationCommand] from a generic [RemoteCommand].
  ///
  /// This factory constructor extracts animation-specific data from the
  /// payload of a [RemoteCommand] and creates a properly typed
  /// [AnimationCommand] instance.
  ///
  /// The payload is expected to contain:
  /// - `animatedPropKey`: A string identifying the animated property
  /// - Animation method information that can be parsed by [DuitDataSource.animationMethod]
  ///
  /// Throws if the payload doesn't contain the required animation data.
  factory AnimationCommand.fromRemoteCommand(RemoteCommand command) {
    final source = DuitDataSource(command.commandData);
    return AnimationCommand(
      trigger: source.animationTrigger(),
      animatedPropKey: source.getString(key: "animatedPropKey"),
      method: source.animationMethod(),
      controllerId: command.controllerId,
      type: "animation",
      commandData: command.commandData,
    );
  }
}

/// A command representing the configuration and action for displaying or closing a BottomSheet.
///
/// This command is typically sent from the remote layer to instruct the UI to show or hide
/// a modal bottom sheet with the specified content and options. It encapsulates all the
/// parameters required to configure the appearance and behavior of the BottomSheet, such as
/// scroll control, background color, shape, and more.
///
/// The [action] property determines whether the BottomSheet should be opened or closed.
/// The [onClose] callback can be used to trigger an action when the BottomSheet is dismissed.
final class BottomSheetCommand extends RemoteCommand {
  // showModalBottomSheet properties
  final bool isScrollControlled,
      isDismissible,
      useSafeArea,
      useRootNavigator,
      enableDrag;
  final bool? showDragHandle;
  final double scrollControlDisabledMaxHeightRatio;
  final BoxConstraints? constraints;
  final Offset? anchorPoint;
  final Color? backgroundColor, barrierColor;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  // Specific duit properties
  final Map<String, dynamic> content;
  final ServerAction? onClose;
  final OverlayAction action;

  const BottomSheetCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required this.content,
    required this.isScrollControlled,
    required this.isDismissible,
    required this.useSafeArea,
    required this.useRootNavigator,
    required this.enableDrag,
    required this.showDragHandle,
    required this.scrollControlDisabledMaxHeightRatio,
    required this.backgroundColor,
    required this.barrierColor,
    required this.shape,
    required this.clipBehavior,
    required this.constraints,
    required this.anchorPoint,
    required this.onClose,
    required this.action,
  });

  factory BottomSheetCommand.fromRemoteCommand(RemoteCommand command) {
    final source = DuitDataSource(command.commandData);
    return BottomSheetCommand(
      content: source["content"] ?? const {},
      controllerId: overlayTriggerId,
      type: "bottomSheet",
      commandData: command.commandData,
      isScrollControlled: source.getBool("isScrollControlled"),
      backgroundColor: source.tryParseColor(key: "backgroundColor"),
      barrierColor: source.tryParseColor(key: "barrierColor"),
      shape: source.shapeBorder(key: "shape"),
      clipBehavior: source.clipBehavior(key: "clipBehavior"),
      useSafeArea: source.getBool("useSafeArea"),
      useRootNavigator: source.getBool("useRootNavigator"),
      isDismissible: source.getBool(
        "isDismissible",
        defaultValue: true,
      ),
      enableDrag: source.getBool(
        "enableDrag",
        defaultValue: true,
      ),
      showDragHandle: source.tryGetBool("showDragHandle"),
      constraints: source.boxConstraints(key: "constraints"),
      anchorPoint: source.offset(key: "anchorPoint"),
      scrollControlDisabledMaxHeightRatio: source.getDouble(
        key: "scrollControlDisabledMaxHeightRatio",
        defaultValue: defaultScrollControlDisabledMaxHeightRatio,
      ),
      onClose: source.getAction("onClose"),
      action: OverlayAction.parse(source.getString(key: 'action')),
      // transitionAnimationController not supported
      // sheetAnimationStyle not supported
    );
  }
}
