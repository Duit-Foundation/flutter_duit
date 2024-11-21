import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

import 'element_models.dart';
import 'element_type.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DuitElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DuitElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
base class DuitElement<T> extends TreeElement<T> with WidgetFabric {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttribute<T>? attributes;

  @override
  UIElementController<T>? viewController;

  DuitElement({
    required super.type,
    required super.id,
    super.controlled = false,
    super.tag,
    this.viewController,
    this.attributes,
  });

  static DuitElement fromJson(
    Map<String, dynamic>? json,
    UIDriver driver,
  ) {
    if (json == null) return EmptyUIElement<EmptyAttributes>();

    final String type = json["type"];
    final String id = json["id"];
    final bool controlled = json["controlled"] ?? false;
    final String? tag = json["tag"];

    //Safe cast attributes to Map<String, dynamic>
    final attributesObject = () {
      final attrs = json["attributes"] ?? {};
      return attrs.cast<String, dynamic>();
    }();

    ServerAction? serverAction;

    if (json["action"] != null) {
      serverAction = ServerAction.fromJson(json["action"]);

      if (serverAction.executionType == 2) {
        assert(serverAction.script != null,
            "Script can't be null when executionType == 2");
        final script = serverAction.script!;
        driver.evalScript(script.sourceCode);
      }
    }

    switch (type) {
      case ElementType.row:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes<RowAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        final el = RowUIElement<RowAttributes>(
          type: type,
          id: id,
          children: arr,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );

        return el;
      case ElementType.column:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes<ColumnAttributes>(
          type,
          attributesObject,
          tag,
        );

        return ColumnUIElement<ColumnAttributes>(
          type: type,
          id: id,
          children: arr,
          attributes: attributes,
          controlled: controlled,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
        );
      case ElementType.center:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<CenterAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return CenterUIElement<CenterAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.fittedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<FittedBoxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return FittedBoxUiElement<FittedBoxAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.animatedBuilder:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<AnimatedBuilderAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        final wId = attributes.payload.persistentId ?? id;

        final controller = driver.getController(wId)
            as UIElementController<AnimatedBuilderAttributes>?;

        //Priority use of  persistentId property for animatedBuilder
        return AnimatedBuilderUIElement<AnimatedBuilderAttributes>(
          type: type,
          id: wId,
          child: child,
          attributes: attributes,
          viewController: controller ??
              _createAndAttachController(
                wId,
                controlled,
                attributes,
                serverAction,
                driver,
                type,
                tag,
              ),
          controlled: controlled,
        );
      case ElementType.coloredBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<ColoredBoxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ColoredBoxUIElement<ColoredBoxAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.animatedSize:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<AnimatedSizeAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedSizeUIElement(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.sizedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<SizedBoxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SizedBoxUIElement<SizedBoxAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.richText:
        final attributes = ViewAttribute.createAttributes<RichTextAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RichTextUIElement<RichTextAttributes>(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
        );
      case ElementType.text:
        final attributes = ViewAttribute.createAttributes<TextAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return TextUIElement<TextAttributes>(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
        );
      case ElementType.elevatedButton:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<ElevatedButtonAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ElevatedButtonUIElement<ElevatedButtonAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: true,
        );
      case ElementType.textField:
        final attributes = ViewAttribute.createAttributes<TextFieldAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return TextFieldUIElement<TextFieldAttributes>(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: true,
        );
      case ElementType.stack:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes<StackAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return StackUIElement<StackAttributes>(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
          children: arr,
        );
      case ElementType.wrap:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes<WrapAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return WrapUIElement<WrapAttributes>(
          type: type,
          id: id,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          attributes: attributes,
          controlled: controlled,
          children: arr,
        );
      case ElementType.expanded:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<ExpandedAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ExpandedUiElement<ExpandedAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.padding:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<PaddingAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return PaddingUiElement<PaddingAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.positioned:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<PositionedAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return PositionedUiElement<PositionedAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.decoratedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<DecoratedBoxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return DecoratedBoxUiElement<DecoratedBoxAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );

      case ElementType.checkbox:
        final attributes = ViewAttribute.createAttributes<CheckboxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );
        //controlled by default
        //extends AttendedModel
        return CheckboxUIElement<CheckboxAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: true,
        );
      case ElementType.image:
        final attributes = ViewAttribute.createAttributes<ImageAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );
        return ImageUIElement<ImageAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.switchW:
        final attributes = ViewAttribute.createAttributes<SwitchAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );
        return SwitchUiElement<SwitchAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.radio:
        final attributes = ViewAttribute.createAttributes<RadioAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );
        return RadioUIElement<RadioAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.slider:
        final attributes = ViewAttribute.createAttributes<SliderAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );
        return SliderUIElement<SliderAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlled,
        );
      case ElementType.container:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<ContainerAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ContainerUiElement<ContainerAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.subtree:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<SubtreeAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SubtreeUIElement<SubtreeAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.gestureDetector:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<GestureDetectorAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return GestureDetectorUiElement<GestureDetectorAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.align:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<AlignAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AlignUiElement<AlignAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.transform:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<TransformAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        switch (attributes.payload.type) {
          case "scale":
            final castedAttrs = attributes.cast<ScaleTransform>();
            return TransformUiElement<ScaleTransform>(
              type: type,
              id: id,
              attributes: castedAttrs,
              viewController: _createAndAttachController(
                id,
                controlled,
                castedAttrs,
                serverAction,
                driver,
                type,
                tag,
              ),
              child: child,
              controlled: controlled,
            );
          case "translate":
            final castedAttrs = attributes.cast<TranslateTransform>();
            return TransformUiElement<TranslateTransform>(
              type: type,
              id: id,
              attributes: castedAttrs,
              viewController: _createAndAttachController(
                id,
                controlled,
                castedAttrs,
                serverAction,
                driver,
                type,
                tag,
              ),
              child: child,
              controlled: controlled,
            );
          case "rotate":
            final castedAttrs = attributes.cast<RotateTransform>();
            return TransformUiElement<RotateTransform>(
              type: type,
              id: id,
              attributes: castedAttrs,
              viewController: _createAndAttachController(
                id,
                controlled,
                castedAttrs,
                serverAction,
                driver,
                type,
                tag,
              ),
              child: child,
              controlled: controlled,
            );
        }

        return EmptyUIElement<EmptyAttributes>();
      case ElementType.radioGroupContext:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<RadioGroupContextAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RadioGroupContextUiElement<RadioGroupContextAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.singleChildScrollview:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<SingleChildScrollviewAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SingleChildScrollviewUiElement<SingleChildScrollviewAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.opacity:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<OpacityAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return OpacityUiElement<OpacityAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.ignorePointer:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<IgnorePointerAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return IgnorePointerUiElement<IgnorePointerAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.repaintBoundary:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<RepaintBoundaryAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RepaintBoundaryUIElement<RepaintBoundaryAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.overflowBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<OverflowBoxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return OverflowBoxUIElement<OverflowBoxAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.meta:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<MetaAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return MetaUiElement<MetaAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
          controlled: controlled,
        );
      case ElementType.lifecycleStateListener:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<LifecycleStateListenerAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        //[controlled] - always false
        //[ViewController] necessary and created directly
        return LifecycleStateListenerUiElement<
            LifecycleStateListenerAttributes>(
          type: type,
          id: id,
          attributes: null,
          viewController: ViewController(
            id: id,
            driver: driver,
            action: serverAction,
            attributes: attributes,
            type: type,
            tag: tag,
          ),
          child: child,
          controlled: false,
        );
      case ElementType.listView:
        List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes<ListViewAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ListViewUIElement<ListViewAttributes>(
          type: type,
          id: id,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          children: arr,
          controlled: controlled,
        );
      case ElementType.intrinsicHeight:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes =
            ViewAttribute.createAttributes<IntrinsicHeightAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return IntrinsicHeightUIElement(
          type: type,
          id: id,
          controlled: controlled,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
        );

      case ElementType.rotatedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes<RotatedBoxAttributes>(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RotatedBoxUIElement<RotatedBoxAttributes>(
          type: type,
          id: id,
          controlled: controlled,
          attributes: attributes,
          viewController: _createAndAttachController(
            id,
            controlled,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          child: child,
        );
      case ElementType.empty:
        return EmptyUIElement<EmptyAttributes>();
      case ElementType.component:
        final providedData = json["data"] as Map<String, dynamic>;

        final model = DuitRegistry.getComponentDescription(tag!);
        final dm = DevMetrics();

        if (model != null) {
          dm.add(StartMergeMessage());
          final data = JsonUtils.mergeWithDataSource(
            model,
            providedData,
          );
          dm
            ..add(EndMergeMessage())
            ..add(LogMergeInfo());

          final child = DuitElement.fromJson(data, driver);

          final attributes = ViewAttribute.createAttributes<SubtreeAttributes>(
            type,
            attributesObject,
            tag,
            id: id,
          );

          return ComponentUIElement<SubtreeAttributes>(
            child: child,
            type: type,
            id: id,
            controlled: true,
            attributes: attributes,
            viewController: _createAndAttachController(
              id,
              true,
              attributes,
              null,
              driver,
              type,
              tag,
            ),
          );
        }

        return EmptyUIElement<EmptyAttributes>();
      case ElementType.custom:
        if (tag != null) {
          final customModelFactory = DuitRegistry.getModelFactory(tag);
          if (customModelFactory != null) {
            final attributes = ViewAttribute.createAttributes(
              type,
              attributesObject,
              tag,
              id: id,
            );

            final controller = _createAndAttachController(
              id,
              controlled,
              attributes,
              serverAction,
              driver,
              type,
              tag,
            );

            final children = <DuitElement>{};

            if (json["children"] != null) {
              json["children"].forEach(
                (element) {
                  children.add(
                    DuitElement.fromJson(
                      element,
                      driver,
                    ),
                  );
                },
              );
            }

            if (json["child"] != null) {
              children.add(
                DuitElement.fromJson(
                  json["child"],
                  driver,
                ),
              );
            }

            return customModelFactory(
              id,
              controlled,
              attributes,
              controller,
              children,
            ) as CustomUiElement;
          }
        }
        return EmptyUIElement<EmptyAttributes>();
      default:
        throw ArgumentError(
          "Cant infer element type from json schema: $type with id= $id",
        );
    }
  }

  //</editor-fold>

  //<editor-fold desc="Methods">
  /// Creates and attaches a controller to a specific element in the DUIT element tree.
  ///
  /// The [_createAndAttachController] function is used to create and attach a controller to a specific element in the DUIT element tree.
  ///
  /// Returns the attached controller or null if the element is not controlled.
  static UIElementController<T>? _createAndAttachController<T>(
    String id,
    bool controlled,
    ViewAttribute<T>? attributes,
    ServerAction? action,
    UIDriver driver,
    String type,
    String? tag,
  ) {
    final controller = switch (controlled) {
      false => null,
      true => ViewController<T>(
          id: id,
          driver: driver,
          action: action,
          attributes: attributes,
          type: type,
          tag: tag,
        )
    };

    if (controller != null) {
      driver.attachController(id, controller);
    }

    return controller;
  }

  /// Renders the DUIT element to a Flutter widget.
  ///
  /// Returns the rendered Flutter widget.
  @override
  Widget renderView() {
    return getWidgetFromElement(this);
  }

//</editor-fold>
}
