import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/attributes/index.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/models/element_models.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
import 'package:flutter_duit/src/ui/models/type_def.dart';
// import 'package:flutter_duit/src/ui/models/type_def.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';
// import 'package:flutter_duit/src/utils/index.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DuitElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DuitElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
base class DuitElement<T> extends ElementTreeEntry with WidgetFabric {
  //<editor-fold desc="Properties and ctor">
  @override
  ViewAttribute? attributes;

  @override
  UIElementController? viewController;

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
    final Map<String, dynamic> attributesObject = json["attributes"] != null
        ? Map<String, dynamic>.from(json["attributes"])
        : {};

    ServerAction? serverAction;

    if (json["action"] != null) {
      serverAction = ServerAction.parse(json["action"]);

      if (serverAction is ScriptAction) {
        final script = serverAction.script;
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        final el = RowUIElement<RowAttributes>(
          type: type,
          id: id,
          children: arr,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ColumnUIElement<ColumnAttributes>(
          type: type,
          id: id,
          children: arr,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return CenterUIElement<CenterAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return FittedBoxUiElement<FittedBoxAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        final wId = attributes.payload["persistentId"] ?? id;

        final controller = driver.getController(wId);

        //Priority use of  persistentId property for animatedBuilder
        return AnimatedBuilderUIElement<AnimatedBuilderAttributes>(
          type: type,
          id: wId,
          child: child,
          attributes: null,
          viewController: controller ??
              _createAndAttachController(
                wId,
                true,
                attributes,
                serverAction,
                driver,
                type,
                tag,
              ),
          controlled: true,
        );
      case ElementType.coloredBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ColoredBoxUIElement<ColoredBoxAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedSizeModel(
          type: type,
          id: id,
          child: child,
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
      case ElementType.sizedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SizedBoxUIElement<SizedBoxAttributes>(
          type: type,
          id: id,
          child: child,
          attributes: _attachAttributes(controlled, attributes),
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
        final attributes = ViewAttribute.createAttributes(
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
          attributes: _attachAttributes(controlled, attributes),
          controlled: controlled,
        );
      case ElementType.text:
        final attributes = ViewAttribute.createAttributes(
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
          attributes: _attachAttributes(controlled, attributes),
          controlled: controlled,
        );
      case ElementType.elevatedButton:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ElevatedButtonUIElement<ElevatedButtonAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
        final attributes = ViewAttribute.createAttributes(
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

        final attributes = ViewAttribute.createAttributes(
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
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
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
          attributes: _attachAttributes(controlled, attributes),
          controlled: controlled,
          children: arr,
        );
      case ElementType.expanded:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ExpandedUiElement<ExpandedAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return PaddingUiElement<PaddingAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return PositionedUiElement<PositionedAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return DecoratedBoxUiElement<DecoratedBoxAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
        final attributes = ViewAttribute.createAttributes(
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
          attributes: null,
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
        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ImageUIElement<ImageAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );
        return SwitchUiElement<SwitchAttributes>(
          type: type,
          id: id,
          attributes: null,
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
      case ElementType.radio:
        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );
        return RadioUIElement<RadioAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SliderUIElement<SliderAttributes>(
          type: type,
          id: id,
          attributes: null,
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
      case ElementType.container:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ContainerUiElement<ContainerAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SubtreeUIElement<SubtreeAttributes>(
          type: type,
          id: id,
          attributes: null,
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
      case ElementType.gestureDetector:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return GestureDetectorUiElement<GestureDetectorAttributes>(
          type: type,
          id: id,
          attributes: null,
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
      case ElementType.align:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AlignUiElement<AlignAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        switch (attributes.payload["type"]) {
          case "scale":
            return TransformUiElement<ScaleTransform>(
              type: type,
              id: id,
              attributes: _attachAttributes(controlled, attributes),
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
          case "translate":
            return TransformUiElement<TranslateTransform>(
              type: type,
              id: id,
              attributes: _attachAttributes(controlled, attributes),
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
          case "rotate":
            return TransformUiElement<RotateTransform>(
              type: type,
              id: id,
              attributes: _attachAttributes(controlled, attributes),
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
        }

        return EmptyUIElement<EmptyAttributes>();
      case ElementType.radioGroupContext:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RadioGroupContextUiElement<RadioGroupContextAttributes>(
          type: type,
          id: id,
          attributes: null,
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
      case ElementType.singleChildScrollview:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SingleChildScrollviewUiElement<SingleChildScrollviewAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return OpacityUiElement<OpacityAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return IgnorePointerUiElement<IgnorePointerAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RepaintBoundaryUIElement<RepaintBoundaryAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return OverflowBoxUIElement<OverflowBoxAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return MetaUiElement<MetaAttributes>(
          type: type,
          id: id,
          attributes: null,
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
      case ElementType.lifecycleStateListener:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
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
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        bool isControlledByDefault = true;

        if (attributes.payload["type"] != 0) {
          isControlledByDefault = true;
        }

        final controlState = isControlledByDefault || controlled;

        return ListViewUIElement<ListViewAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlState, attributes),
          viewController: _createAndAttachController(
            id,
            controlState,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          children: arr,
          controlled: controlState,
        );
      case ElementType.gridView:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        bool isControlledByDefault = false;

        if (GridConstructor.fromValue(attributes.payload["constructor"]) ==
            GridConstructor.builder) {
          isControlledByDefault = true;
        }

        final controlState = isControlledByDefault || controlled;

        return GridViewModel(
          type: type,
          id: id,
          attributes: _attachAttributes(controlState, attributes),
          viewController: _createAndAttachController(
            id,
            controlState,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          controlled: controlState,
          children: arr,
        );
      case ElementType.intrinsicHeight:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return IntrinsicHeightUIElement(
          type: type,
          id: id,
          controlled: controlled,
          attributes: _attachAttributes(controlled, attributes),
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

      case ElementType.intrinsicWidth:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return IntrinsicWidthUiElement<IntrinsicWidthAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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

      case ElementType.rotatedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RotatedBoxUIElement<RotatedBoxAttributes>(
          type: type,
          id: id,
          controlled: controlled,
          attributes: _attachAttributes(controlled, attributes),
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
      case ElementType.constrainedBox:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ConstrainedBoxUIElement<ConstrainedBoxAttributes>(
          type: type,
          id: id,
          controlled: controlled,
          attributes: _attachAttributes(controlled, attributes),
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
      case ElementType.backdropFilter:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return BackdropFilterModel(
          type: type,
          id: id,
          controlled: controlled,
          attributes: _attachAttributes(controlled, attributes),
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
      case ElementType.animatedOpacity:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedOpacityModel(
          type: type,
          id: id,
          controlled: true,
          attributes: null,
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
        );
      case ElementType.remoteSubtree:
        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return RemoteWidgetModel(
          type: type,
          id: id,
          controlled: true,
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
        );
      case ElementType.safeArea:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return SafeAreaUiElement<SafeAreaAttributes>(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
      case ElementType.card:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return CardModel(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
      case ElementType.empty:
        return EmptyUIElement<EmptyAttributes>();
      case ElementType.component:
        final providedData = json["data"] as Map<String, dynamic>;

        final model = DuitRegistry.getComponentDescription(tag!);

        if (model != null) {
          final data = JsonUtils.mergeWithDataSource(
            model,
            providedData,
          );

          final child = DuitElement.fromJson(data, driver);

          final attributes = ViewAttribute.createAttributes(
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
            attributes: null,
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
      case ElementType.appBar:
        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AppBarModel(
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
          controlled: true,
        );
      case ElementType.scaffold:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return ScaffoldModel(
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
          controlled: true,
          child: child,
        );
      case ElementType.inkWell:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return InkWellModel(
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
          child: child,
          controlled: true,
        );
      case ElementType.carouselView:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return CarouselViewModel(
          type: type,
          id: id,
          attributes: _attachAttributes(controlled, attributes),
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
      case ElementType.animatedContainer:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedContainerModel(
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          id: id,
          controlled: true,
          type: type,
          child: child,
        );
      case ElementType.animatedAlign:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedAlignModel(
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          id: id,
          controlled: true,
          type: type,
          child: child,
        );
      case ElementType.animatedRotation:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedRotationModel(
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          id: id,
          controlled: true,
          type: type,
          child: child,
        );
      case ElementType.animatedPadding:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedPaddingModel(
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          id: id,
          controlled: true,
          type: type,
          child: child,
        );
      case ElementType.animatedPositioned:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedPositionedModel(
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          id: id,
          controlled: true,
          type: type,
          child: child,
        );
      case ElementType.animatedScale:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.createAttributes(
          type,
          attributesObject,
          tag,
          id: id,
        );

        return AnimatedScaleModel(
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          id: id,
          controlled: true,
          type: type,
          child: child,
        );
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

            final children = <DuitElement>[];

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
  static UIElementController? _createAndAttachController<T>(
    String id,
    bool controlled,
    ViewAttribute attributes,
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

  static ViewAttribute? _attachAttributes<T>(
    bool controlled,
    ViewAttribute attributes,
  ) {
    if (!controlled) {
      return attributes;
    }

    return null;
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
