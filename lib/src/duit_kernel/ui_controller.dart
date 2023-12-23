import 'dart:ui';

import 'index.dart';

/// Base class for ViewController objects.
///
/// This class serves as the base class for all ViewController objects in your application.
/// It provides common properties and methods that can be used by subclasses.
abstract interface class UIElementController<T> {
  /// Typed attributes object (view properties).
  ///
  /// The [attributes] property holds the typed attributes object associated with the controller.
  /// It provides access to the view properties and allows manipulation of their values.
  abstract ViewAttributeWrapper<T>? attributes;

  /// Id for current controller, same with [DUITElement] id.
  abstract String id;

  /// Element type.
  ///
  /// The [type] property represents the type of the UI element associated with the controller.
  /// It can be used to identify the type of the element and perform specific operations based on the type.
  abstract String type;

  /// Related action.
  ///
  /// The [action] property represents the related action associated with the controller.
  /// It can be used to perform an action when the UI element is interacted with.
  abstract ServerAction? action;

  /// Reference to the [DuitDriver] instance.
  ///
  /// The [driver] property represents a reference to the [DuitDriver] instance
  /// that is responsible for driving the UI elements.
  abstract UIDriver driver;

  /// Tag for the controller.
  ///
  /// The [tag] property represents a tag associated with the controller.
  /// It can be used to categorize or identify the controller.
  abstract String? tag;

  /// Perform the related action.
  ///
  /// This method is called to perform the related action associated with the controller.
  void performRelatedAction();

  /// Perform the passed action.
  ///
  /// This method is called to perform the passed action.
  void performAction(ServerAction? action);

  /// Update the state.
  ///
  /// This method is called to update the state of the UI element associated with the controller.
  /// It takes a [newState] parameter of type [ViewAttributeWrapper<T>] that represents the new state.
  void updateState(ViewAttributeWrapper<T> newState);

  /// Add a listener to [ChangeNotifier].
  ///
  /// This method is called to add a listener to the controller.
  /// It takes a [listener] parameter of type [VoidCallback] that represents the listener function.
  void addListener(VoidCallback listener);

  /// Dispose the [ChangeNotifier].
  ///
  /// This method is called to dispose the controller and release any resources associated with it.
  void dispose();

  /// RemoveListener the [ChangeNotifier].
  void removeListener(VoidCallback listener);
}
