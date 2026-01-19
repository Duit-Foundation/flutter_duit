export "package:duit_kernel/duit_kernel.dart"
    show
        DuitRegistry,
        ElementTree,
        ElementTreeEntry,
        AnimatedPropertyOwner,
        UIDriver,
        UIElementController,
        DefaultActionParser,
        DefaultEventParser,
        ViewAttribute,
        ServerAction,
        ThemeToken,
        UnknownThemeToken,
        DefaultThemeToken,
        DuitTheme,
        ThemePreprocessor,
        TokenizationCallback,
        FocusCapabilityDelegate,
        ServerActionExecutionCapabilityDelegate,
        UIControllerCapabilityDelegate,
        ViewModelCapabilityDelegate,
        LoggingCapabilityDelegate,
        NativeModuleCapabilityDelegate,
        ScriptingCapabilityDelegate,
        UserDefinedHandlerKind,
        TransportCapabilityDelegate;

// Legacy API exports for backward compatibility
export "package:duit_kernel/duit_kernel.dart"
    show
        // ignore: deprecated_member_use
        ExternalEventHandler,
        // ignore: deprecated_member_use
        DefaultActionExecutor,
        // ignore: deprecated_member_use
        DefaultEventResolver,
        // ignore: deprecated_member_use
        ActionExecutor,
        // ignore: deprecated_member_use
        DefaultLogger,
        // ignore: deprecated_member_use
        DebugLogger,
        // ignore: deprecated_member_use
        ScriptRunner,
        // ignore: deprecated_member_use
        Transport,
        // ignore: deprecated_member_use
        TransportOptions,
        // ignore: deprecated_member_use
        Streamer,
        // ignore: deprecated_member_use
        EventResolver;
