import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/widgets.dart";
import "package:flutter_duit/src/controller/commands.dart";
import "package:meta/meta.dart";

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
      case PageViewNextPageCommand():
        _controller.nextPage(
          duration: command.duration,
          curve: command.curve,
        );
        break;
      case PageViewPreviousPageCommand():
        _controller.previousPage(
          duration: command.duration,
          curve: command.curve,
        );
        break;
      case PageViewAnimateToCommand():
        _controller.animateTo(
          command.offset,
          duration: command.duration,
          curve: command.curve,
        );
        break;
      case PageViewAnimateToPageCommand():
        _controller.animateToPage(
          command.page,
          duration: command.duration,
          curve: command.curve,
        );
        break;
      case PageViewJumpToCommand():
        _controller.jumpTo(command.value);
        break;
      case PageViewJumpToPageCommand():
        _controller.jumpToPage(command.page);
        break;
    }
  }
}
