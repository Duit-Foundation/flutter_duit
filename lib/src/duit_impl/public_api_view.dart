import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/capabilities/index.dart";
import "package:flutter_duit/src/duit_impl/driver_compat.dart";
import "package:meta/meta.dart";

/// Public API for working with the Duit driver.
///
/// [XDriver] is an extension type wrapper over [UIDriver] that provides
/// a convenient interface for initializing and managing a Duit application
/// in various operating modes.
///
/// Supported modes:
/// - **Remote**: connection to a remote server through a transport layer
/// - **Static**: working with predefined JSON content without server requests
/// - **Native Module**: integration Duit as a module into an existing native application
///
/// The extension implements [FocusCapabilityDelegate] to support
/// UI focus management.
///
/// Usage example:
/// ```dart
/// // Creating a remote driver
/// final driver = XDriver.remote(
///   transportManager: MyTransportManager(),
///   initialRequestPayload: {'key': 'value'},
/// );
/// ```
extension type XDriver._(UIDriver _driver) implements FocusCapabilityDelegate {
  /// Creates a driver for working with a remote Duit server.
  ///
  /// This constructor is used when the UI should be dynamically loaded
  /// from the server through an established transport protocol.
  ///
  /// **Required parameters:**
  /// - [transportManager] - transport layer manager for server communication.
  ///   Responsible for sending requests and receiving UI updates.
  ///
  /// **Optional parameters:**
  /// - [initialRequestPayload] - additional data for the first server request.
  ///   May contain initialization parameters, authorization tokens, etc.
  /// - [nativeModuleManager] - delegate for managing native modules.
  ///   Allows calling platform-specific code.
  /// - [scriptingManager] - delegate for executing client-side scripts.
  ///   Extends application logic without modifying the UI.
  /// - [loggingManager] - delegate for customizing logging.
  ///   Allows intercepting and handling log events.
  /// - [focusManager] - delegate for managing UI element focus.
  ///   Controls keyboard navigation through elements.
  /// - [actionManager] - delegate for executing server actions.
  ///   Handles server-specific commands.
  /// - [controllerManager] - delegate for managing UI controllers.
  ///   Manages widget state (e.g., TextField).
  /// - [viewManager] - delegate for managing view models.
  ///   Manages view state and data.
  ///
  /// Example:
  /// ```dart
  /// final driver = XDriver.remote(
  ///   transportManager: HttpTransportManager(
  ///     baseUrl: 'https://api.example.com',
  ///   ),
  ///   initialRequestPayload: {
  ///     'userId': '12345',
  ///     'theme': 'dark',
  ///   },
  ///   loggingManager: CustomLogger(),
  /// );
  /// ```
  factory XDriver.remote({
    required TransportCapabilityDelegate transportManager,
    Map<String, dynamic>? initialRequestPayload,
    NativeModuleCapabilityDelegate? nativeModuleManager,
    ScriptingCapabilityDelegate? scriptingManager,
    LoggingCapabilityDelegate? loggingManager,
    FocusCapabilityDelegate? focusManager,
    ServerActionExecutionCapabilityDelegate? actionManager,
    UIControllerCapabilityDelegate? controllerManager,
    ViewModelCapabilityDelegate? viewManager,
  }) =>
      XDriver._(
        DuitDriverCompat(
          isModule: false,
          initialRequestPayload: initialRequestPayload,
          transportManager: transportManager,
          nativeModuleManager: nativeModuleManager,
          scriptingManager: scriptingManager,
          loggingManager: loggingManager,
          focusManager: focusManager,
          actionManager: actionManager,
          controllerManager: controllerManager,
          viewManager: viewManager,
        ),
      );

