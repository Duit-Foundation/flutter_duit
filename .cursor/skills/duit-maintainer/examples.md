# Widget Implementation Examples

This file provides complete examples of widget implementations following Duit patterns.

## Example 1: Single Child Widget (Non-Controlled by Default)

**Widget: Opacity**

Implementation (`lib/src/ui/widgets/opacity.dart`):
```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitOpacity extends StatelessWidget {
  final ViewAttribute attributes;
  final Widget child;

  const DuitOpacity({
    required this.attributes,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    return Opacity(
      key: ValueKey(attributes.id),
      opacity: attrs.getDouble("opacity", defaultValue: 1.0),
      alwaysIncludeSemantics: attrs.getBool("alwaysIncludeSemantics"),
      child: child,
    );
  }
}

class DuitControlledOpacity extends StatefulWidget {
  final UIElementController controller;
  final Widget child;

  const DuitControlledOpacity({
    required this.controller,
    required this.child,
    super.key,
  });

  @override
  State<DuitControlledOpacity> createState() =>
      _DuitControlledOpacityState();
}

class _DuitControlledOpacityState extends State<DuitControlledOpacity>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      key: ValueKey(widget.controller.id),
      opacity: attributes.getDouble("opacity", defaultValue: 1.0),
      alwaysIncludeSemantics: attributes.getBool("alwaysIncludeSemantics"),
      child: widget.child,
    );
  }
}
```

Element type (`lib/src/ui/element_type.dart`):
```dart
  opacity(
    name: "Opacity",
    isControlledByDefault: false,
    childRelation: 1,
  ),
```

Build function (`lib/src/ui/widget_from_element.dart`):
```dart
Widget _buildOpacity(ElementPropertyView model) {
  return switch (model.controlled) {
    true => DuitControlledOpacity(
        controller: model.viewController,
        child: _buildWidget(model.child),
      ),
    false => DuitOpacity(
        attributes: model.attributes,
        child: _buildWidget(model.child),
      ),
  };
}
```

Build lookup (`lib/src/ui/build_fn_lookup.dart`):
```dart
  ElementType.opacity: _buildOpacity,
```

Export (`lib/src/ui/widgets/index.dart`):
```dart
export "opacity.dart";
```

Lookup table (`lib/src/ui/element_type.dart`):
```dart
  "Opacity": ElementType.opacity,
```

## Example 2: Multi-Child Widget with Nullable Children

**Widget: Visibility**

Implementation (`lib/src/ui/widgets/visibility.dart`):
```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitVisibility extends StatelessWidget {
  final ViewAttribute attributes;
  final List<Widget?> children;

  const DuitVisibility({
    required this.attributes,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;
    final child = children.elementAtOrNull(0) ?? const SizedBox.shrink();
    final replacement = children.elementAtOrNull(1) ?? const SizedBox.shrink();

    return Visibility(
      key: ValueKey(attributes.id),
      visible: attrs.getBool("visible", defaultValue: true),
      maintainState: attrs.getBool("maintainState"),
      maintainAnimation: attrs.getBool("maintainAnimation"),
      maintainSize: attrs.getBool("maintainSize"),
      maintainSemantics: attrs.getBool("maintainSemantics"),
      maintainInteractivity: attrs.getBool("maintainInteractivity"),
      replacement: replacement,
      child: child,
    );
  }
}

class DuitControlledVisibility extends StatefulWidget {
  final UIElementController controller;
  final List<Widget?> children;

  const DuitControlledVisibility({
    required this.controller,
    required this.children,
    super.key,
  });

  @override
  State<DuitControlledVisibility> createState() =>
      _DuitControlledVisibilityState();
}

class _DuitControlledVisibilityState
    extends State<DuitControlledVisibility>
    with ViewControllerChangeListener {
  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.children.elementAtOrNull(0) ?? const SizedBox.shrink();
    final replacement = widget.children.elementAtOrNull(1) ?? const SizedBox.shrink();

    return Visibility(
      key: ValueKey(widget.controller.id),
      visible: attributes.getBool("visible", defaultValue: true),
      maintainState: attributes.getBool("maintainState"),
      maintainAnimation: attributes.getBool("maintainAnimation"),
      maintainSize: attributes.getBool("maintainSize"),
      maintainSemantics: attributes.getBool("maintainSemantics"),
      maintainInteractivity: attributes.getBool("maintainInteractivity"),
      replacement: replacement,
      child: child,
    );
  }
}
```

