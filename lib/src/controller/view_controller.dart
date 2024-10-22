import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/foundation.dart';

/// The controller for a UI element.
///
/// This class is responsible for managing the state and behavior of a UI element.
/// It implements the [UIElementController] interface and uses the [ChangeNotifier]
/// mixin to provide change notification to listeners.
final class ViewController<T>
    with ChangeNotifier
    implements UIElementController<T> {
  /// The attributes associated with the UI element.
  ///
  /// This property holds the attributes of the UI element that the `ViewController` controls.
  /// It can be used to access and modify the attributes of the UI element.
  @override
  ViewAttribute<T>? attributes;

  /// The server action associated with the UI element.
  ///
  /// This property holds the server action that is triggered when the UI element is interacted with.
  @override
  ServerAction? action;

  /// The driver that controls the UI element.
  ///
  /// This property holds the driver object that is responsible for interacting with the UI element.
  @override
  UIDriver driver;

  /// The unique identifier of the UI element.
  ///
  /// This property holds the unique identifier that is assigned to the UI element.
  @override
  String id;

  /// The type of the UI element.
  ///
  /// This property holds the type of the UI element that the `ViewController` controls.
  @override
  String type;

  /// The tag associated with the UI element.
  ///
  /// This property holds an optional tag that can be used to further categorize the UI element.
  @override
  String? tag;

  /// Creates a new instance of the `ViewController` class.
  ///
  /// The [id] parameter specifies the unique identifier of the UI element.
  /// The [driver] parameter specifies the driver that controls the UI element.
  /// The [type] parameter specifies the type of the UI element.
  /// The [action] parameter specifies the server action associated with the UI element.
  /// The [attributes] parameter specifies the initial attributes of the UI element.
  /// The [tag] parameter specifies the tag associated with the UI element.
  ViewController({
    required this.id,
    required this.driver,
    required this.type,
    this.action,
    this.attributes,
    this.tag,
  });

  /// Updates the state of the UI element with new attributes.
  ///
  /// The [newAttrs] parameter specifies the new attributes to be applied to the UI element.
  @override
  void updateState(ViewAttribute newState) {
    attributes = newState.cast<T>();
    notifyListeners();
  }

  /// Performs the related action of the UI element.
  ///
  /// This method is called when the UI element is interacted with and the associated
  /// server action is not null. It executes the server action using the driver.
  @override
  void performRelatedAction() {
    if (action != null) {
      driver.execute(action!);
    }
  }

  @override
  Future<void> performRelatedActionAsync() async {
    try {
      if (action != null) {
        await driver.execute(action!);
      }
    } catch (e) {
      //TODO: logging
      rethrow;
    }
  }

  @override
  void performAction(ServerAction? action) {
    if (action != null) {
      driver.execute(action);
    }
  }

  @override
  Future<void> performActionAsync(ServerAction? action) async {
    try {
      if (action != null) {
        await driver.execute(action);
      }
    } catch (e) {
      //TODO: logging
      rethrow;
    }
  }

  @override
  void dispose() {
    driver.detachController(this.id);
    super.dispose();
  }
}