  /// Creates a driver for working with static JSON content.
  ///
  /// This constructor is used when the UI is predefined and does not require
  /// server connection. Ideal for offline mode, testing,
  /// or applications with fixed UI.
  ///
  /// **Required parameters:**
  /// - [content] - JSON structure with UI description according to Duit specification.
  ///   Cannot be empty, otherwise [StateError] will be thrown.
  ///
  /// **Optional parameters:**
  /// - [initialRequestPayload] - initial data for initialization.
  ///   Can be used by scripts or actions in the UI.
  /// - [nativeModuleManager] - delegate for managing native modules.
  ///   Allows calling platform-specific code.
  /// - [transportManager] - optional transport manager.
  ///   If not specified, [StubTransportManager] stub is used.
  ///   Can be useful for hybrid scenarios.
  /// - [scriptingManager] - delegate for executing scripts.
  ///   Allows adding dynamic logic to static UI.
  /// - [loggingManager] - delegate for customizing logging.
  /// - [focusManager] - delegate for managing UI element focus.
  /// - [actionManager] - delegate for executing actions.
  /// - [controllerManager] - delegate for managing UI controllers.
  /// - [viewManager] - delegate for managing view models.
  ///
  /// **Throws:**
  /// - [StateError] if [content] is empty.
  ///
  /// Example:
  /// ```dart
  /// final uiContent = {
  ///   'type': 'Column',
  ///   'children': [
  ///     {'type': 'Text', 'data': 'Hello World'},
  ///   ],
  /// };
  ///
  /// final driver = XDriver.static(
  ///   uiContent,
  /// );
  /// ```
  factory XDriver.static(
    Map<String, dynamic> content, {
    Map<String, dynamic>? initialRequestPayload,
    NativeModuleCapabilityDelegate? nativeModuleManager,
    TransportCapabilityDelegate? transportManager,
    ScriptingCapabilityDelegate? scriptingManager,
    LoggingCapabilityDelegate? loggingManager,
    FocusCapabilityDelegate? focusManager,
    ServerActionExecutionCapabilityDelegate? actionManager,
    UIControllerCapabilityDelegate? controllerManager,
    ViewModelCapabilityDelegate? viewManager,
  }) {
    if (content.isEmpty) {
      // throw StateError(
      //   "[content] property must be valid Duit json struct",
      // );
    }
    return XDriver._(
      DuitDriverCompat(
        content: content,
        initialRequestPayload: initialRequestPayload,
        isModule: false,
        transportManager: transportManager ?? StubTransportManager(),
        nativeModuleManager: nativeModuleManager,
        scriptingManager: scriptingManager,
        loggingManager: loggingManager,
        focusManager: focusManager,
        actionManager: actionManager,
        controllerManager: controllerManager,
        viewManager: viewManager,
      ),
    );
  }

  /// Creates a driver for native module mode.
  ///
  /// This constructor is used when Duit is integrated as a module
  /// into an existing Flutter application. The driver works with a native
  /// transport layer for interaction with the host application.
  ///
  /// In this mode, [NativeTransportManager] is used by default,
  /// which provides communication between Duit UI and native code
  /// of the application through platform channels or other mechanisms.
  ///
  /// **Optional parameters:**
  /// - [initialRequestPayload] - initial data from the host application.
  ///   May contain context, configuration parameters, etc.
  /// - [nativeModuleManager] - delegate for managing native modules.
  ///   Critical for interaction with the host application.
  /// - [transportManager] - custom transport manager.
  ///   If not specified, [NativeTransportManager] is used by default.
  /// - [scriptingManager] - delegate for executing scripts.
  ///   Allows extending module logic.
  /// - [loggingManager] - delegate for customizing logging.
  ///   Can integrate with the host application's logging system.
  /// - [focusManager] - delegate for managing UI element focus.
  /// - [actionManager] - delegate for executing actions.
  ///   Can handle specific commands from the host application.
  /// - [controllerManager] - delegate for managing UI controllers.
  /// - [viewManager] - delegate for managing view models.
  ///
  /// Example:
  /// ```dart
  /// final driver = XDriver.nativeModule(
  ///   nativeModuleManager: MyNativeModuleManager(),
  ///   initialRequestPayload: {
  ///     'hostVersion': '1.0.0',
  ///     'features': ['analytics', 'payments'],
  ///   },
  /// );
  /// ```
  factory XDriver.nativeModule({
    Map<String, dynamic>? initialRequestPayload,
    NativeModuleCapabilityDelegate? nativeModuleManager,
    TransportCapabilityDelegate? transportManager,
    ScriptingCapabilityDelegate? scriptingManager,
    LoggingCapabilityDelegate? loggingManager,
    FocusCapabilityDelegate? focusManager,
    ServerActionExecutionCapabilityDelegate? actionManager,
    UIControllerCapabilityDelegate? controllerManager,
    ViewModelCapabilityDelegate? viewManager,
  }) =>
      XDriver._(
        DuitDriverCompat(
          isModule: true,
          initialRequestPayload: initialRequestPayload,
          transportManager: transportManager ?? NativeTransportManager(),
          nativeModuleManager: nativeModuleManager,
          scriptingManager: scriptingManager,
          loggingManager: loggingManager,
          focusManager: focusManager,
          actionManager: actionManager,
          controllerManager: controllerManager,
          viewManager: viewManager,
        ),
      );

  /// Creates an [XDriver] from an existing [UIDriver] instance.
  ///
  /// This constructor is intended for internal library use only.
  /// It allows wrapping an existing [UIDriver]
  /// in the public [XDriver] API.
  ///
  /// **Parameters:**
  /// - [driver] - existing [UIDriver] instance to wrap.
  ///
  /// **Warning:** Marked as [@internal] and should not be used
  /// in user code. Intended only for internal
  /// library implementation.
  @internal
  factory XDriver.from(UIDriver driver) => XDriver._(
        driver,
      );

