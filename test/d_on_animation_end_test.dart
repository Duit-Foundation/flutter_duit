import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/widgets/index.dart";
import "package:flutter_test/flutter_test.dart";

final _action = {
  "executionType": 1, //local
  "event": "local_exec",
  "payload": {
    "type": "update",
    "updates": {
      "op1": {
        "opacity": 0.1,
      },
    },
  },
};

Map<String, dynamic> _createWidget(double? opacity) {
  return {
    "type": "AnimatedOpacity",
    "id": "op1",
    "controlled": true,
    "attributes": {
      "opacity": opacity,
      "duration": 500,
    },
    "child": {
      "type": "Text",
      "id": "text1",
      "controlled": false,
      "attributes": {
        "data": "Text 1",
      },
    },
  };
}

void main() {
  group(
    "OnAnimationEnd mixin tests",
    () {
      testWidgets(
        "test callback not null",
        (t) async {
          final w = _createWidget(0.5);

          w["attributes"] = <String, dynamic>{
            ...w["attributes"],
            "onEnd": _action,
          };

          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  w,
                  transportOptions: EmptyTransportOptions(),
                ),
              ),
            ),
          );

          await t.pumpAndSettle();

          final widget = t.widget<DuitAnimatedOpacity>(
            find.byType(
              DuitAnimatedOpacity,
            ),
          );

          final fW = t.widget<AnimatedOpacity>(
            find.byKey(
              const ValueKey("op1"),
            ),
          );

          final callback =
              widget.controller.attributes.payload.getAction("onEnd");
          expect(callback, isNotNull);
          expect(callback, isA<LocalAction>());
          expect(fW.onEnd, isNotNull);
        },
      );

      testWidgets(
        "test callback is null",
        (t) async {
          await t.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget(0.5),
                  transportOptions: EmptyTransportOptions(),
                ),
              ),
            ),
          );

          await t.pumpAndSettle();

          final widget = t.widget<DuitAnimatedOpacity>(
            find.byType(
              DuitAnimatedOpacity,
            ),
          );

          final fW = t.widget<AnimatedOpacity>(
            find.byKey(
              const ValueKey("op1"),
            ),
          );

          final callback =
              widget.controller.attributes.payload.getAction("onEnd");

          expect(callback, isNull);
          expect(callback, isA<void>());
          expect(fW.onEnd, isNull);
        },
      );
    },
  );
}
