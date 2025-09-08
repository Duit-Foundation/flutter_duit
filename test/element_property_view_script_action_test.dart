// ignore_for_file: no_leading_underscores_for_local_identifiers

import "dart:async";

import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_duit/src/ui/element_property_view.dart";
import "package:flutter_test/flutter_test.dart";

// Mock UIDriver для тестирования
class MockUIDriver implements UIDriver {
  final List<String> evaluatedScripts = [];
  bool shouldThrowError = false;

  @override
  String get source => "mock_source";

  @override
  TransportOptions get transportOptions => EmptyTransportOptions();

  @override
  Transport? transport;

  @override
  BuildContext get buildContext => throw UnimplementedError();

  StreamController<ElementTree?> get streamController =>
      throw UnimplementedError();

  StreamController<UIDriverEvent> get eventStreamController =>
      throw UnimplementedError();

  @override
  ScriptRunner? scriptRunner;

  @override
  EventResolver get eventResolver => throw UnimplementedError();

  @override
  ActionExecutor get actionExecutor => throw UnimplementedError();

  @override
  ExternalEventHandler? externalEventHandler;

  @override
  MethodChannel? driverChannel;

  @override
  bool get isModule => false;

  @override
  DebugLogger? get logger => null;

  @override
  void attachController(String id, UIElementController controller) {}

  @override
  void detachController(String id) {}

  @override
  UIElementController? getController(String id) => null;

  @override
  void dispose() {}

  @override
  Map<String, dynamic> preparePayload(
    Iterable<ActionDependency> dependencies,
  ) =>
      {};

  @override
  Future<ServerEvent?> execute(ServerAction action) async {
    if (shouldThrowError) {
      throw Exception("Mock execution error");
    }
    return null;
  }

  @override
  late Stream<UIDriverEvent> eventStream;

  late Stream<ElementTree?> stream;

  @override
  set actionExecutor(ActionExecutor _actionExecutor) {}

  @override
  Widget? build() {
    throw UnimplementedError();
  }

  @override
  set buildContext(BuildContext _buildContext) {}

  @override
  // ignore: avoid_setters_without_getters
  set context(BuildContext value) {}

  @override
  Future<void> evalScript(String source) {
    if (shouldThrowError) {
      throw Exception("Mock eval error");
    }
    evaluatedScripts.add(source);
    return Future.value();
  }

  @override
  set eventResolver(EventResolver _eventResolver) {}

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  set isModule(bool _isModule) {}

  @override
  bool isWidgetReady(String viewTag) {
    throw UnimplementedError();
  }

  @override
  set logger(DebugLogger? _logger) {}

  @override
  void notifyWidgetDisplayStateChanged(String viewTag, int state) {}

  @override
  Future<void> updateAttributes(
    String controllerId,
    Map<String, dynamic> json,
  ) {
    throw UnimplementedError();
  }

  set eventStreamController(
    StreamController<UIDriverEvent> _eventStreamController,
  ) {}

  set streamController(StreamController<ElementTree?> _streamController) {}
}

void main() {
  group("ElementPropertyView ScriptAction handling", () {
    late MockUIDriver mockDriver;

    setUp(() {
      mockDriver = MockUIDriver();
      // Устанавливаем парсер действий для корректной работы DuitDataSource
      ServerAction.setActionParser(const DefaultActionParser());
    });

    group("ScriptAction processing in _processElement", () {
      test("should call evalScript when element has ScriptAction", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type":
              "ElevatedButton", // Тип, который может иметь связанное действие
          "id": "test_element",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": "console.log('Hello from script');",
              "functionName": "main",
              "meta": null,
            },
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts.length, 1);
        expect(
          mockDriver.evaluatedScripts.first,
          "console.log('Hello from script');",
        );
      });

      test("should not call evalScript when element has no action", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
          // Нет action
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts, isEmpty);
      });

      test("should not call evalScript when action is not ScriptAction", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
          "action": {
            "event": "server_request",
            "executionType": 0, // Не ScriptAction
            "url": "/api/test",
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts, isEmpty);
      });

      test(
          "should not call evalScript when element type cannot have related action",
          () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "Text", // Тип, который не может иметь связанное действие
          "id": "test_element",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": "console.log('This should not execute');",
              "functionName": "main",
              "meta": null,
            },
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts, isEmpty);
      });

      test("should call evalScript with correct script source code", () {
        // Arrange
        const expectedScript = "function testScript() { return 'test'; }";
        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": expectedScript,
              "functionName": "testScript",
              "meta": {"description": "Test script"},
            },
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts.length, 1);
        expect(mockDriver.evaluatedScripts.first, expectedScript);
      });

      test("should handle multiple elements with ScriptActions", () {
        // Arrange
        final elementData1 = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element_1",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": "console.log('Script 1');",
              "functionName": "main",
              "meta": null,
            },
          },
        };

        final elementData2 = <String, dynamic>{
          "type": "TextField",
          "id": "test_element_2",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": "console.log('Script 2');",
              "functionName": "main",
              "meta": null,
            },
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData1, mockDriver);
        ElementPropertyView.fromJson(elementData2, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts.length, 2);
        expect(
          mockDriver.evaluatedScripts,
          contains("console.log('Script 1');"),
        );
        expect(
          mockDriver.evaluatedScripts,
          contains("console.log('Script 2');"),
        );
      });

      test("should handle ScriptAction with complex script content", () {
        // Arrange
        const complexScript = '''
          function complexFunction() {
            const data = {
              message: "Hello World",
              timestamp: Date.now()
            };
            
            if (data.message) {
              console.log("Message:", data.message);
              return data;
            }
            
            return null;
          }
          
          complexFunction();
        ''';

        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": complexScript,
              "functionName": "complexFunction",
              "meta": {"version": "1.0", "author": "test"},
            },
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts.length, 1);
        expect(mockDriver.evaluatedScripts.first, complexScript);
      });

      test("should handle empty script source code", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {"sourceCode": "", "functionName": "main", "meta": null},
          },
        };

        // Act
        ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(mockDriver.evaluatedScripts.length, 1);
        expect(mockDriver.evaluatedScripts.first, "");
      });

      test("should call evalScript and propagate exception when driver throws",
          () {
        // Arrange
        mockDriver.shouldThrowError = true;
        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
          "action": {
            "event": "script",
            "executionType": 2,
            "script": {
              "sourceCode": "console.log('This will throw');",
              "functionName": "main",
              "meta": null,
            },
          },
        };

        // Act & Assert - должно выбросить исключение при вызове evalScript
        expect(
          () => ElementPropertyView.fromJson(elementData, mockDriver),
          throwsA(isA<Exception>()),
        );
      });
    });

    group("ElementType.mayHaveRelatedAction validation", () {
      test("ElevatedButton should have mayHaveRelatedAction = true", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "ElevatedButton",
          "id": "test_element",
        };

        // Act
        final element = ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(element.type.mayHaveRelatedAction, true);
      });

      test("TextField should have mayHaveRelatedAction = true", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "TextField",
          "id": "test_element",
        };

        // Act
        final element = ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(element.type.mayHaveRelatedAction, true);
      });

      test("Text should have mayHaveRelatedAction = false", () {
        // Arrange
        final elementData = <String, dynamic>{
          "type": "Text",
          "id": "test_element",
        };

        // Act
        final element = ElementPropertyView.fromJson(elementData, mockDriver);

        // Assert
        expect(element.type.mayHaveRelatedAction, false);
      });
    });
  });
}
