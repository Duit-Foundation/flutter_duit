import "package:flutter/material.dart";

PreferredSizeWidget? extractPreferredSizeWidget(
  List<Widget?> arr,
  int index,
) {
  final widget = arr.elementAtOrNull(index);
  return widget is PreferredSizeWidget ? widget : null;
}
