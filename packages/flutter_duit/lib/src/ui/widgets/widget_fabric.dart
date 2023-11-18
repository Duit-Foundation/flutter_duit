import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/models/el_type.dart';
import 'package:flutter_duit/src/ui/models/element.dart';

import 'index.dart';
import 'text_field.dart';

mixin WidgetFabric {
  Widget getWidgetFromElement(DUITElement model) {
    switch (model.type) {
      case DUITElementType.column:
        {
          final it = model as ColumnUIElement;
          List<Widget> arr = [];

          for (var element in it.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          if (it.uncontrolled) {
            return DUITColumn(
              attributes: it.attributes,
              children: arr,
            );
          } else {
            return DUITControlledColumn(
              controller: it.viewController,
              children: arr,
            );
          }
        }
      case DUITElementType.row:
        {
          final it = model as RowUIElement;
          List<Widget> arr = [];

          for (var element in it.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          if (it.uncontrolled) {
            return DUITRow(
              attributes: it.attributes,
              children: arr,
            );
          } else {
            return DUITControlledRow(
              controller: it.viewController,
              children: arr,
            );
          }
        }
      case DUITElementType.coloredBox:
        {
          final it = model as ColoredBoxUIElement;

          final child = getWidgetFromElement(it.child);

          if (it.uncontrolled) {
            return DUITColoredBox(
              attributes: it.attributes,
              child: child,
            );
          } else {
            return DUITControlledColoredBox(
              controller: it.viewController,
              child: child,
            );
          }
        }
      case DUITElementType.center:
        {
          final it = model as CenterUIElement;

          final child = getWidgetFromElement(it.child);

          if (it.uncontrolled) {
            return DUITCenter(
              attributes: it.attributes,
              child: child,
            );
          } else {
            return DUITControlledCenter(
              controller: it.viewController,
              child: child,
            );
          }
        }
      case DUITElementType.sizedBox:
        {
          final it = model as SizedBoxUIElement;

          final child = getWidgetFromElement(it.child);

          if (it.uncontrolled) {
            return DUITSizedBox(
              attributes: it.attributes,
              child: child,
            );
          } else {
            return DUITControlledSizedBox(
              controller: it.viewController,
              child: child,
            );
          }
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
          return DUITTextField(
            controller: model.viewController!
                as UIElementController<TextFieldAttributes>,
          );
        }
      case DUITElementType.elevatedButton:
        {
          final it = model as ElevatedButtonUIElement;
          final child = getWidgetFromElement(it.child);

          return DUITControlledButton(
            controller: it.viewController!,
            child: child,
          );
        }
      case DUITElementType.empty:
        {
          return const DUITEmptyView();
        }
      default:
        {
          return const SizedBox.shrink();
        }
    }
  }
}