Element type (`lib/src/ui/element_type.dart`):
```dart
  visibility(
    name: "Visibility",
    isControlledByDefault: false,
    childRelation: 2,
  ),
```

Build function (`lib/src/ui/widget_from_element.dart`):
```dart
Widget _buildVisibility(ElementPropertyView model) {
  final children = _mapToNullableWidgetList(model);
  return switch (model.controlled) {
    true => DuitControlledVisibility(
        controller: model.viewController,
        children: children,
      ),
    false => DuitVisibility(
        attributes: model.attributes,
        children: children,
      ),
  };
}
```

## Example 3: Controlled-Only Widget (Always Interactive)

**Widget: TextField**

Implementation (`lib/src/ui/widgets/text_field.dart`):
```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";

class DuitTextField extends StatefulWidget {
  final UIElementController controller;

  const DuitTextField({
    required this.controller,
    super.key,
  });

  @override
  State<DuitTextField> createState() => _DuitTextFieldState();
}

class _DuitTextFieldState extends State<DuitTextField>
    with ViewControllerChangeListener {
  final _focusNode = FocusNode();

  @override
  void initState() {
    attachStateToController(widget.controller);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final attrs = attributes.payload;

    return TextField(
      key: ValueKey(widget.controller.id),
      controller: widget.controller.textController,
      focusNode: _focusNode,
      decoration: attrs.inputDecoration(),
      keyboardType: attrs.keyboardType(),
      textInputAction: attrs.textInputAction(),
      textAlign: attrs.textAlign(defaultValue: TextAlign.start),
      style: attrs.textStyle(),
      obscureText: attrs.getBool("obscureText", defaultValue: false),
      maxLines: attrs.getInt("maxLines", defaultValue: 1),
      enabled: attrs.getBool("enabled", defaultValue: true),
      autofocus: attrs.getBool("autofocus"),
      maxLength: attrs.getInt("maxLength"),
    );
  }
}
```

Element type (`lib/src/ui/element_type.dart`):
```dart
  textField(
    name: "TextField",
    isControlledByDefault: true,
    childRelation: 0,
    mayHaveRelatedAction: true,
  ),
```

Build function (`lib/src/ui/widget_from_element.dart`):
```dart
Widget _buildTextField(ElementPropertyView model) => DuitTextField(
      controller: model.viewController,
    );
```

## Example 4: Test File

**Test: Visibility** (`test/d_visibility_test.dart`):
```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

import "utils.dart";

Map<String, dynamic> _createWidget([bool isControlled = false]) {
  return {
    "type": "Visibility",
    "id": "visibility_test",
    "controlled": isControlled,
    "attributes": {"visible": true},
    "children": [
      {
        "type": "Container",
        "id": "con",
        "controlled": false,
        "attributes": {"color": "#DCDCDC", "width": 50, "height": 50},
      },
    ],
  };
}

void main() {
  group("DuitVisibility widget tests", () {
    testWidgets("check widget", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost.withDriver(
            driver: XDriver.static(
              _createWidget(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final widget = find.byKey(const ValueKey("visibility_test"));

      expect(widget, findsOneWidget);
    });

    testWidgets(
      "must update attributes",
      (tester) async {
        final driver = XDriver.static(
          _createWidget(true),
        );

        await pumpDriver(tester, driver.asInternalDriver);

        final widget = find.byKey(const ValueKey("visibility_test"));
        expect(widget, findsOneWidget);

        final visibility = tester.widget<Visibility>(widget);
        expect(visibility.visible, true);

        await driver.asInternalDriver.updateAttributes(
          "visibility_test",
          {
            "visible": false,
          },
        );

        await tester.pumpAndSettle();

        final updatedVisibility = tester.widget<Visibility>(widget);
        expect(updatedVisibility.visible, false);
      },
    );
  });
}
```

## Complete Implementation Checklist

Use this checklist when implementing new widgets:

### Implementation Files
- [ ] Create `lib/src/ui/widgets/[widget_name].dart`
- [ ] Implement `Duit[WidgetName]` class (StatelessWidget)
- [ ] Implement `DuitControlled[WidgetName]` class (StatefulWidget)
- [ ] Implement state class with `ViewControllerChangeListener` mixin
- [ ] Call `attachStateToController` in `initState`
- [ ] Use correct key patterns

