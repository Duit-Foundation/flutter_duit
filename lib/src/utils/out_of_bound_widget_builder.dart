import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A mixin for creating widgets outside the standard widget tree building process.
///
/// Used when widgets are passed through attributes rather than through standard
/// `child` or `children` properties. This allows creating widgets from JSON
/// descriptions located in the parent widget's attributes.
///
/// Example usage:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> with OutOfBoundWidgetBuilder {
///   @override
///   Widget build(BuildContext context) {
///     return AppBar(
///       title: buildOutOfBoundWidget(attributes.title, driver),
///       leading: buildOutOfBoundWidget(attributes.leading, driver),
///     );
///   }
/// }
/// ```
mixin OutOfBoundWidgetBuilder<T extends StatefulWidget> on State<T> {
  /// Creates a widget from JSON description outside the main widget tree.
  ///
  /// [data] - JSON description of the widget
  /// [driver] - driver for widget creation
  ///
  /// Returns a widget of type [U] or null if [data] is null.
  /// Type [U] must be a subtype of [Widget].
  U? buildOutOfBoundWidget<U extends Widget>(
    Map<String, dynamic>? data,
    UIDriver driver,
    Widget Function(Widget child)? wrapper,
  ) {
    if (data == null) {
      return null;
    }

    final model = parseLayoutSync(
      data,
      driver,
    );

    if (wrapper != null) {
      return wrapper(model.render()) as U;
    }

    return model.render() as U;
  }
}
