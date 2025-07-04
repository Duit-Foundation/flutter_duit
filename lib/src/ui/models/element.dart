import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_duit/src/controller/index.dart';
import 'package:flutter_duit/src/ui/models/element_models.dart';
import 'package:flutter_duit/src/ui/models/element_type.dart';
import 'package:flutter_duit/src/ui/widgets/index.dart';
import 'package:flutter_duit/src/utils/index.dart';

/// Represents a DUIT element in the DUIT element tree.
///
/// The [DuitElement] class represents an individual DUIT element in the DUIT element tree.
/// It holds information about the element's type, properties, and child elements.
/// The [DuitElement] class provides methods for rendering the element to a Flutter widget and handling interactions.
base class DuitElement extends ElementTreeEntry with WidgetFabric {
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
    if (json == null) return EmptyUIElement();

    final String type = json["type"];
    final String id = json["id"];
    final bool controlled = json["controlled"] ?? false;
    final String? tag = json["tag"];

    //Safe cast attributes to Map<String, dynamic>
    final attributesObject =
        Map<String, dynamic>.from(json["attributes"] ?? {});

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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        final el = RowUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ColumnUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return CenterUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return FittedBoxUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        final wId = attributes.payload.tryGetString("persistentId") ?? id;

        final controller = driver.getController(wId);

        //Priority use of  persistentId property for animatedBuilder
        return AnimatedBuilderUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ColoredBoxUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedSizeUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SizedBoxUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return RichTextUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return TextUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ElevatedButtonUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return TextFieldUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return StackUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return WrapUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ExpandedUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return PaddingUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return PositionedUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return DecoratedBoxUiElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );
        //controlled by default
        //extends AttendedModel
        return CheckboxUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ImageUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );
        return SwitchUiElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return RadioUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliderUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ContainerUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SubtreeUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return GestureDetectorUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AlignUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        switch (attributes.payload.tryGetString("type")) {
          case "scale":
            return TransformUiElement(
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
            return TransformUiElement(
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
            return TransformUiElement(
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
          case "flip":
            return TransformUiElement(
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

        return EmptyUIElement();
      case ElementType.radioGroupContext:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return RadioGroupContextUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SingleChildScrollviewUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return OpacityUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return IgnorePointerUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return RepaintBoundaryUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return OverflowBoxUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return MetaUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        //[controlled] - always false
        //[ViewController] necessary and created directly
        return LifecycleStateListenerUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        bool isControlledByDefault = false;

        if (attributes.payload.getInt(key: "type") != 0) {
          isControlledByDefault = true;
        } else {
          isControlledByDefault = controlled;
        }

        final controlState = isControlledByDefault || controlled;

        return ListViewUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        bool isControlledByDefault = false;

        final controlState = isControlledByDefault || controlled;

        return GridViewUIElement(
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
      case ElementType.sliverGrid:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        bool isControlledByDefault = false;

        final controlState = isControlledByDefault || controlled;

        return SliverGridUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return IntrinsicWidthUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return RotatedBoxUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ConstrainedBoxUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return BackdropFilterUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedOpacityUIElement(
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
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return RemoteUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SafeAreaUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return CardUIElement(
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
        return EmptyUIElement();
      case ElementType.component:
        final providedData = Map<String, dynamic>.from(json["data"]);

        final model = DuitRegistry.getComponentDescription(tag!);

        if (model != null) {
          final data = JsonUtils.mergeWithDataSource(
            model,
            providedData,
          );

          final child = DuitElement.fromJson(data, driver);

          final attributes = ViewAttribute.from(
            type,
            attributesObject,
            id,
            tag: tag,
          );

          return ComponentUIElement(
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

        return EmptyUIElement();
      case ElementType.appBar:
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AppBarUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return ScaffoldUiElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return InkWellUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return CarouselViewUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedContainerUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedAlignUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedRotationUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedPaddingUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedPositionedUIElement(
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

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedScaleUIElement(
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

      case ElementType.absorbPointer:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AbsorbPointerUIElement(
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
          controlled: controlled,
          child: child,
          attributes: attributes,
        );
      case ElementType.offstage:
        final child = DuitElement.fromJson(json["child"], driver);
        final attributes =
            ViewAttribute.from(type, attributesObject, id, tag: tag);

        return OffstageUIElement(
          type: type,
          id: id,
          controlled: controlled,
          viewController: _createAndAttachController(
              id, controlled, attributes, serverAction, driver, type, tag),
          attributes: attributes,
          child: child,
        );
      case ElementType.animatedCrossFade:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          assert(
            (json["children"] as List).length == 2,
            "Expected 2 children in AnimatedCrossFade",
          );
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedCrossFadeUIElement(
          type: type,
          id: id,
          attributes: _attachAttributes(true, attributes),
          viewController: _createAndAttachController(
            id,
            true,
            attributes,
            serverAction,
            driver,
            type,
            tag,
          ),
          children: arr,
          controlled: true,
        );
      case ElementType.animatedSlide:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedSlideUIElement(
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
      case ElementType.physicalModel:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return PhysicalModelUIElement(
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
      case ElementType.animatedPhysicalModel:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return AnimatedPhysicalModelUIElement(
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
      case ElementType.sliverPadding:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverPaddingUIElement(
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
      case ElementType.customScrollView:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(
              DuitElement.fromJson(
                element,
                driver,
              ),
            );
          });
        }

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return CustomScrollViewUIElement(
          id: id,
          type: type,
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
      case ElementType.sliverFillRemaining:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverFillRemainingUIElement(
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
      case ElementType.sliverToBoxAdapter:
        final child = DuitElement.fromJson(json["child"], driver);

        return SliverToBoxAdapterUIElement(
          type: type,
          id: id,
          child: child,
        );
      case ElementType.sliverFillViewport:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(
              DuitElement.fromJson(
                element,
                driver,
              ),
            );
          });
        }

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverFillViewportUIElement(
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
      case ElementType.sliverOpacity:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverOpacityUIElement(
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
      case ElementType.sliverAnimatedOpacity:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverAnimatedOpacityUIElement(
          type: type,
          id: id,
          attributes: _attachAttributes(true, attributes),
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
      case ElementType.sliverVisibility:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverVisibilityUIElement(
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
      case ElementType.sliverOffstage:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverOffstageUIElement(
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
      case ElementType.sliverSafeArea:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverSafeAreaUIElement(
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
      case ElementType.custom:
        if (tag != null) {
          final customModelFactory = DuitRegistry.getModelFactory(tag);
          if (customModelFactory != null) {
            final attributes = ViewAttribute.from(
              type,
              attributesObject,
              id,
              tag: tag,
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
        return EmptyUIElement();
      case ElementType.sliverList:
        final List<DuitElement> arr = [];

        if (json["children"] != null) {
          json["children"].forEach((element) {
            arr.add(DuitElement.fromJson(element, driver));
          });
        }

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        bool isControlledByDefault = false;

        if (attributes.payload.getInt(key: "type") != 0) {
          isControlledByDefault = true;
        }

        final controlState = isControlledByDefault || controlled;

        return SliverListUIElement(
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
      case ElementType.sliverIgnorePointer:
        final child = DuitElement.fromJson(json["child"], driver);

        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: id,
        );

        return SliverIgnorePointerUIElement(
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
      case ElementType.flexibleSpaceBar:
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return FlexibleSpaceBarUiElement(
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
          attributes: _attachAttributes(true, attributes),
        );
      case ElementType.sliverAppBar:
        final attributes = ViewAttribute.from(
          type,
          attributesObject,
          id,
          tag: tag,
        );

        return SliverAppBarUiElement(
          type: type,
          id: id,
          attributes: _attachAttributes(true, attributes),
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
  static UIElementController? _createAndAttachController(
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
      true => ViewController(
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

  static ViewAttribute? _attachAttributes(
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
