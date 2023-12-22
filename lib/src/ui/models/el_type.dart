enum DUITElementType {
  ///Keys: Column
  column,

  ///Keys: Row
  row,

  ///Keys: Text
  text,

  ///Keys: ElevatedButton
  elevatedButton,

  ///Keys: TextField
  textField,

  ///Keys: Center
  center,

  ///Keys: ColoredBox
  coloredBox,

  ///Keys: SizedBox
  sizedBox,

  ///Keys: Empty
  empty,

  ///Keys: Custom
  custom,

  ///Keys: Stack
  stack,

  ///Keys: Expanded
  expanded,

  ///Keys: Padding
  padding,

  ///Keys: Positioned
  positioned,

  ///Keys: DecoratedBox
  decoratedBox,

  ///Keys: Checkbox
  checkbox,

  ///Keys: Container
  container,

  ///Keys: Image
  image,

  ///Keys: GestureDetector
  gestureDetector,
}

/// Infers the type of a value based on its runtime type.
///
/// The [inferTypeFromValue] function is used to infer the type of a value based on its runtime type.
/// It takes in the [value] parameter, which represents the value to infer the type from.
///
/// Returns the inferred type of the value.
DUITElementType inferTypeFromValue(dynamic type) {
  if (type == null) return DUITElementType.empty;

  if (type is String) {
    switch (type) {
      case "GestureDetector":
        return DUITElementType.gestureDetector;
      case "Image":
        return DUITElementType.image;
      case "Column":
        return DUITElementType.column;
      case "Row":
        return DUITElementType.row;
      case "Text":
        return DUITElementType.text;
      case "TextField":
        return DUITElementType.textField;
      case "ElevatedButton":
        return DUITElementType.elevatedButton;
      case "SizedBox":
        return DUITElementType.sizedBox;
      case "ColoredBox":
        return DUITElementType.coloredBox;
      case "Center":
        return DUITElementType.center;
      case "Empty":
        return DUITElementType.empty;
      case "Stack":
        return DUITElementType.stack;
      case "Expanded":
        return DUITElementType.expanded;
      case "Padding":
        return DUITElementType.padding;
      case "Positioned":
        return DUITElementType.positioned;
      case "DecoratedBox":
        return DUITElementType.decoratedBox;
      case "CheckBox":
        return DUITElementType.checkbox;
      case "Container":
        return DUITElementType.container;
      case "Custom":
        return DUITElementType.custom;
      default:
        return DUITElementType.empty;
    }
  }

  return DUITElementType.empty;
}