### Registration
- [ ] Add enum value to `ElementType` in `element_type.dart`
- [ ] Add entry to `_stringToTypeLookupTable` in `element_type.dart`
- [ ] Add `_build[WidgetName]` function to `widget_from_element.dart`
- [ ] Add entry to `_buildFnLookup` in `build_fn_lookup.dart`
- [ ] Export widget file in `widgets/index.dart`
- [ ] **Add widget type mapping in `DuitThemePreprocessor.createToken()`**

### Tests
- [ ] Create `test/d_[widget_name]_test.dart`
- [ ] Test non-controlled widget rendering
- [ ] Test attribute updates for controlled widget
- [ ] Use `pumpDriver` for controlled widget tests
- [ ] **Test theme application for the widget**

### Validation
- [ ] Run tests with `fvm flutter test`
- [ ] Verify no linter errors
- [ ] Check widget renders correctly in example app

## Example 5: Theme Implementation and Testing

### Defining Themes for a Widget

For the Text widget, themes are defined and initialized at application startup:

```dart
import 'package:duit_kernel/duit_kernel.dart';
import 'package:flutter_duit/src/ui/theme/preprocessor.dart';

// Define theme preprocessor with text themes
final themePreprocessor = const DuitThemePreprocessor().tokenize({
  "primary_heading": {
    "type": "Text",
    "data": {
      "style": {
        "fontSize": 32.0,
        "fontWeight": "w700",
        "color": "#333333",
      },
      "textAlign": "center",
    },
  },
  "secondary_heading": {
    "type": "Text",
    "data": {
      "style": {
        "fontSize": 24.0,
        "fontWeight": "w600",
        "color": "#666666",
      },
    },
  },
  "body_text": {
    "type": "Text",
    "data": {
      "style": {
        "fontSize": 16.0,
        "color": "#333333",
        "height": 1.5,
      },
    },
  },
});

// Initialize DuitRegistry with themes
await DuitRegistry.initialize(
  theme: themePreprocessor,
);
```

### Theme Token for Text Widget

The Text widget uses `TextThemeToken` which excludes the `data` field (the actual text content) from theming:

```dart
// In lib/src/ui/theme/tokens.dart
final class TextThemeToken extends ThemeToken {
  TextThemeToken(Map<String, dynamic> data)
      : super(
          const {
            "data",  // Text content itself is excluded from theming
            ..._animatedOwnerExcludedFields,
          },
          data,
          ElementType.text.name,
        );
}
```

### Widget Using Themes

```dart
// Widget JSON with theme applied
{
  "type": "Text",
  "id": "heading",
  "controlled": false,
  "theme": "primary_heading",
  "attributes": {
    "data": "Welcome to Duit!"
  }
}

// Widget JSON with theme override
{
  "type": "Text",
  "id": "heading",
  "controlled": false,
  "theme": "primary_heading",
  "overrideRule": "themeOverlay",
  "attributes": {
    "data": "Welcome to Duit!",
    "textAlign": "left"  // Widget attribute overrides theme value
  }
}
```

### Testing Theme Application

```dart
import "package:flutter/material.dart";
import "package:flutter_duit/flutter_duit.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  setUpAll(() async {
    // Initialize theme preprocessor for tests
    final proc = const DuitThemePreprocessor().tokenize({
      "heading_theme": {
        "type": "Text",
        "data": {
          "style": {
            "fontSize": 32.0,
            "fontWeight": "w700",
            "color": "#FF0000",
          },
          "textAlign": "center",
        },
      },
      "body_theme": {
        "type": "Text",
        "data": {
          "style": {
            "fontSize": 16.0,
            "color": "#333333",
          },
        },
      },
    });
    await DuitRegistry.initialize(theme: proc);
  });

  group("Text widget theme tests", () {
    testWidgets(
      "must apply theme attributes",
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: XDriver.static({
                "type": "Text",
                "id": "text_1",
                "theme": "heading_theme",
                "attributes": {"data": "Themed Text"},
              }),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final textWidget = tester.widget<Text>(find.byKey(const ValueKey("text_1")));
        expect(textWidget.style?.fontSize, equals(32.0));
        expect(textWidget.style?.fontWeight, equals(FontWeight.w700));
        expect(textWidget.style?.color, equals(const Color(0xFFFF0000)));
        expect(textWidget.textAlign, equals(TextAlign.center));
      },
    );

    testWidgets(
      "must not override widget attributes with theme when using themeOverlay",
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: XDriver.static({
                "type": "Text",
                "id": "text_1",
                "theme": "heading_theme",
                "overrideRule": "themeOverlay",
                "attributes": {
                  "data": "Custom Text",
                  "textAlign": "left",
                },
              }),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final textWidget = tester.widget<Text>(find.byKey(const ValueKey("text_1")));
        expect(textWidget.textAlign, equals(TextAlign.left)); // Widget attribute wins
        expect(textWidget.style?.fontSize, equals(32.0)); // Theme value used
      },
    );

    testWidgets(
      "must override widget attributes with theme when using themePriority",
      (tester) async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: DuitViewHost.withDriver(
              driver: XDriver.static({
                "type": "Text",
                "id": "text_1",
                "theme": "heading_theme",
                "overrideRule": "themePriority",
                "attributes": {
                  "data": "Custom Text",
                  "textAlign": "left",
                },
              }),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final textWidget = tester.widget<Text>(find.byKey(const ValueKey("text_1")));
        expect(textWidget.textAlign, equals(TextAlign.center)); // Theme wins
      },
    );
  });
}
```

