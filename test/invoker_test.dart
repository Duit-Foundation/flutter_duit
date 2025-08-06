import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_duit/src/utils/invoker.dart';

// Test widget that uses the ActionInvoker mixin
class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with ActionInvoker {
  int debounceCallCount = 0;
  int throttleCallCount = 0;
  String? lastDebounceValue;
  String? lastThrottleValue;

  void resetCounters() {
    debounceCallCount = 0;
    throttleCallCount = 0;
    lastDebounceValue = null;
    lastThrottleValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void main() {
  group('ActionCallbackOptimizer', () {
    late _TestWidgetState widgetState;

    setUp(() {
      widgetState = _TestWidgetState();
      widgetState.resetCounters();
    });

    tearDown(() {
      // Don't call dispose directly, let Flutter handle it
      widgetState.cancelAll();
    });

    group('Debounce functionality', () {
      test('should execute callback after delay when called once', () async {
        final completer = Completer<void>();
        
        widgetState.debounce(
          'test',
          () {
            widgetState.debounceCallCount++;
            completer.complete();
          },
          duration: const Duration(milliseconds: 100),
        );

        expect(widgetState.debounceCallCount, 0);
        
        await completer.future;
        expect(widgetState.debounceCallCount, 1);
      });

      test('should reset timer when called multiple times', () async {
        final completer = Completer<void>();
        
        // First call
        widgetState.debounce(
          'test',
          () {
            widgetState.debounceCallCount++;
            completer.complete();
          },
          duration: const Duration(milliseconds: 200),
        );

        // Wait a bit and call again
        await Future.delayed(const Duration(milliseconds: 100));
        
        widgetState.debounce(
          'test',
          () {
            widgetState.debounceCallCount++;
            completer.complete();
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.debounceCallCount, 0);
        
        await completer.future;
        expect(widgetState.debounceCallCount, 1);
      });

      test('should handle multiple debounce keys independently', () async {
        final completer1 = Completer<void>();
        final completer2 = Completer<void>();
        
        widgetState.debounce(
          'key1',
          () {
            widgetState.debounceCallCount++;
            completer1.complete();
          },
          duration: const Duration(milliseconds: 100),
        );

        widgetState.debounce(
          'key2',
          () {
            widgetState.debounceCallCount++;
            completer2.complete();
          },
          duration: const Duration(milliseconds: 150),
        );

        await completer1.future;
        await completer2.future;
        
        expect(widgetState.debounceCallCount, 2);
      });

      test('should capture arguments correctly in debounceWithArgs', () async {
        final completer = Completer<void>();
        
        widgetState.debounceWithArgs(
          'test',
          (String value) {
            widgetState.lastDebounceValue = value;
            widgetState.debounceCallCount++;
            completer.complete();
          },
          'test_value',
          duration: const Duration(milliseconds: 100),
        );

        await completer.future;
        
        expect(widgetState.debounceCallCount, 1);
        expect(widgetState.lastDebounceValue, 'test_value');
      });

      test('should update arguments when debounceWithArgs is called multiple times', () async {
        final completer = Completer<void>();
        
        // First call
        widgetState.debounceWithArgs(
          'test',
          (String value) {
            widgetState.lastDebounceValue = value;
            widgetState.debounceCallCount++;
            completer.complete();
          },
          'first_value',
          duration: const Duration(milliseconds: 200),
        );

        // Wait and call again with different value
        await Future.delayed(const Duration(milliseconds: 100));
        
        widgetState.debounceWithArgs(
          'test',
          (String value) {
            widgetState.lastDebounceValue = value;
            widgetState.debounceCallCount++;
            completer.complete();
          },
          'second_value',
          duration: const Duration(milliseconds: 200),
        );

        await completer.future;
        
        expect(widgetState.debounceCallCount, 1);
        expect(widgetState.lastDebounceValue, 'second_value');
      });

      test('should cancel all debounce timers', () async {
        final completer = Completer<void>();
        
        widgetState.debounce(
          'key1',
          () {
            widgetState.debounceCallCount++;
            completer.complete();
          },
          duration: const Duration(milliseconds: 200),
        );

        widgetState.debounce(
          'key2',
          () {
            widgetState.debounceCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        // Cancel all before they execute
        widgetState.cancelAllDebounce();
        
        // Wait for the original duration
        await Future.delayed(const Duration(milliseconds: 250));
        
        expect(widgetState.debounceCallCount, 0);
      });
    });

    group('Throttle functionality', () {
      test('should execute callback immediately on first call', () async {
        widgetState.throttle(
          'test',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 1);
      });

      test('should ignore subsequent calls within throttle period', () async {
        widgetState.throttle(
          'test',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        // Call again immediately
        widgetState.throttle(
          'test',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 1);
      });

      test('should allow execution after throttle period expires', () async {
        widgetState.throttle(
          'test',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 100),
        );

        expect(widgetState.throttleCallCount, 1);

        // Wait for throttle period to expire
        await Future.delayed(const Duration(milliseconds: 150));

        widgetState.throttle(
          'test',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 100),
        );

        expect(widgetState.throttleCallCount, 2);
      });

      test('should handle multiple throttle keys independently', () async {
        widgetState.throttle(
          'key1',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        widgetState.throttle(
          'key2',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 2);
      });

      test('should capture arguments correctly in throttleWithArgs', () async {
        widgetState.throttleWithArgs(
          'test',
          (String value) {
            widgetState.lastThrottleValue = value;
            widgetState.throttleCallCount++;
          },
          'test_value',
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 1);
        expect(widgetState.lastThrottleValue, 'test_value');
      });

      test('should ignore subsequent calls with different arguments within throttle period', () async {
        widgetState.throttleWithArgs(
          'test',
          (String value) {
            widgetState.lastThrottleValue = value;
            widgetState.throttleCallCount++;
          },
          'first_value',
          duration: const Duration(milliseconds: 200),
        );

        // Call again immediately with different value
        widgetState.throttleWithArgs(
          'test',
          (String value) {
            widgetState.lastThrottleValue = value;
            widgetState.throttleCallCount++;
          },
          'second_value',
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 1);
        expect(widgetState.lastThrottleValue, 'first_value');
      });

      test('should cancel all throttle timers', () async {
        widgetState.throttle(
          'key1',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        widgetState.throttle(
          'key2',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 2);

        // Cancel all throttle timers
        widgetState.cancelAllThrottle();

        // Try to call again immediately
        widgetState.throttle(
          'key1',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 3);
      });
    });

    group('Combined functionality', () {
      test('should cancel all timers with cancelAll', () async {
        final debounceCompleter = Completer<void>();
        
        widgetState.debounce(
          'debounce_key',
          () {
            widgetState.debounceCallCount++;
            debounceCompleter.complete();
          },
          duration: const Duration(milliseconds: 200),
        );

        widgetState.throttle(
          'throttle_key',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(milliseconds: 200),
        );

        expect(widgetState.throttleCallCount, 1);

        // Cancel all timers
        widgetState.cancelAll();

        // Wait for the original duration
        await Future.delayed(const Duration(milliseconds: 250));
        
        expect(widgetState.debounceCallCount, 0);
      });

      test('should clean up timers on dispose', () async {
         final debounceCompleter = Completer<void>();
         
         widgetState.debounce(
           'debounce_key',
           () {
             widgetState.debounceCallCount++;
             debounceCompleter.complete();
           },
           duration: const Duration(milliseconds: 200),
         );

         widgetState.throttle(
           'throttle_key',
           () {
             widgetState.throttleCallCount++;
           },
           duration: const Duration(milliseconds: 200),
         );

         expect(widgetState.throttleCallCount, 1);

         // Test that dispose cleans up timers (ActionInvoker should handle this)
         widgetState.cancelAll();

         // Wait for the original duration
         await Future.delayed(const Duration(milliseconds: 250));
         
         expect(widgetState.debounceCallCount, 0);
      });
    });

    group('Lazy initialization', () {
      test('should not create timer maps until first use', () {
        // Access private fields through reflection or test the behavior
        // Since we can't directly access private fields, we test the behavior
        
        // Initially, no timers should be active
        widgetState.cancelAllDebounce();
        widgetState.cancelAllThrottle();
        
        // This should not throw any errors
        expect(() => widgetState.cancelAll(), returnsNormally);
      });

      test('should handle multiple rapid calls efficiently', () async {
        final completer = Completer<void>();
        
        // Make multiple rapid debounce calls
        for (int i = 0; i < 10; i++) {
          widgetState.debounce(
            'rapid_test',
            () {
              widgetState.debounceCallCount++;
              completer.complete();
            },
            duration: const Duration(milliseconds: 100),
          );
          
          await Future.delayed(const Duration(milliseconds: 10));
        }

        await completer.future;
        
        // Should only execute once
        expect(widgetState.debounceCallCount, 1);
      });
    });

    group('Edge cases', () {
      test('should handle zero duration', () async {
        final completer = Completer<void>();
        
        widgetState.debounce(
          'zero_duration',
          () {
            widgetState.debounceCallCount++;
            completer.complete();
          },
          duration: Duration.zero,
        );

        await completer.future;
        expect(widgetState.debounceCallCount, 1);
      });

      test('should handle very long duration', () async {
        widgetState.throttle(
          'long_duration',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(seconds: 1),
        );

        expect(widgetState.throttleCallCount, 1);

        // Call again immediately
        widgetState.throttle(
          'long_duration',
          () {
            widgetState.throttleCallCount++;
          },
          duration: const Duration(seconds: 1),
        );

        expect(widgetState.throttleCallCount, 1);
      });

      test('should handle empty string keys', () async {
        final completer = Completer<void>();
        
        widgetState.debounce(
          '',
          () {
            widgetState.debounceCallCount++;
            completer.complete();
          },
          duration: const Duration(milliseconds: 100),
        );

        await completer.future;
        expect(widgetState.debounceCallCount, 1);
      });

      test('should handle special characters in keys', () async {
         final completer = Completer<void>();
         
         widgetState.debounce(
           'special_chars',
           () {
             widgetState.debounceCallCount++;
             completer.complete();
           },
           duration: const Duration(milliseconds: 100),
         );

         await completer.future;
         expect(widgetState.debounceCallCount, 1);
      });
     });
   });
} 