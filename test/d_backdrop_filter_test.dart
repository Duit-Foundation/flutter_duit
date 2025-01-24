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

const _blur1 = {
  "filter": {
    "type": 0,
    "sigmaX": "6",
    "sigmaY": "6",
  },
};
const _blur2 = {
  "filter": {
    "type": "blur",
    "sigmaX": "12",
    "sigmaY": "12",
    "tileMode": "clamp",
  },
};

const _compose1 = {
  "filter": {
    "type": 1,
    "outer": _blur1,
    "inner": _blur2,
  }
};

const _compose2 = {
  "filter": {
    "type": "compose",
    "outer": _blur1,
  }
};

const _dilate1 = {
  "filter": {
    "type": 2,
    "radiusX": "12",
    "radiusY": "12",
  }
};

const _dilate2 = {
  "filter": {
    "type": "dilate",
    "radiusX": "12",
    "radiusY": "12",
  }
};

const _erode1 = {
  "filter": {
    "type": 3,
    "radiusX": "12",
    "radiusY": "12",
  }
};

const _erode2 = {
  "filter": {
    "type": "erode",
    "radiusX": "12",
    "radiusY": "12",
  }
};

const _matrix1 = {
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
      16.0
    ],
  }
};

const _matrix2 = {
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
      16.0
    ],
  }
};

final _fRuntimeTypes = [
  "_GaussianBlurImageFilter",
  "_DilateImageFilter",
  "_ErodeImageFilter",
  "_MatrixImageFilter",
  "_ComposeImageFilter"
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
                  transportOptions: HttpTransportOptions(),
                  enableDevMetrics: false,
                ),
                child: Container(color: Colors.red),
              ),
            ),
          );

          await tester.pumpAndSettle();

          final RenderObject? renderObject =
              tester.element(find.byType(Stack)).renderObject;
          expect(renderObject, isA<RenderStack>());
          expect((renderObject as RenderStack).firstChild,
              isA<RenderBackdropFilter>());
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
                    transportOptions: HttpTransportOptions(),
                    enableDevMetrics: false,
                  ),
                  child: Container(color: Colors.red),
                ),
              ),
            );

            await tester.pumpAndSettle();

            final RenderObject? renderObject =
                tester.element(find.byType(Stack)).renderObject;
            expect(renderObject, isA<RenderStack>());

            final f = (renderObject as RenderStack).firstChild;

            expect(f, isA<RenderBackdropFilter>());

            f as RenderBackdropFilter;
            expect(f.filter.runtimeType.toString(), equals(filter.$2));
          },
        );
      }
    },
  );
}
