import 'package:flutter/material.dart';
import 'package:flutter_duit/src/duit_impl/registry.dart';
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

          return it.controlled
              ? DUITControlledColumn(
                  controller: it.viewController,
                  children: arr,
                )
              : DUITColumn(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.row:
        {
          final it = model as RowUIElement;
          List<Widget> arr = [];

          for (var element in it.children) {
            final children = getWidgetFromElement(element);
            arr.add(children);
          }

          return it.controlled
              ? DUITControlledRow(
                  controller: it.viewController,
                  children: arr,
                )
              : DUITRow(
                  attributes: it.attributes,
                  children: arr,
                );
        }
      case DUITElementType.coloredBox:
        {
          final it = model as ColoredBoxUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledColoredBox(
                  controller: it.viewController,
                  child: child,
                )
              : DUITColoredBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.center:
        {
          final it = model as CenterUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledCenter(
                  controller: it.viewController,
                  child: child,
                )
              : DUITCenter(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.sizedBox:
        {
          final it = model as SizedBoxUIElement;

          final child = getWidgetFromElement(it.child);

          return it.controlled
              ? DUITControlledSizedBox(
                  controller: it.viewController,
                  child: child,
                )
              : DUITSizedBox(
                  attributes: it.attributes,
                  child: child,
                );
        }
      case DUITElementType.text:
        {
          final it = model as TextUIElement;

          return it.controlled
              ? DUITControlledText(
                  controller: it.viewController,
                )
              : DUITText(attributes: it.attributes);
        }
      case DUITElementType.textField:
        {
          final it = model as TextFieldUIElement;

          return DUITTextField(
            controller: it.viewController,
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
      case DUITElementType.custom:
        {
          if (model.tag != null) {
            final renderer = DUITRegistry.getRenderer(model.tag!);
            return renderer?.call(model) ?? const DUITEmptyView();
          }

          return const DUITEmptyView();
        }
      default:
        {
          return const SizedBox.shrink();
        }
    }
  }
}
