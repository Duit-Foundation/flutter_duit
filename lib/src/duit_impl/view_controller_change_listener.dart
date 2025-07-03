import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';

/// A mixin that listens for changes in a UI element controller and updates the state accordingly.
///
/// The `ViewControllerChangeListener` mixin should be used with a `StatefulWidget` and its associated `State` class.
/// It provides a mechanism to attach the `State` to a `UIElementController` and listen for updates in the controller's attributes.
/// When a controller update occurs, the `ViewControllerChangeListener` triggers a state update, allowing the UI to reflect the new attribute values.
///
/// Usage:
/// ```
/// class MyWidget extends StatefulWidget {
///   final UIElementController? controller;
///   @override
///   _MyWidgetState createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> with ViewControllerChangeListener<MyWidget, MyAttributes> {
///   @override
///   void initState() {
///     attachStateToController(widget.controller);
///     super.initState();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     // Use the attributes to build the UI
///     return Container(
///       color: attributes?.backgroundColor ?? Colors.white,
///       child: Text(attributes?.text ?? 'Hello'),
///     );
///   }
/// }
/// ```
///
/// The `ViewControllerChangeListener` mixin requires two type parameters:
/// - `T`: The type of the `StatefulWidget` that is using the mixin.
/// - `AttrType`: The type of the attributes associated with the `UIElementController`.
///
/// The following methods are available in the `ViewControllerChangeListener` mixin:
/// - `attachStateToController(UIElementController? controller)`: Attaches the state to a `UIElementController`. This method should be called in the `initState` method of the state.
///
/// The following properties are available in the `ViewControllerChangeListener` mixin:
/// - `attributes`: The current attributes of the `UIElementController`. These attributes can be used to build the UI.
mixin ViewControllerChangeListener<T extends StatefulWidget> on State<T> {
  late DuitDataSource attributes;
  late UIElementController _controller;

  /// Attaches the state to a [UIElementController].
  ///
  /// This method should be called in the `initState` method of the state.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void initState() {
  ///   attachStateToController(widget.controller);
  ///   super.initState();
  /// }
  /// ```
  void attachStateToController(UIElementController controller) {
    _controller = controller;
    attributes = _controller.attributes.payload;
  }

  void _listener() {
    final newState = _controller.attributes.payload;

    setState(() {
      attributes = newState;
    });
  }

  /// Updates the state of the `UIElementController` manually.
  void updateStateManually(Map<String, dynamic> newState) {
    _controller.updateState(newState);
  }

  void _listenControllerUpdateStateEvent() {
    _controller.addListener(_listener);
  }

  @override
  void didChangeDependencies() {
    _listenControllerUpdateStateEvent();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_listener)
      ..detach();
    super.dispose();
  }
}
