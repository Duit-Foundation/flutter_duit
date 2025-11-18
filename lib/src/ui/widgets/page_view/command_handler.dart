import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/src/controller/commands.dart";
import "package:meta/meta.dart";

/// A mixin to provide command handling capabilities for widgets that use a [PageController].
///
/// `PageViewCommandHandler` encapsulates the initialization and disposal of the internal
/// [PageController], and provides a [handleCommand] method for interpreting remote
/// commands related to page view navigation (such as next/previous page, animating to
/// a particular offset or page).
///
/// Classes mixing in this handler must call [initCommandHandler] to initialize the
/// controller, and [disposeCommandHandler] when the controller is no longer needed.
///
/// Example usage:
/// ```dart
/// class MyWidgetState extends State<MyWidget> with PageViewCommandHandler {
///   @override
///   void initState() {
///     super.initState();
///     initCommandHandler();
///   }
///
///   @override
///   void dispose() {
///     disposeCommandHandler();
///     super.dispose();
///   }
/// }
/// ```
mixin PageViewCommandHandler {
  late final PageController _controller;

  @preferInline
  PageController get pageController => _controller;

  @preferInline
  void initCommandHandler() => _controller = PageController();

  @preferInline
  void disposeCommandHandler() => _controller.dispose();

  @internal
  Future<void> handleCommand(
    RemoteCommand command,
  ) async {
    switch (command) {
      case PageViewNextPageCommand(
          :final duration,
          :final curve,
        ):
        _controller.nextPage(
          duration: duration,
          curve: curve,
        );
        break;
      case PageViewPreviousPageCommand(
          :final duration,
          :final curve,
        ):
        _controller.previousPage(
          duration: duration,
          curve: curve,
        );
        break;
      case PageViewAnimateToCommand(
          :final duration,
          :final curve,
          :final offset,
        ):
        _controller.animateTo(
          offset,
          duration: duration,
          curve: curve,
        );
        break;
      case PageViewAnimateToPageCommand(
          :final duration,
          :final curve,
          :final page,
        ):
        _controller.animateToPage(
          page,
          duration: duration,
          curve: curve,
        );
        break;
      case PageViewJumpToCommand(:final value):
        _controller.jumpTo(value);
        break;
      case PageViewJumpToPageCommand(:final page):
        _controller.jumpToPage(page);
        break;
    }
  }
}
