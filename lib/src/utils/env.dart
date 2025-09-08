/// Whether to throw an error when an unspecified widget type is encountered.
///
/// If set to true, an [ArgumentError] will be thrown when an unspecified widget
/// type is encountered.
///
/// If set to false, a const [SizedBox] will be returned instead.
///
/// This is useful for debugging and development purposes.
const throwOnUnspecifiedWidgetType = bool.fromEnvironment(
  "DF_THROW_ON_UNSPECIFIED_WIDGET_TYPE",
  defaultValue: true,
);
