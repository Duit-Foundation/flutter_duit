import 'package:flutter/material.dart';
import 'package:flutter_duit/src/duit_impl/view_context.dart';
import 'package:flutter_duit/src/duit_kernel/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// A widget that hosts a DUIT view.
///
/// The `DuitViewHost` widget is responsible for rendering a DUIT view using the provided `UIDriver`.
/// It receives a `placeholder` widget that is displayed while the DUIT view is loading or if there is no data to render.
/// The `driver` parameter is required and should be an instance of `UIDriver`.
/// The `context` parameter is required and should be the build context of the parent widget.
///
/// Example usage:
///
/// ```dart
/// DuitViewHost(
///   driver: myUIDriver,
///   context: context,
///   placeholder: CircularProgressIndicator(),
/// )
/// ```
class DuitViewHost extends StatefulWidget {
  /// A widget to be displayed while the DUIT view is loading or if there is no data to render.
  final Widget? placeholder;

  /// The UIDriver that handles the DUIT view.
  final UIDriver driver;

  /// The build context of the parent widget.
  final BuildContext context;

  final GestureInterceptor? gestureInterceptor;

  /// Creates a new `DuitViewHost` widget.
  ///
  /// The [driver] parameter is required and should be an instance of `UIDriver`.
  /// The [context] parameter is required and should be the build context of the parent widget.
  /// The [placeholder] parameter is optional and specifies a widget to be displayed while the DUIT view is loading or if there is no data to render.
  const DuitViewHost({
    super.key,
    required this.driver,
    required this.context,
    this.placeholder,
    this.gestureInterceptor,
  });

  @override
  State<DuitViewHost> createState() => _DuitViewHostState();
}

class _DuitViewHostState extends State<DuitViewHost> {
  @override
  void initState() {
    widget.driver.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.driver.stream,
        builder: (context, snapshot) {
          widget.driver.context = context;

          if (snapshot.data != null) {
            return DuitViewContext(
              gestureInterceptor: widget.gestureInterceptor,
              child: snapshot.data!.render(),
            );
          } else {
            return widget.placeholder ?? const SizedBox.shrink();
          }
        });
  }
}
