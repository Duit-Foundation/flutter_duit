import 'dart:async';

/// A mixin that provides debounce and throttle functionality for optimizing callback execution.
///
/// This mixin helps control the frequency of callback executions by providing two main optimization strategies:
///
/// **Debounce**: Delays the execution of a function until after a specified duration has passed
/// since the last time it was called. Useful for search inputs, window resize handlers, etc.
///
/// **Throttle**: Ensures a function is called at most once in a specified time period.
/// Useful for scroll events, button clicks, etc.
///
/// ## Usage
///
/// ```dart
/// class SearchWidget extends StatefulWidget {
///   const SearchWidget({super.key});
///
///   @override
///   State<SearchWidget> createState() => _SearchWidgetState();
/// }
///
/// class _SearchWidgetState extends State<SearchWidget> with ActionInvoker {
///   final TextEditingController _searchController = TextEditingController();
///   final ScrollController _scrollController = ScrollController();
///
///   String _searchResults = '';
///   double _scrollPosition = 0.0;
///
///   @override
///   void initState() {
///     super.initState();
///     _searchController.addListener(_handleSearchInput);
///     _scrollController.addListener(_handleScroll);
///   }
///
///   void _handleSearchInput() {
///     // Debounce search to avoid excessive API calls
///     debounceWithArgs(
///       'search',
///       (String query) => _performSearch(query),
///       _searchController.text,
///       duration: const Duration(milliseconds: 500),
///     );
///   }
///
///   void _handleScroll() {
///     // Throttle scroll events to improve performance
///     throttleWithArgs(
///       'scroll',
///       (double position) => _updateScrollPosition(position),
///       _scrollController.position.pixels,
///       duration: const Duration(milliseconds: 100),
///     );
///   }
///
///   void _performSearch(String query) async {
///     if (query.isEmpty) {
///       setState(() => _searchResults = '');
///       return;
///     }
///
///     // Simulate API call
///     await Future.delayed(const Duration(milliseconds: 200));
///     setState(() => _searchResults = 'Results for: $query');
///   }
///
///   void _updateScrollPosition(double position) {
///     setState(() => _scrollPosition = position);
///   }
///
///   @override
///   void dispose() {
///     _searchController.dispose();
///     _scrollController.dispose();
///     // Clean up all timers when widget is disposed
///     cancelAll();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       children: [
///         TextField(
///           controller: _searchController,
///           decoration: const InputDecoration(
///             labelText: 'Search',
///             hintText: 'Type to search...',
///           ),
///         ),
///         const SizedBox(height: 16),
///         Text(_searchResults),
///         const SizedBox(height: 16),
///         Expanded(
///           child: ListView.builder(
///             controller: _scrollController,
///             itemCount: 100,
///             itemBuilder: (context, index) => ListTile(
///               title: Text('Item $index'),
///             ),
///           ),
///         ),
///         Text('Scroll position: ${_scrollPosition.toStringAsFixed(1)}'),
///       ],
///     );
///   }
/// }
/// ```
///
/// ## Key Features
///
/// - **Lazy initialization**: Timers are only created when needed
/// - **Memory management**: Automatic cleanup with `cancelAll()` method
/// - **Type safety**: Generic support for callback arguments
/// - **Flexible keys**: Use string keys to manage multiple timers
/// - **Status tracking**: Check active timers and their states
/// - **Performance optimization**: Reduces unnecessary function calls
///
/// ## When to Use
///
/// **Debounce** is best for:
/// - Search input fields
/// - Window resize events
/// - Form validation
/// - API calls that should wait for user to finish typing
/// - Auto-save functionality
/// - Real-time filtering
///
/// **Throttle** is best for:
/// - Scroll events
/// - Button click handlers
/// - Mouse move events
/// - Touch events
/// - Any event that should fire at most once per time period
/// - Rate limiting API calls
///
/// ## Best Practices
///
/// - Always call `cancelAll()` in the `dispose()` method to prevent memory leaks
/// - Use descriptive keys for your timers to make debugging easier
/// - Choose appropriate durations based on your use case:
///   - Debounce: 300-500ms for search, 100-200ms for validation
///   - Throttle: 100-200ms for scroll, 50-100ms for mouse events
/// - Consider the user experience when setting durations
mixin ActionInvoker {
  /// Map to store debounce timers - initialized lazily
  ///
  /// This map is only created when the first debounce timer is needed,
  /// helping to minimize memory usage for widgets that don't use debounce functionality.
  Map<String, Timer>? _debounceTimers;

  /// Map to store throttle timers - initialized lazily
  ///
  /// This map is only created when the first throttle timer is needed,
  /// helping to minimize memory usage for widgets that don't use throttle functionality.
  Map<String, Timer>? _throttleTimers;

  /// Gets the debounce timers map, initializing it if necessary
  ///
  /// This getter ensures the debounce timers map is created only when needed,
  /// implementing lazy initialization pattern.
  Map<String, Timer> get _debounceTimersMap =>
      _debounceTimers ??= <String, Timer>{};

  /// Gets the throttle timers map, initializing it if necessary
  ///
  /// This getter ensures the throttle timers map is created only when needed,
  /// implementing lazy initialization pattern.
  Map<String, Timer> get _throttleTimersMap =>
      _throttleTimers ??= <String, Timer>{};

  // ===== DEBOUNCE METHODS =====

  /// Creates a debounced version of the given function.
  ///
  /// A debounced function will only execute after [duration] has passed
  /// since the last time it was called. If called again before the duration
  /// expires, the timer is reset and the countdown starts over.
  ///
  /// This is useful for scenarios where you want to wait for the user to
  /// finish their input before executing an action, such as search queries
  /// or form validation.
  ///
  /// ## Example
  /// ```dart
  /// // Debounce search input
  /// debounce(
  ///   'search',
  ///   () => _performSearch(),
  ///   duration: Duration(milliseconds: 500),
  /// );
  /// ```
  ///
  /// [key] - Unique identifier for this debounce instance. Must be unique
  ///         across all debounce timers in this widget.
  /// [callback] - Function to execute after debounce delay.
  /// [duration] - Delay before executing the function after the last call.
  void debounce(
    String key,
    void Function() callback, {
    required Duration duration,
  }) {
    // Cancel existing timer if any
    _debounceTimersMap[key]?.cancel();

    // Set new timer
    _debounceTimersMap[key] = Timer(duration, () {
      callback();
      _debounceTimersMap.remove(key);
    });
  }

  /// Creates a debounced version of the given function with parameters.
  ///
  /// A debounced function will only execute after [duration] has passed
  /// since the last time it was called. If called again before the duration
  /// expires, the timer is reset and the countdown starts over.
  ///
  /// The [arguments] are captured at the time of the call and will be passed
  /// to the callback when it executes. This is useful when you need to pass
  /// dynamic values to the debounced function.
  ///
  /// ## Example
  /// ```dart
  /// // Debounce search with query parameter
  /// debounceWithArgs(
  ///   'search',
  ///   (String query) => _performSearch(query),
  ///   searchController.text,
  ///   duration: Duration(milliseconds: 300),
  /// );
  /// ```
  ///
  /// [key] - Unique identifier for this debounce instance. Must be unique
  ///         across all debounce timers in this widget.
  /// [callback] - Function to execute after debounce delay.
  /// [arguments] - Arguments to pass to the callback function. These are
  ///               captured at call time and passed to the callback when executed.
  /// [duration] - Delay before executing the function after the last call.
  void debounceWithArgs<R>(
    String key,
    void Function(R arguments) callback,
    R arguments, {
    required Duration duration,
  }) {
    // Cancel existing timer if any
    _debounceTimersMap[key]?.cancel();

    // Capture arguments for the timer
    final capturedArguments = arguments;

    // Set new timer
    _debounceTimersMap[key] = Timer(duration, () {
      callback(capturedArguments);
      _debounceTimersMap.remove(key);
    });
  }

  /// Cancels all active debounce timers.
  ///
  /// This method cancels all currently active debounce timers and clears
  /// the debounce timers map. This is useful when you want to stop all
  /// pending debounced operations.
  ///
  /// ## Example
  /// ```dart
  /// // Cancel all debounce timers
  /// cancelAllDebounce();
  /// ```
  void cancelAllDebounce() {
    if (_debounceTimers != null) {
      for (final timer in _debounceTimers!.values) {
        timer.cancel();
      }
      _debounceTimers!.clear();
    }
  }

  // ===== THROTTLE METHODS =====

  /// Creates a throttled version of the given function.
  ///
  /// A throttled function will only execute at most once per [duration].
  /// If called multiple times within the duration, only the first call will execute.
  /// Subsequent calls are ignored until the duration expires.
  ///
  /// This is useful for scenarios where you want to limit the frequency of
  /// function calls, such as scroll events or button clicks.
  ///
  /// ## Example
  /// ```dart
  /// // Throttle scroll events
  /// throttle(
  ///   'scroll',
  ///   () => _updateScrollPosition(),
  ///   duration: Duration(milliseconds: 100),
  /// );
  /// ```
  ///
  /// [key] - Unique identifier for this throttle instance. Must be unique
  ///         across all throttle timers in this widget.
  /// [callback] - Function to execute immediately if not throttled.
  /// [duration] - Minimum time interval between executions.
  void throttle(
    String key,
    void Function() callback, {
    required Duration duration,
  }) {
    if (_throttleTimersMap.containsKey(key)) {
      return; // Already throttled, ignore this call
    }

    // Execute the callback immediately
    callback();

    // Set timer to allow next execution after duration
    _throttleTimersMap[key] = Timer(duration, () {
      _throttleTimersMap.remove(key);
    });
  }

  /// Creates a throttled version of the given function with parameters.
  ///
  /// A throttled function will only execute at most once per [duration].
  /// If called multiple times within the duration, only the first call will execute.
  /// Subsequent calls are ignored until the duration expires.
  ///
  /// The [arguments] are captured at the time of the call and will be passed
  /// to the callback when it executes. This is useful when you need to pass
  /// dynamic values to the throttled function.
  ///
  /// ## Example
  /// ```dart
  /// // Throttle button click with data
  /// throttleWithArgs(
  ///   'button_click',
  ///   (String buttonId) => _handleButtonClick(buttonId),
  ///   'submit_button',
  ///   duration: Duration(milliseconds: 200),
  /// );
  /// ```
  ///
  /// [key] - Unique identifier for this throttle instance. Must be unique
  ///         across all throttle timers in this widget.
  /// [callback] - Function to execute immediately if not throttled.
  /// [arguments] - Arguments to pass to the callback function. These are
  ///               captured at call time and passed to the callback when executed.
  /// [duration] - Minimum time interval between executions.
  void throttleWithArgs<R>(
    String key,
    void Function(R arguments) callback,
    R arguments, {
    required Duration duration,
  }) {
    if (_throttleTimersMap.containsKey(key)) {
      return; // Already throttled, ignore this call
    }

    // Execute the callback immediately
    callback(arguments);

    // Set timer to allow next execution after duration
    _throttleTimersMap[key] = Timer(duration, () {
      _throttleTimersMap.remove(key);
    });
  }

  /// Cancels all active throttle timers.
  ///
  /// This method cancels all currently active throttle timers and clears
  /// the throttle timers map. This is useful when you want to stop all
  /// pending throttled operations.
  ///
  /// ## Example
  /// ```dart
  /// // Cancel all throttle timers
  /// cancelAllThrottle();
  /// ```
  void cancelAllThrottle() {
    if (_throttleTimers != null) {
      for (final timer in _throttleTimers!.values) {
        timer.cancel();
      }
      _throttleTimers!.clear();
    }
  }

  // ===== COMBINED METHODS =====

  /// Cancels all active timers (both debounce and throttle).
  ///
  /// This method cancels all currently active debounce and throttle timers,
  /// clearing both timer maps. This is the most comprehensive way to stop
  /// all pending operations.
  ///
  /// ## Example
  /// ```dart
  /// // Cancel all timers
  /// cancelAll();
  /// ```
  void cancelAll() {
    cancelAllDebounce();
    cancelAllThrottle();
  }
}
