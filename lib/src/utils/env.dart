/// Whether to throw an error when an unspecified widget type is encountered.
///
/// If set to true, an [ArgumentError] will be thrown when an unspecified widget
/// type is encountered.
///
/// If set to false, a const [SizedBox] will be returned instead.
///
/// This is useful for debugging and development purposes.
const throwOnUnspecifiedWidgetType = bool.fromEnvironment(
  "duit:throw-on-unspecified-widget-type",
  defaultValue: true,
);

const allowFocusNodeOverride = bool.fromEnvironment(
  "duit:allow-focus-node-override",
  defaultValue: false,
);

const enableSharedDrivers = bool.fromEnvironment(
  "duit:enable-shared-drivers",
  defaultValue: false,
);
