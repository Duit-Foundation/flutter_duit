import 'package:flutter/material.dart';
import 'package:flutter_duit/src/animations/index.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestWidget extends StatefulWidget {
  final void Function(_TestWidgetState)? onState;
  const _TestWidget({this.onState});
  @override
  State<_TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget>
    with TweenHelper<_TestWidget>, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.onState?.call(this);
  }

  @override
  Widget build(BuildContext context) => Container();
}

void main() {
  testWidgets(
    'createTween returns correct Tween type or throws',
    (tester) async {
      late _TestWidgetState state;
      await tester.pumpWidget(
        MaterialApp(
          home: _TestWidget(onState: (s) => state = s),
        ),
      );

      final colorTweenDesc = ColorTweenDescription(
        animatedPropKey: 'c',
        begin: Colors.red,
        end: Colors.blue,
        duration: const Duration(milliseconds: 1),
      );

      expect(state.createTween(colorTweenDesc), isA<ColorTween>());

      final baseTweenDesc = TweenDescription(
        animatedPropKey: 'x',
        begin: 0.0,
        end: 1.0,
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(baseTweenDesc), isA<Tween>());

      // DecorationTween
      final decorationTweenDesc = DecorationTweenDescription(
        animatedPropKey: 'd',
        begin: const BoxDecoration(color: Colors.red),
        end: const BoxDecoration(color: Colors.blue),
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(decorationTweenDesc), isA<DecorationTween>());

      // AlignmentTween
      final alignmentTweenDesc = AlignmentTweenDescription(
        animatedPropKey: 'a',
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(alignmentTweenDesc), isA<AlignmentTween>());

      // EdgeInsetsTween
      final edgeInsetsTweenDesc = EdgeInsetsTweenDescription(
        animatedPropKey: 'e',
        begin: const EdgeInsets.all(8),
        end: const EdgeInsets.all(16),
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(edgeInsetsTweenDesc), isA<EdgeInsetsTween>());

      // BoxConstraintsTween
      final boxConstraintsTweenDesc = BoxConstraintsTweenDescription(
        animatedPropKey: 'b',
        begin: const BoxConstraints(minWidth: 10, maxWidth: 20),
        end: const BoxConstraints(minWidth: 20, maxWidth: 40),
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(boxConstraintsTweenDesc),
          isA<BoxConstraintsTween>());

      // SizeTween
      final sizeTweenDesc = SizeTweenDescription(
        animatedPropKey: 's',
        begin: const Size(10, 10),
        end: const Size(20, 20),
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(sizeTweenDesc), isA<SizeTween>());

      // BorderTween
      final borderTweenDesc = BorderTweenDescription(
        animatedPropKey: 'br',
        begin: const Border(),
        end: const Border(),
        duration: const Duration(milliseconds: 1),
      );
      expect(state.createTween(borderTweenDesc), isA<BorderTween>());
    },
  );
}
