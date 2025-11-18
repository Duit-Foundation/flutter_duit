import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/src/controller/data.dart";
import "package:flutter_duit/src/utils/index.dart";

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
  "dialog": DialogCommand.fromRemoteCommand,
  "pageView": _PageViewCommand.fromRemoteCommand,
};

/// An extension type that provides command specification functionality.
///
/// This extension type wraps a [RemoteCommand] and provides a method to convert
/// it into a specialized command instance based on its type. It uses the
/// [_commandLookup] table to find the appropriate factory constructor for
/// the command type.
extension type SpecCommand(RemoteCommand _command) {
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
    final type = _command.commandData["type"] as String;
    final ctor = _commandLookup[type];
    if (ctor == null) {
      throw UnrecognizedRemoteCommandExcepton(type);
    }
    return ctor(_command);
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
      action: OverlayAction.parse(source.getString(key: "action")),
      // transitionAnimationController not supported
      // sheetAnimationStyle not supported
    );
  }
}

final class DialogCommand extends RemoteCommand {
  final bool barrierDismissible, useSafeArea, useRootNavigator;
  final Color? barrierColor;
  final String? barrierLabel;
  final Offset? anchorPoint;
  // Specific duit properties
  final Map<String, dynamic> content;
  final ServerAction? onClose;
  final OverlayAction action;

  const DialogCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required this.barrierDismissible,
    required this.useSafeArea,
    required this.useRootNavigator,
    required this.barrierColor,
    required this.barrierLabel,
    required this.anchorPoint,
    required this.content,
    required this.onClose,
    required this.action,
  });

  factory DialogCommand.fromRemoteCommand(RemoteCommand command) {
    final source = DuitDataSource(command.commandData);
    return DialogCommand(
      content: source["content"] ?? const {},
      commandData: command.commandData,
      controllerId: overlayTriggerId,
      type: "dialog",
      barrierDismissible: source.getBool(
        "barrierDismissible",
        defaultValue: true,
      ),
      useSafeArea: source.getBool(
        "useSafeArea",
        defaultValue: true,
      ),
      useRootNavigator: source.getBool(
        "useRootNavigator",
        defaultValue: true,
      ),
      barrierColor: source.tryParseColor(key: "barrierColor"),
      barrierLabel: source.getString(key: "barrierLabel"),
      anchorPoint: source.offset(key: "anchorPoint"),
      onClose: source.getAction("onClose"),
      action: OverlayAction.parse(source.getString(key: "action")),
      // transitionAnimationController not supported
      // sheetAnimationStyle not supported
    );
  }
}

base class _PageViewCommand extends RemoteCommand {
  const _PageViewCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
  });

  factory _PageViewCommand.fromRemoteCommand(RemoteCommand command) {
    final source = DuitDataSource(command.commandData);

    final action = PageViewAction.parse(source.getString(key: "action"));

    return switch (action) {
      PageViewAction.nextPage => PageViewNextPageCommand(
          type: command.type,
          commandData: command.commandData,
          controllerId: command.controllerId,
          duration: source.duration(),
          curve: source.curve(defaultValue: Curves.linear)!,
        ),
      PageViewAction.prevPage => PageViewPreviousPageCommand(
          type: command.type,
          commandData: command.commandData,
          controllerId: command.controllerId,
          duration: source.duration(),
          curve: source.curve(defaultValue: Curves.linear)!,
        ),
      PageViewAction.animateTo => PageViewAnimateToCommand(
          type: command.type,
          commandData: command.commandData,
          controllerId: command.controllerId,
          duration: source.duration(),
          curve: source.curve(defaultValue: Curves.linear)!,
          offset: source.getDouble(key: "offset"),
        ),
      PageViewAction.animateToPage => PageViewAnimateToPageCommand(
          type: command.type,
          commandData: command.commandData,
          controllerId: command.controllerId,
          duration: source.duration(),
          curve: source.curve(defaultValue: Curves.linear)!,
          page: source.getInt(key: "page"),
        ),
      PageViewAction.jumpTo => PageViewJumpToCommand(
          type: command.type,
          commandData: command.commandData,
          controllerId: command.controllerId,
          value: source.getDouble(key: "value"),
        ),
      PageViewAction.jumpToPage => PageViewJumpToPageCommand(
          type: command.type,
          commandData: command.commandData,
          controllerId: command.controllerId,
          page: source.getInt(key: "page"),
        ),
    };
  }
}

base class _PageViewAnimatedCommand extends _PageViewCommand {
  final Duration duration;
  final Curve curve;

  const _PageViewAnimatedCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required this.duration,
    required this.curve,
  });
}

final class PageViewPreviousPageCommand extends _PageViewAnimatedCommand {
  const PageViewPreviousPageCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required super.duration,
    required super.curve,
  });
}

final class PageViewNextPageCommand extends _PageViewAnimatedCommand {
  const PageViewNextPageCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required super.duration,
    required super.curve,
  });
}

final class PageViewAnimateToCommand extends _PageViewAnimatedCommand {
  final double offset;

  const PageViewAnimateToCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required super.duration,
    required super.curve,
    required this.offset,
  });
}

final class PageViewAnimateToPageCommand extends _PageViewAnimatedCommand {
  final int page;

  const PageViewAnimateToPageCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required super.duration,
    required super.curve,
    required this.page,
  });
}

final class PageViewJumpToCommand extends _PageViewCommand {
  final double value;

  const PageViewJumpToCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required this.value,
  });
}

final class PageViewJumpToPageCommand extends _PageViewCommand {
  final int page;

  const PageViewJumpToPageCommand({
    required super.commandData,
    required super.controllerId,
    required super.type,
    required this.page,
  });
}
