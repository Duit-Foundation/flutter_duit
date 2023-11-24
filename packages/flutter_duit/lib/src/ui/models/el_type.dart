enum DUITElementType {
  ///Keys: Column, 1
  column,

  ///Keys: Row, 2
  row,

  ///Keys: Text, 3
  text,

  ///Keys: ElevatedButton, 4
  elevatedButton,

  ///Keys: TextField, 6
  textField,

  ///Keys: Center, 7
  center,

  ///Keys: ColoredBox, 8
  coloredBox,

  ///Keys: SizedBox, 9
  sizedBox,

  ///Keys: Empty, 0
  empty,

  ///Keys: Custom, 10
  custom,
}

DUITElementType convert(dynamic type) {
  if (type == null) return DUITElementType.empty;

  if (type is String) {
    switch (type) {
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
      default:
        return DUITElementType.custom;
    }
  }

  if (type is int) {
    switch (type) {
      case 1:
        return DUITElementType.column;
      case 2:
        return DUITElementType.row;
      case 3:
        return DUITElementType.text;
      case 6:
        return DUITElementType.textField;
      case 4:
        return DUITElementType.elevatedButton;
      case 9:
        return DUITElementType.sizedBox;
      case 5:
        return DUITElementType.coloredBox;
      case 7:
        return DUITElementType.center;
      case 0:
        return DUITElementType.empty;
      default:
        return DUITElementType.custom;
    }
  }

  return DUITElementType.empty;
}
