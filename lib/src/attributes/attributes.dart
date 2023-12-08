/// DUITAttributes is an abstract interface that defines the contract for attribute classes in the DUIT library.
///
/// It provides a `copyWith` method that allows creating a copy of an attribute object with updated values.
abstract class DUITAttributes<T> {
  /// Creates a copy of an attribute object with updated values.
  T copyWith(T other);
}