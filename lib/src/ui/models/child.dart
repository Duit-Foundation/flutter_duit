import 'element.dart';

/// Represents a layout that can contain multiple child elements.
///
/// The [MultiChildLayout] interface provides a contract for classes that implement a layout that can contain multiple child elements.
abstract interface class MultiChildLayout {
  /// The list of child elements in the layout.
  abstract List<DUITElement> children;
}

/// Represents a layout that can contain a single child element.
///
/// The [SingleChildLayout] interface provides a contract for classes that implement a layout that can contain a single child element.
abstract interface class SingleChildLayout {
  /// The child element in the layout.
  abstract DUITElement child;
}
