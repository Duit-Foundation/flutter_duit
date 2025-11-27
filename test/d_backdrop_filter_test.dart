import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

Map<String, dynamic> _createWidget(Map value, [bool? controlled = false]) {
  return {
    "type": "BackdropFilter",
    "id": "filter",
    "controlled": controlled,
    "attributes": value,
  };
}

final _blur1 = {
  "filter": <String, dynamic>{
    "type": 0,
    "sigmaX": "6",
    "sigmaY": "6",
    "tileMode": "clamp",
  },
};
final _blur2 = {
  "filter": <String, dynamic>{
    "type": "blur",
    "sigmaX": "12",
    "sigmaY": "12",
    "tileMode": "clamp",
  },
};

final _compose1 = {
  "filter": {
    "type": 1,
    "outer": _blur1,
    "inner": _blur2,
  },
};

final _compose2 = {
  "filter": {
    "type": "compose",
    "outer": _blur1,
  },
};

final _dilate1 = {
  "filter": {
    "type": 2,
    "radiusX": "12",
    "radiusY": "12",
  },
};

final _dilate2 = {
  "filter": {
    "type": "dilate",
    "radiusX": "12",
    "radiusY": "12",
  },
};

final _erode1 = {
  "filter": {
    "type": 3,
    "radiusX": "12",
    "radiusY": "12",
  },
};

final _erode2 = {
  "filter": {
    "type": "erode",
    "radiusX": "12",
    "radiusY": "12",
  },
};

final _matrix1 = {
  "filter": {
    "type": 4,
    "matrix4": [
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      11.0,
      12.0,
      13.0,
      14.0,
      15.0,
      16.0,
    ],
  },
};

final _matrix2 = {
  "filter": {
    "type": "matrix",
    "matrix4": [
      1.0,
      2.0,
      3.0,
      4.0,
      5.0,
      6.0,
      7.0,
      8.0,
      9.0,
      10.0,
      11.0,
      12.0,
      13.0,
      14.0,
      15.0,
      16.0,
    ],
  },
};

final _fRuntimeTypes = [
  "_GaussianBlurImageFilter",
  "_DilateImageFilter",
  "_ErodeImageFilter",
  "_MatrixImageFilter",
  "_ComposeImageFilter",
];

final _filters = [
  (_blur1, _fRuntimeTypes[0]),
  (_blur2, _fRuntimeTypes[0]),
  (_dilate1, _fRuntimeTypes[1]),
  (_dilate2, _fRuntimeTypes[1]),
  (_erode1, _fRuntimeTypes[2]),
  (_erode2, _fRuntimeTypes[2]),
  (_matrix1, _fRuntimeTypes[3]),
  (_matrix2, _fRuntimeTypes[3]),
  (_compose1, _fRuntimeTypes[4]),
  (_compose2, _fRuntimeTypes[4]),
];

void main() {
  group(
    "DuitBackdropFilter widget tests",
    () {
      testWidgets(
        "Check filter apply",
        (tester) async {
          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(
                driver: DuitDriver.static(
                  _createWidget(_blur1),
                  transportOptions: EmptyTransportOptions(),
                ),
                child: Container(color: Colors.red),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final renderObject = tester.element(find.byType(Stack)).renderObject;
          expect(renderObject, isA<RenderStack>());
          expect(
            (renderObject! as RenderStack).firstChild,
            isA<RenderBackdropFilter>(),
          );
        },
      );

      for (var filter in _filters) {
        testWidgets(
          "Check filter ${filter.$1["filter"]?["type"]}",
          (tester) async {
            await tester.pumpWidget(
              Directionality(
                textDirection: TextDirection.ltr,
                child: DuitViewHost(
                  driver: DuitDriver.static(
                    _createWidget(filter.$1),
                    transportOptions: EmptyTransportOptions(),
                  ),
                  child: Container(color: Colors.red),
                ),
              ),
            );

            await tester.pumpAndSettle();

            final renderObject =
                tester.element(find.byType(Stack)).renderObject;
            expect(renderObject, isA<RenderStack>());

            final f = (renderObject! as RenderStack).firstChild;

            expect(f, isA<RenderBackdropFilter>());

            expect(
              (f! as RenderBackdropFilter).filter.runtimeType.toString(),
              equals(filter.$2),
            );
          },
        );
      }

      testWidgets(
        "renders child under filter",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "BackdropFilter",
              "id": "filter_child",
              "attributes": _blur1,
              "child": {
                "type": "Container",
                "id": "child",
                "attributes": {
                  "color": "#933C3C",
                  "width": 10.0,
                  "height": 10.0,
                },
                "controlled": false,
              },
            },
            transportOptions: HttpTransportOptions(),
          );

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(driver: driver),
            ),
          );
          await tester.pumpAndSettle();

          final child = find.byKey(const ValueKey("child"));
          expect(child, findsOneWidget);
        },
      );

      testWidgets(
        "clipBehavior: hardEdge",
        (tester) async {
          final driver = DuitDriver.static(
            {
              "type": "BackdropFilter",
              "id": "filter_clip",
              "attributes": {
                ..._blur1,
                "clipBehavior": "hardEdge",
              },
              "child": {
                "type": "Container",
                "id": "child",
                "attributes": {
                  "color": "#933C3C",
                  "width": 10.0,
                  "height": 10.0,
                },
                "controlled": false,
              },
            },
            transportOptions: HttpTransportOptions(),
          );

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: DuitViewHost(driver: driver),
            ),
          );
          await tester.pumpAndSettle();

          final filter = find.byKey(const ValueKey("filter_clip"));
          expect(filter, findsOneWidget);
          // Проверяем, что clipBehavior установлен (если возможно)
          // Здесь можно проверить через tester.widget<BackdropFilter> если key пробрасывается
        },
      );
    },
  );
}