## Example 6: Adding Theme Support for a New Widget

### Step 1: Select Appropriate Theme Token

When adding a new widget, choose the correct theme token type. For example, if creating a custom card-like widget:

```dart
// In lib/src/ui/theme/preprocessor.dart
@override
ThemeToken createToken(String widgetType, Map<String, dynamic> themeData) {
  final type = ElementType.valueOrNull(widgetType);
  return switch (type) {
    // ... existing mappings
    ElementType.customCard =>
        AnimatedPropOwnerThemeToken(themeData, widgetType),
    _ => customWidgetTokenizer?.call(widgetType, themeData) ?? const UnknownThemeToken(),
  };
}
```

### Step 2: Test Theme Support

Add theme tests to your widget's test file:

```dart
void main() {
  setUpAll(() async {
    final proc = const DuitThemePreprocessor().tokenize({
      "card_theme": {
        "type": "CustomCard",
        "data": {
          "elevation": 8.0,
          "color": "#FFFFFF",
          "borderRadius": 12.0,
        },
      },
    });
    await DuitRegistry.initialize(theme: proc);
  });

  group("CustomCard widget theme tests", () {
    testWidgets("must apply theme attributes", (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DuitViewHost.withDriver(
            driver: XDriver.static({
              "type": "CustomCard",
              "id": "card_1",
              "theme": "card_theme",
              "attributes": {},
              "child": {
                "type": "Text",
                "id": "text_1",
                "attributes": {"data": "Card Content"},
              },
            }),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final card = tester.widget<Card>(find.byKey(const ValueKey("card_1")));
      expect(card.elevation, equals(8.0));
      expect(card.color, equals(Colors.white));
    });
  });
}
```

## Example 7: Creating Custom Theme Token

If your widget requires special handling (e.g., needs to exclude specific fields), create a custom theme token:

```dart
// In lib/src/ui/theme/tokens.dart
final class CustomWidgetThemeToken extends ThemeToken {
  CustomWidgetThemeToken(Map<String, dynamic> data)
      : super(
          const {
            "onCustomEvent",  // Exclude custom callbacks
            "controllerId",  // Exclude controller references
          },
          data,
          ElementType.customWidget.name,
        );
}

// In lib/src/ui/theme/preprocessor.dart
@override
ThemeToken createToken(String widgetType, Map<String, dynamic> themeData) {
  final type = ElementType.valueOrNull(widgetType);
  return switch (type) {
    // ... existing mappings
    ElementType.customWidget => CustomWidgetThemeToken(themeData),
    _ => customWidgetTokenizer?.call(widgetType, themeData) ?? const UnknownThemeToken(),
  };
}
```

## Theme Best Practices

1. **Exclude functional fields from themes**: Callbacks, IDs, controller references, and data content should not be themed
2. **Theme only presentation**: Themes should only control visual appearance (colors, sizes, spacing, typography)
3. **Use semantic naming**: Name themes by their purpose (`primary_button`, `secondary_heading`) not by appearance (`blue_button`, `big_text`)
4. **Provide defaults**: Widget implementations should provide sensible defaults for all themeable properties
5. **Test theme application**: Always include theme tests when implementing new widgets
6. **Document exclusions**: If using custom theme token, document which fields are excluded and why
