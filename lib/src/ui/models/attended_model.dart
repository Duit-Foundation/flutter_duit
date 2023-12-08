/// Represents a model that can be attended and updated.
///
/// The [AttendedModel] class provides a generic implementation of a model that can be attended to and updated.
/// It holds a [value] of generic type [T] and provides methods to update the value and retrieve the current value.
abstract class AttendedModel<T> {
  T value;

  AttendedModel({required this.value});

  /// Updates the value of the model with the specified [value].
  ///
  /// The [value] parameter is required and represents the new value to be assigned to the model.
  void update(T value) {
    this.value = value;
  }

  /// Retrieves the current value of the model.
  ///
  /// Returns the current value of the model.
  T collect() {
    return value;
  }
}
