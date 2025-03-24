/// Represents a widget that is passed through attributes rather than child/children properties.
///
/// This type is used to define widgets that are created outside the standard widget tree building process.
/// The Map contains a JSON description of the widget with its type, id, attributes and other properties.
typedef NonChildWidget = Map<String, dynamic>;
