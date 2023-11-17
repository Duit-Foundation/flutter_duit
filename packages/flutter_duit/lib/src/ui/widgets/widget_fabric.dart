import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/ui/models/element.dart';
import 'package:flutter_duit/src/ui/widgets/column.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'index.dart';
import 'text_field.dart';

mixin WidgetFabric {
  Widget getWidgetFromElement(DUITElement model) {
    switch (model.type) {
      case DUITElementType.column:
        {
          final data = model as ColumnUIElement;
          List<Widget> arr = [];

          for (var element in data.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          if (data.uncontrolled) {
            return DUITColumn(
              attributes: data.attributes,
              children: arr,
            );
          } else {
            return DUITControlledColumn(
              controller: data.viewController,
              children: arr,
            );
          }
        }
      case DUITElementType.row:
        {
          final data = model as RowUIElement;
          List<Widget> arr = [];

          for (var element in data.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          if (data.uncontrolled) {
            return DUITRow(
              attributes: data.attributes,
              children: arr,
            );
          } else {
            return DUITControlledRow(
              controller: data.viewController,
              children: arr,
            );
          }
        }
      case DUITElementType.coloredBox:
        {
          final data = model as ColoredBoxUIElement;

          final child = getWidgetFromElement(data.child);
          return ColoredBox(
            color: ColorUtils.tryParseColor(Colors.red),
            child: child,
          );
        }
      case DUITElementType.center:
        {
          final data = model as CenterUIElement;

          final child = getWidgetFromElement(data.child);
          return Center(
            child: child,
          );
        }
      case DUITElementType.sizedBox:
        {
          final data = model as SizedBoxUIElement;

          final child = getWidgetFromElement(data.child);
          return SizedBox(
            child: child,
          );
        }
      case DUITElementType.text:
        {
          final it = model as TextUIElement;

          return model.uncontrolled
              ? DUITText(attributes: it.attributes)
              : DUITControlledText(
                  controller: it.viewController,
                );
        }
      case DUITElementType.textField:
        {
          assert(model.viewController != null);

          return DUITTextField(
            controller: model.viewController!
                as UIElementController<TextFieldAttributes>,
          );
        }
      case DUITElementType.elevatedButton:
        {
          assert(model.viewController != null);

          final data = model as ElevatedButtonUIElement;

          final child = getWidgetFromElement(data.child);

          return DUITButton(
            controller: model.viewController!,
            child: child,
          );
        }
      default:
        {
          return const SizedBox.shrink();
        }
    }
  }
}