  /// Registers an external event handler.
  ///
  /// Allows attaching custom event handling logic
  /// defined on the server side or in the UI description. External handlers
  /// are called when the UI generates events not handled by standard
  /// Duit logic.
  ///
  /// **Parameters:**
  /// - [type] - event handler type identifying the event category.
  ///   Determines which events will be routed to this handler.
  /// - [handle] - event handler function.
  ///   Accepts event data and executes necessary logic.
  ///
  /// Handlers are called synchronously when a corresponding
  /// event occurs in the UI. One type can have only one handler; re-registration
  /// replaces the previous handler.
  ///
  /// Example:
  /// ```dart
  /// driver.attachExternalHandler(
  ///   UserDefinedHandlerKind.custom('onButtonClick'),
  ///   (eventData) {
  ///     print('Button clicked: ${eventData['id']}');
  ///     // Handle click
  ///   },
  /// );
  /// ```
  @preferInline
  void attachExternalHandler(
    UserDefinedHandlerKind type,
    UserDefinedEventHandler handle,
  ) =>
      _driver.attachExternalHandler(type, handle);

  /// Adds an external event stream for driver processing.
  ///
  /// Allows integrating external event sources (e.g., WebSocket,
  /// Firebase, native platform events) into the Duit event handling system.
  /// Events from the stream will be automatically processed and can trigger
  /// UI updates or execution of registered handlers.
  ///
  /// **Parameters:**
  /// - [stream] - event stream in JSON format (Map<String, dynamic>).
  ///   Each event should contain necessary fields for identification
  ///   and processing (e.g., 'type', 'action', 'payload').
  ///
  /// The driver automatically subscribes to the stream when added and
  /// unsubscribes when [dispose] is called. Multiple streams can be added,
  /// and they will all be processed in parallel.
  ///
  /// **Important:** Ensure that the event structure matches the expected
  /// Duit format or is handled by registered external handlers.
  ///
  /// Example:
  /// ```dart
  /// final websocketStream = WebSocketChannel.connect(
  ///   Uri.parse('ws://example.com'),
  /// ).stream.map((data) => jsonDecode(data));
  ///
  /// driver.addExternalEventStream(websocketStream);
  /// ```
  @preferInline
  void addExternalEventStream(
    Stream<Map<String, dynamic>> stream,
  ) =>
      _driver.addExternalEventStream(
        stream,
      );

  /// Initializes the driver and prepares it for work.
  ///
  /// This method must be called before using the driver.
  /// Performs the following operations:
  /// - Transport layer initialization
  /// - Loading initial UI content (for remote mode)
  /// - Setting up all registered delegates and managers
  /// - Preparing the event system
  ///
  /// For remote drivers, the first request to the server is made
  /// using [initialRequestPayload] (if specified).
  ///
  /// **Returns:** [Future<void>] that completes when the driver
  /// is fully ready to work.
  ///
  /// **Throws:** May throw exceptions related to network errors,
  /// incorrect data format, or initialization problems.
  ///
  /// **Important:** Call this method only once. Repeated calls
  /// may lead to unpredictable behavior.
  ///
  /// Example:
  /// ```dart
  /// final driver = XDriver.remote(
  ///   transportManager: myTransport,
  /// );
  ///
  /// try {
  ///   await driver.init();
  ///   print('Driver is ready');
  /// } catch (e) {
  ///   print('Initialization error: $e');
  /// }
  /// ```
  @preferInline
  Future<void> init() async => _driver.init();

  /// Releases resources used by the driver.
  ///
  /// This method should be called when the driver is no longer needed.
  /// Performs the following cleanup operations:
  /// - Closing transport connections
  /// - Canceling subscriptions to external event streams
  /// - Clearing internal caches and state
  /// - Releasing resources of all registered managers
  /// - Removing all event handlers
  ///
  /// **Important:** After calling [dispose], the driver becomes unusable.
  /// Attempting to call driver methods after dispose
  /// may lead to errors.
  ///
  /// It is recommended to call this method in the dispose method of the widget
  /// using the driver to avoid memory leaks.
  ///
  /// Example:
  /// ```dart
  /// class MyWidget extends StatefulWidget {
  ///   @override
  ///   State<MyWidget> createState() => _MyWidgetState();
  /// }
  ///
  /// class _MyWidgetState extends State<MyWidget> {
  ///   late final XDriver driver;
  ///
  ///   @override
  ///   void initState() {
  ///     super.initState();
  ///     driver = XDriver.remote(...);
  ///     driver.init();
  ///   }
  ///
  ///   @override
  ///   void dispose() {
  ///     driver.dispose();
  ///     super.dispose();
  ///   }
  ///
  ///   @override
  ///   Widget build(BuildContext context) => ...;
  /// }
  /// ```
  @preferInline
  void dispose() => _driver.dispose();

  /// Provides access to the internal [UIDriver] instance.
  ///
  /// This getter is intended for internal library use only.
  /// It allows getting direct access to the wrapped
  /// [UIDriver] for cases when interaction between
  /// internal system components is necessary.
  ///
  /// **Returns:** Internal [UIDriver] instance.
  ///
  /// **Warning:** Marked as [@internal] and should not be used
  /// in user code. Direct use of [UIDriver] may
  /// break encapsulation and lead to unpredictable behavior.
  /// Use public [XDriver] methods for all operations.
  @internal
  @preferInline
  UIDriver get asInternalDriver => _driver;
}
