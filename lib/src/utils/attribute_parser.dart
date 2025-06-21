import "package:duit_kernel/duit_kernel.dart";
import "package:flutter_duit/src/attributes/index.dart";
import "package:flutter_duit/src/ui/models/element_type.dart";
import "package:flutter_duit/src/utils/index.dart";

/// The `AttributeParser` class is responsible for parsing and mapping attributes for different DUIT elements.
///
/// This class provides static methods for parsing custom widget attributes and creating `ViewAttributeWrapper` instances.
///
/// Usage:
/// ```dart
/// final attributes = AttributeParser.parse(type, json, tag);
/// ```
///
/// To parse custom widget attributes, you can use the `_parseCustomWidgetAttributes` method.
/// This method takes a JSON object and a tag as parameters and returns the parsed attributes.
/// ```dart
/// final customAttributes = AttributeParser._parseCustomWidgetAttributes(json, tag);
/// ```
final class DefaultAttributeParser implements AttributeParserBase {
  const DefaultAttributeParser();

  /// Parses custom widget attributes based on the specified JSON object and tag.
  ///
  /// This method retrieves the attributes mapper for the given tag from the `DUITRegistry`.
  /// If an attributes mapper is found, it is invoked with the tag and JSON object to get the parsed attributes.
  /// If no attributes mapper is found, it returns an instance of `EmptyAttributes`.
  ///
  /// Parameters:
  /// - [json]: The JSON object containing the attributes.
  /// - [tag]: The tag of the custom widget.
  ///
  /// Returns:
  /// The parsed attributes for the custom widget.
  dynamic _parseCustomWidgetAttributes(JSONObject? json, String? tag) {
    assert(tag != null, "Custom widget must have specified tag");

    final attributesMapper = DuitRegistry.getAttributesFactory(tag!);
    if (attributesMapper != null) {
      return attributesMapper(tag, json);
    } else {
      return EmptyAttributes();
    }
  }

