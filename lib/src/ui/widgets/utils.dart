import "package:flutter/material.dart";

PreferredSizeWidget? extractPreferredSizeWidget(
  List<Widget?> arr,
  int index,
) {
  final widget = arr.elementAtOrNull(index);
  return widget is PreferredSizeWidget ? widget : null;
}

const kTitleIndex = 0,
    kLeadingIndex = 1,
    kFlexibleSpaceIndex = 2,
    kBottomIndex = 3,
    kActionsStartIndex = 4;
