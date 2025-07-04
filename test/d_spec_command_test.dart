import 'package:flutter_test/flutter_test.dart';
import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/controller/commands.dart';

void main() {
  group('SpecCommand', () {
    test(
        'should convert RemoteCommand with type "animation" to AnimationCommand',
        () {
      // ignore: prefer_const_constructors
      final remote = RemoteCommand(
        controllerId: 'controller1',
        type: 'animation',
        payload: {
          'animatedPropKey': 'opacity',
          'method': 0,
          'trigger': 0,
        },
      );
      final specified = SpecCommand(remote).specify();
      expect(specified, isA<AnimationCommand>());
      final anim = specified as AnimationCommand;
      expect(anim.animatedPropKey, 'opacity');
      expect(anim.method, AnimationMethod.forward);
      expect(anim.controllerId, 'controller1');
      expect(anim.type, 'animation');
    });

    test('should throw ArgumentError for unknown command type', () {
      const remote = RemoteCommand(
        controllerId: 'controller2',
        type: 'unknown_type',
        payload: {},
      );
      expect(() => SpecCommand(remote).specify(), throwsArgumentError);
    });
  });
}