  /// Parses and creates a `ViewAttributeWrapper` instance based on the specified type, JSON object, and tag.
  ///
  /// This method is used to parse and map attributes for different DUIT elements.
  /// It returns a new instance of `ViewAttributeWrapper` with the appropriate payload type based on the element type.
  ///
  /// Parameters:
  /// - [type]: The type of the DUIT element.
  /// - [json]: The JSON object representing the attributes of the DUIT element.
  /// - [tag]: The tag of the DUIT element (optional for custom widgets).
  ///
  /// Returns:
  /// A `ViewAttributeWrapper` instance with the parsed attributes.
  @override
  ViewAttribute<T> parse<T>(
    String type,
    JSONObject? json,
    String? tag, {
    String? id,
  }) {
    final data = json ?? {};
    final payload = switch (type) {
      ElementType.text => TextAttributes.fromJson(data),
      ElementType.row => RowAttributes.fromJson(data),
      ElementType.column => ColumnAttributes.fromJson(data),
      ElementType.sizedBox => SizedBoxAttributes.fromJson(data),
      ElementType.center => CenterAttributes.fromJson(data),
      ElementType.coloredBox => ColoredBoxAttributes.fromJson(data),
      ElementType.textField => TextFieldAttributes.fromJson(data),
      ElementType.elevatedButton => ElevatedButtonAttributes.fromJson(data),
      ElementType.stack => StackAttributes.fromJson(data),
      ElementType.expanded => ExpandedAttributes.fromJson(data),
      ElementType.padding => PaddingAttributes.fromJson(data),
      ElementType.positioned => PositionedAttributes.fromJson(data),
      ElementType.decoratedBox => DecoratedBoxAttributes.fromJson(data),
      ElementType.checkbox => CheckboxAttributes.fromJson(data),
      ElementType.container => ContainerAttributes.fromJson(data),
      ElementType.image => ImageAttributes.fromJson(data),
      ElementType.gestureDetector => GestureDetectorAttributes.fromJson(data),
      ElementType.align => AlignAttributes.fromJson(data),
      ElementType.transform => TransformAttributes.fromJson(data),
      ElementType.richText => RichTextAttributes.fromJson(data),
      ElementType.wrap => WrapAttributes.fromJson(data),
      ElementType.custom => _parseCustomWidgetAttributes(json, tag),
      ElementType.lifecycleStateListener =>
        LifecycleStateListenerAttributes.fromJson(data),
      ElementType.singleChildScrollview =>
        SingleChildScrollviewAttributes.fromJson(data),
      ElementType.radio => RadioAttributes.fromJson(data),
      ElementType.radioGroupContext =>
        RadioGroupContextAttributes.fromJson(data),
      ElementType.ignorePointer => IgnorePointerAttributes.fromJson(data),
      ElementType.opacity => OpacityAttributes.fromJson(data),
      ElementType.slider => SliderAttributes.fromJson(data),
      ElementType.fittedBox => FittedBoxAttributes.fromJson(data),
      ElementType.switchW => SwitchAttributes.fromJson(data),
      ElementType.meta => MetaAttributes.fromJson(data),
      ElementType.listView => ListViewAttributes.fromJson(data),
      ElementType.repaintBoundary => RepaintBoundaryAttributes.fromJson(data),
      ElementType.overflowBox => OverflowBoxAttributes.fromJson(data),
      ElementType.animatedSize => AnimatedSizeAttributes.fromJson(data),
      ElementType.animatedBuilder => AnimatedBuilderAttributes.fromJson(data),
      ElementType.intrinsicHeight => IntrinsicHeightAttributes.fromJson(data),
      ElementType.intrinsicWidth => IntrinsicWidthAttributes.fromJson(data),
      ElementType.rotatedBox => RotatedBoxAttributes.fromJson(data),
      ElementType.constrainedBox => ConstrainedBoxAttributes.fromJson(data),
      ElementType.backdropFilter => BackdropFilterAttributes.fromJson(data),
      ElementType.animatedOpacity => AnimatedOpacityAttributes.fromJson(data),
      ElementType.safeArea => SafeAreaAttributes.fromJson(data),
      ElementType.gridView => GridViewAttributes.fromJson(data),
      ElementType.subtree ||
      ElementType.component =>
        SubtreeAttributes.fromJson(data),
      ElementType.remoteSubtree => RemoteSubtreeAttributes.fromJson(data),
      ElementType.card => CardAttributes.fromJson(data),
      ElementType.appBar => AppBarAttributes.fromJson(data),
      ElementType.scaffold => ScaffoldAttributes.fromJson(data),
      ElementType.inkWell => InkWellAttributes.fromJson(data),
      ElementType.carouselView => CarouselViewAttributes.fromJson(data),
      ElementType.animatedContainer =>
        AnimatedContainerAttributes.fromJson(data),
      ElementType.animatedAlign => AnimatedAlignAttributes.fromJson(data),
      ElementType.animatedRotation => AnimatedRotationAttributes.fromJson(data),
      ElementType.animatedPadding => AnimatedPaddingAttributes.fromJson(data),
      ElementType.animatedPositioned =>
        AnimatedPositionedAttributes.fromJson(data),
      ElementType.animatedScale => AnimatedScaleAttributes.fromJson(data),
      ElementType.absorbPointer => AbsorbPointerAttributes.fromJson(data),
      ElementType.offstage => OffstageAttributes.fromJson(data),
      ElementType.animatedCrossFade =>
        AnimatedCrossFadeAttributes.fromJson(data),
      ElementType.physicalModel => PhysicalModelAttributes.fromJson(data),
      ElementType.animatedPhysicalModel =>
        AnimatedPhysicalModelAttributes.fromJson(data),
      ElementType.empty || String() => EmptyAttributes(),
    };

    return ViewAttribute(payload: payload, id: id ?? "null_id");
  }
}
