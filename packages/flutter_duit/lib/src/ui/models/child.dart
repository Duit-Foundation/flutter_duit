import 'element.dart';

abstract interface class MultiChildLayout {
  abstract List<DUITElement> children;
}

abstract interface class SingleChildLayout {
  abstract DUITElement child;
}