abstract class AttendedModel<T> {
  T value;

  AttendedModel({required this.value});

  void update(T value) {
    this.value = value;
  }

  T collect() {
    return value;
  }
}
