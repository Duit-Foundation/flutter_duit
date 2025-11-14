// ignore_for_file: prefer_const_constructors

import "dart:io";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/controller/commands.dart";
import "package:flutter_duit/src/controller/data.dart";
import "package:flutter_test/flutter_test.dart";

const _pageViewCommKey = "pageView";
const _commKey = "command";

final _prevPage = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "action": "previousPage",
    "duration": 1000,
    "type": _pageViewCommKey,
  },
);

final _nextPage = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "action": "nextPage",
    "duration": 1000,
    "type": _pageViewCommKey,
  },
);

final _animateTo = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "action": "animateTo",
    "duration": 1000,
    "type": _pageViewCommKey,
    "offset": 128.0,
  },
);

final _animateToPage = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "action": "animateToPage",
    "duration": 1000,
    "type": _pageViewCommKey,
    "page": 1,
  },
);

final _jumpTo = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "action": "jumpTo",
    "type": _pageViewCommKey,
    "value": 128.0,
  },
);

final _jumpToPage = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "action": "jumpToPage",
    "type": _pageViewCommKey,
    "page": 1,
  },
);

final _invalidCommand = RemoteCommand(
  controllerId: "",
  type: _commKey,
  commandData: <String, dynamic>{
    "type": "LOL",
  },
);

void main() {
  test(
      "SpecCommand must throw exception when receive command with unknown type",
      () {
    expect(
      () => SpecCommand(_invalidCommand).specify(),
      throwsA(isA<UnrecognizedRemoteCommandExcepton>()),
    );
  });
  group(
    "Data test",
    () {
      group(
        "PageViewAction",
        () {
          test(
            "PageViewAction must throw err on invalid value",
            () {
              expect(() => PageViewAction.parse("some"), throwsArgumentError);
            },
          );

          test(
            "PageViewAction parse value as expected",
            () {
              expect(
                PageViewAction.parse("animateTo"),
                PageViewAction.animateTo,
              );
              expect(
                PageViewAction.parse("animateToPage"),
                PageViewAction.animateToPage,
              );
              expect(PageViewAction.parse("jumpTo"), PageViewAction.jumpTo);
              expect(
                PageViewAction.parse("jumpToPage"),
                PageViewAction.jumpToPage,
              );
              expect(PageViewAction.parse("nextPage"), PageViewAction.nextPage);
              expect(
                PageViewAction.parse("previousPage"),
                PageViewAction.prevPage,
              );
            },
          );
        },
      );

      group(
        "OverlayAction",
        () {
          test(
            "OverlayAction must return default value on invalid input",
            () {
              expect(OverlayAction.parse("some"), OverlayAction.open);
            },
          );

          test(
            "OverlayAction parse value as expected",
            () {
              expect(OverlayAction.parse("open"), OverlayAction.open);
              expect(OverlayAction.parse("close"), OverlayAction.close);
            },
          );
        },
      );
    },
  );
  group(
    "RemoteCommand specificators test",
    () {
      group("Page view controlle commands", () {
        test("PageViewPreviousPageCommand parsed", () {
          final command = SpecCommand(_prevPage).specify();
          expect(command, isA<PageViewPreviousPageCommand>());
        });

        test("PageViewNextPageCommand parsed", () {
          final command = SpecCommand(_nextPage).specify();
          expect(command, isA<PageViewNextPageCommand>());
        });

        test("PageViewAnimateToCommand parsed", () {
          final command = SpecCommand(_animateTo).specify();
          expect(command, isA<PageViewAnimateToCommand>());
        });

        test("PageViewAnimateToPageCommand parsed", () {
          final command = SpecCommand(_animateToPage).specify();
          expect(command, isA<PageViewAnimateToPageCommand>());
        });

        test("PageViewJumpToCommand parsed", () {
          final command = SpecCommand(_jumpTo).specify();
          expect(command, isA<PageViewJumpToCommand>());
        });

        test("PageViewJumpToPageCommand parsed", () {
          final command = SpecCommand(_jumpToPage).specify();
          expect(command, isA<PageViewJumpToPageCommand>());
        });
      });
    },
  );
}
