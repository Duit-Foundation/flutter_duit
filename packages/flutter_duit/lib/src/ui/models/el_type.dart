enum DUITElementType {
  ///Keys: Column, 1
  column,

  ///Keys: Row, 2
  row,

  ///Keys: Text, 3
  text,

  ///Keys: ElevatedButton, 4
  elevatedButton,

  ///Keys: TextField, 5
  textField,

  ///Keys: Center, 5
  center,

  ///Keys: ColoredBox, 5
  coloredBox,

  ///Keys: SizedBox, 5
  sizedBox,

  ///Keys: Empty, 0
  empty,
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
      case "Empty":
        return DUITElementType.column;
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
      case 4:
        return DUITElementType.textField;
      case 5:
        return DUITElementType.elevatedButton;
      case 0:
        return DUITElementType.column;
    }
  }

  return DUITElementType.empty;
}
