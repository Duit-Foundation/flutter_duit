# Attribute Access Reference

This file provides comprehensive reference for accessing widget attributes from JSON.

## Theme Integration

Themes are applied automatically during ViewAttribute creation via `ViewAttribute.from()`. Widget implementations do NOT need to handle theme merging explicitly.

### Theme Application Flow

1. Theme definitions are registered with `DuitThemePreprocessor`
2. When widget JSON includes `"theme": "theme_name"`, theme data is looked up
3. `ViewAttribute.from()` merges theme data with widget attributes
4. Widget receives merged attributes in `attributes.payload` (non-controlled) or `attributes` (controlled via ViewControllerChangeListener)
5. Widget implementation simply uses attributes without caring about themes

### Theme Attributes in Widget JSON

Widgets can reference themes using the `theme` attribute:

```json
{
  "type": "Text",
  "id": "my_text",
  "theme": "primary_text",
  "attributes": {
    "data": "Hello World"
  }
}
```

**Important**: The `theme` attribute is consumed during `ViewAttribute.from()` and is NOT present in the final `attributes.payload` that widget implementation receives.

### Override Rules

Control how theme and widget attributes are merged:

| Rule | Description |
|------|-------------|
| `themeOverlay` (default) | Widget attributes take precedence over theme values |
| `themePriority` | Theme values take precedence over widget attributes |

```json
{
  "type": "Text",
  "id": "my_text",
  "theme": "primary_text",
  "overrideRule": "themePriority",
  "attributes": {
    "data": "Hello World",
    "textAlign": "left"
  }
}
```

In this example, if `primary_text` theme defines `textAlign: "center"`, the theme value will be used because of `themePriority`.

### Theme-Related Attribute Access

When implementing widgets that support theming:

```dart
@override
Widget build(BuildContext context) {
  // Themes are already merged into attributes
  final attrs = attributes.payload;

  // Just access attributes normally - no special handling needed
  return Text(
    attrs.getString(key: "data"),
    style: attrs.textStyle(),  // Theme values already merged
    textAlign: attrs.textAlign(),  // Theme values already merged
  );
}
```

## ViewAttribute Methods

### Numeric Values

**Double Values:**
```dart
// Get required double (throws if missing)
double value = attrs.getDouble(key: "opacity");

// Get double with default
double value = attrs.getDouble(key: "opacity", defaultValue: 1.0);

// Get optional double (returns null if missing)
double? value = attrs.tryGetDouble(key: "opacity");

// Get double from string representation
double value = attrs.getDoubleFromString(key: "value", defaultValue: 0.0);
```

**Int Values:**
```dart
// Get required int
int value = attrs.getInt(key: "maxLines");

// Get int with default
int value = attrs.getInt(key: "maxLines", defaultValue: 1);

// Get optional int
int? value = attrs.tryGetInt(key: "maxLines");
```

### Boolean Values

```dart
// Get boolean with default
bool visible = attrs.getBool("visible", defaultValue: true);

// Get optional boolean
bool? visible = attrs.tryGetBool("visible");
```

### String Values

```dart
// Get required string
String title = attrs.getString(key: "title");

// Get optional string
String? title = attrs.tryGetString(key: "title");
```

### Color Values

```dart
// Parse color from hex string (#RRGGBB or #AARRGGBB)
Color? color = attrs.tryParseColor(key: "backgroundColor");

// Parse color with default
Color color = attrs.parseColor(key: "backgroundColor", defaultValue: Colors.black);

// Get color as ARGB array [R, G, B, A] or hex string
Color? color = attrs.getColor(key: "color");
```

### EdgeInsets Values

```dart
// Parse edge insets from JSON
EdgeInsets? padding = attrs.edgeInsets();

// Parse with custom key
EdgeInsets? margin = attrs.edgeInsets(key: "margin");

// Parse from string format "8.0,16.0,8.0,16.0"
EdgeInsets? padding = attrs.edgeInsetsFromString();
```

**JSON formats for EdgeInsets:**
```json
{
  "padding": [8, 16, 8, 16]           // [left, top, right, bottom]
}

{
  "padding": "8.0,16.0,8.0,16.0"      // String format
}

{
  "padding": {
    "all": 16                           // All edges same
  }
}

{
  "padding": {
    "left": 8,
    "top": 16,
    "right": 8,
    "bottom": 16
  }
}
```

### Alignment Values

```dart
// Parse alignment
Alignment? alignment = attrs.alignment();

// Parse with default
Alignment alignment = attrs.alignment(defaultValue: Alignment.center);

// Parse with custom key
Alignment transformAlignment = attrs.alignment(key: "transformAlignment");
```

**JSON formats for Alignment:**
```json
{
  "alignment": "center"                  // Named alignment
}

{
  "alignment": [-1.0, 1.0]             // [x, y] coordinates
}
```

### BoxConstraints Values

```dart
// Parse box constraints
BoxConstraints? constraints = attrs.boxConstraints();
```

**JSON formats for BoxConstraints:**
```json
{
  "constraints": {
    "minWidth": 100,
    "maxWidth": 200,
    "minHeight": 50,
    "maxHeight": 100
  }
}
```

### Decoration Values

```dart
// Parse BoxDecoration
BoxDecoration? decoration = attrs.decoration();
```

**JSON formats for Decoration:**
```json
{
  "decoration": {
    "color": "#FFFFFF",
    "borderRadius": 8,
    "border": {
      "width": 1,
      "color": "#000000"
    },
    "boxShadow": [
      {
        "color": "#000000",
        "blurRadius": 8,
        "spreadRadius": 2,
        "offset": [0, 2]
      }
    ]
  }
}
```

### Text-Related Values

**TextStyle:**
```dart
TextStyle? style = attrs.textStyle();
```

**TextAlign:**
```dart
TextAlign align = attrs.textAlign(defaultValue: TextAlign.start);
```

**TextDirection:**
```dart
TextDirection? direction = attrs.textDirection();
```

**InputDecoration (for TextField):**
```dart
InputDecoration? decoration = attrs.inputDecoration();
```

### Layout-Related Values

**MainAxisAlignment:**
```dart
MainAxisAlignment? mainAxisAlignment = attrs.mainAxisAlignment();
```

**CrossAxisAlignment:**
```dart
CrossAxisAlignment? crossAxisAlignment = attrs.crossAxisAlignment();
```

**MainAxisSize:**
```dart
MainAxisSize? mainAxisSize = attrs.mainAxisSize();
```

**WrapAlignment:**
```dart
WrapAlignment? alignment = attrs.wrapAlignment();
WrapCrossAlignment? crossAlignment = attrs.wrapCrossAlignment();
```

**StackAlignment:**
```dart
StackFit? fit = attrs.stackFit();
Alignment? alignment = attrs.stackAlignment();
```

### Image-Related Values

**ImageType:**
```dart
ImageType? type = attrs.getImageType();
```

**JSON formats:**
```json
{
  "source": "https://example.com/image.png",    // Network image
  "source": "assets/images/logo.png",          // Asset image
  "source": "file:///path/to/image.png",      // File image
  "type": "network"                          // Optional: network, asset, file
}
```

### Input-Related Values

**TextInputType:**
```dart
TextInputType? keyboardType = attrs.keyboardType();
```

**TextInputAction:**
```dart
TextInputAction? textInputAction = attrs.textInputAction();
```

**ClipBehavior:**
```dart
ClipBehavior? clipBehavior = attrs.clipBehavior(defaultValue: Clip.none);
```

### Animation Values

**Duration:**
```dart
Duration? duration = attrs.duration();
```

**JSON format:**
```json
{
  "duration": 300,              // Milliseconds
  "duration": "300ms",
  "duration": {
    "milliseconds": 300
  }
}
```

**Curve:**
```dart
Curve? curve = attrs.curve();
```

**Common curves:** ease, easeIn, easeOut, easeInOut, fastOutSlowIn, bounceIn, bounceOut, elasticIn, elasticOut

### Geometry Values

**BorderRadius:**
```dart
BorderRadius? borderRadius = attrs.borderRadius();
```

**JSON format:**
```json
{
  "borderRadius": 8,              // All corners
  "borderRadius": {
    "topLeft": 8,
    "topRight": 8,
    "bottomLeft": 8,
    "bottomRight": 8
  }
}
```

**Offset:**
```dart
Offset? offset = attrs.offset();
```

**JSON format:**
```json
{
  "offset": [10, 20]             // [dx, dy]
}
```

**Size:**
```dart
Size? size = attrs.size();
```

**JSON format:**
```json
{
  "width": 100,
  "height": 200
}
```

### List and Map Values

```dart
// Get list of doubles
List<double>? values = attrs.getDoubleList(key: "values");

// Get list of strings
List<String>? items = attrs.getStringList(key: "items");

// Get map
Map<String, dynamic>? data = attrs.getMap(key: "data");
```

## Common Attribute Patterns

### Pattern 1: Required with Default
```dart
opacity: attrs.getDouble("opacity", defaultValue: 1.0)
```

### Pattern 2: Optional with Null Check
```dart
width: attrs.tryGetDouble(key: "width")
```

### Pattern 3: Boolean with Default
```dart
enabled: attrs.getBool("enabled", defaultValue: true)
```

### Pattern 4: Optional Boolean
```dart
maintainState: attrs.getBool("maintainState")
```

### Pattern 5: Complex Object
```dart
decoration: attrs.decoration()
padding: attrs.edgeInsets()
alignment: attrs.alignment()
```

## Attribute Safety Guidelines

1. **Always provide defaults for critical values:**
   ```dart
   // Good
   opacity: attrs.getDouble("opacity", defaultValue: 1.0)

   // Bad (may crash if missing)
   opacity: attrs.getDouble(key: "opacity")
   ```

2. **Use tryGet* for optional values:**
   ```dart
   // Good
   width: attrs.tryGetDouble(key: "width")

   // Bad (returns null, may cause issues)
   width: attrs.getDouble(key: "width", defaultValue: null)
   ```

3. **Be consistent with key naming:**
   - Use camelCase: `maintainState`, `childAspectRatio`, `crossAxisCount`
   - Match Flutter widget property names

4. **Handle color formats:**
   ```dart
   // Handles both hex strings and RGBA arrays
   color: attrs.tryParseColor(key: "backgroundColor")
   ```

## Widget-Specific Attribute Examples

### Container Widget
```dart
Container(
  key: ValueKey(attributes.id),
  width: attrs.tryGetDouble(key: "width"),
  height: attrs.tryGetDouble(key: "height"),
  color: attrs.tryParseColor(key: "color"),
  alignment: attrs.alignment(),
  padding: attrs.edgeInsets(),
  margin: attrs.edgeInsets(key: "margin"),
  constraints: attrs.boxConstraints(),
  decoration: attrs.decoration(),
  clipBehavior: attrs.clipBehavior(defaultValue: Clip.none)!,
  transformAlignment: attrs.alignment(key: "transformAlignment"),
)
```

### Text Widget
```dart
Text(
  data: attrs.getString(key: "text"),
  style: attrs.textStyle(),
  textAlign: attrs.textAlign(defaultValue: TextAlign.start),
  textDirection: attrs.textDirection(),
  maxLines: attrs.getInt(key: "maxLines"),
  overflow: attrs.textOverflow(defaultValue: TextOverflow.clip),
)
```

### Padding Widget
```dart
Padding(
  padding: attrs.edgeInsets() ?? EdgeInsets.zero,
  child: child,
)
```

### Opacity Widget
```dart
Opacity(
  opacity: attrs.getDouble("opacity", defaultValue: 1.0),
  alwaysIncludeSemantics: attrs.getBool("alwaysIncludeSemantics"),
  child: child,
)
```

## Common JSON Attribute Examples

### Simple Widget with Attributes
```json
{
  "type": "Container",
  "id": "container_1",
  "controlled": false,
  "attributes": {
    "width": 200,
    "height": 100,
    "color": "#FF5722",
    "padding": [16, 8, 16, 8]
  },
  "child": {
    "type": "Text",
    "id": "text_1",
    "controlled": false,
    "attributes": {
      "text": "Hello World",
      "style": {
        "fontSize": 18,
        "color": "#000000"
      }
    }
  }
}
```

### Widget with Complex Attributes
```json
{
  "type": "Container",
  "id": "styled_container",
  "controlled": true,
  "attributes": {
    "decoration": {
      "color": "#FFFFFF",
      "borderRadius": 12,
      "border": {
        "width": 2,
        "color": "#2196F3"
      },
      "boxShadow": [
        {
          "color": "#00000040",
          "blurRadius": 8,
          "offset": [0, 4]
        }
      ]
    },
    "constraints": {
      "minWidth": 100,
      "maxWidth": 400,
      "minHeight": 50
    }
  }
}
```

## Theme Token Reference

### Available Theme Token Types

| Theme Token Class | Excluded Fields | Typical Use Cases |
|------------------|-----------------|------------------|
| `TextThemeToken` | `data` | Text styling without the actual text content |
| `ImageThemeToken` | `type`, `src`, `byteData` | Image layout and presentation without source |
| `AttendedWidgetThemeToken` | `value` | Checkbox, Switch, TextField, Meta - interactive widgets with value |
| `RadioGroupContextThemeToken` | `groupValue`, `value` | Radio button group containers |
| `RadioThemeToken` | `parentBuilderId`, `affectedProperties`, `value` | Individual radio buttons |
| `SliderThemeToken` | `onChanged`, `onChangeStart`, `onChangeEnd`, `value` | Slider widgets - callbacks excluded |
| `ImplicitAnimatableThemeToken` | `onEnd` | AnimatedOpacity, AnimatedContainer, etc. |
| `ExcludeGestureCallbacksThemeToken` | All gesture callbacks (onTap, onDoubleTap, onLongPress, etc.) | GestureDetector, InkWell |
| `ExcludeChildThemeToken` | Child subviews (title, actions, body, appBar, etc.) | AppBar, Scaffold, FlexibleSpaceBar |
| `DynamicChildHolderThemeToken` | `childObjects`, `constructor`, `type`, `restorationId` | GridView, ListView, SliverList, etc. |
| `AnimatedPropOwnerThemeToken` | `parentBuilderId`, `affectedProperties` | Container, Padding, Align, Opacity, etc. |
| `DefaultThemeToken` | None | ElevatedButton, Center, SafeArea, etc. - no exclusions |

### Selecting Theme Token for New Widgets

When implementing a new widget, use this decision tree:

```
Widget has callbacks that shouldn't be themed?
├─ Yes → ExcludeGestureCallbacksThemeToken
│   (GestureDetector, InkWell)
└─ No
    Widget has child subviews that shouldn't be themed?
    ├─ Yes → ExcludeChildThemeToken
    │   (AppBar, Scaffold)
    └─ No
        Widget has dynamic children (list/grid)?
        ├─ Yes → DynamicChildHolderThemeToken
        │   (GridView, ListView, SliverList)
        └─ No
            Widget has value that changes dynamically?
            ├─ Yes → AttendedWidgetThemeToken
            │   (Checkbox, Switch, TextField)
            └─ No
                Widget has animation end callback?
                ├─ Yes → ImplicitAnimatableThemeToken
                │   (AnimatedOpacity, AnimatedContainer)
                └─ No
                    Widget has animatable properties (width, height, opacity)?
                    ├─ Yes → AnimatedPropOwnerThemeToken
                    │   (Container, Padding, Opacity)
                    └─ No
                        Widget has specific exclusions (e.g., image source)?
                        ├─ Yes → Use specific token (TextThemeToken, ImageThemeToken, etc.)
                        └─ No → DefaultThemeToken
```

### Theme Token Exclusion Examples

**TextThemeToken - Excludes text content:**
```dart
// Theme definition
{
  "heading": {
    "type": "Text",
    "data": {
      "style": {"fontSize": 32, "color": "#FF0000"}
    }
  }
}

// Widget usage - "data" is NOT overridden by theme
{
  "type": "Text",
  "theme": "heading",
  "attributes": {
    "data": "My Custom Heading"  // This is preserved, not themed
  }
}
```

**ImageThemeToken - Excludes image source:**
```dart
// Theme definition
{
  "thumbnail": {
    "type": "Image",
    "data": {
      "width": 100,
      "height": 100,
      "fit": "cover"
    }
  }
}

// Widget usage - "src" is NOT overridden by theme
{
  "type": "Image",
  "theme": "thumbnail",
  "attributes": {
    "src": "https://example.com/image.jpg"  // This is preserved
  }
}
```

**ExcludeGestureCallbacksThemeToken - Excludes callbacks:**
```dart
// Theme definition
{
  "tapable": {
    "type": "GestureDetector",
    "data": {
      "behavior": "translucent",
      "excludeFromSemantics": false
    }
  }
}

// Widget usage - callbacks are NOT overridden by theme
{
  "type": "GestureDetector",
  "theme": "tapable",
  "attributes": {
    "onTap": "handleTap"  // This is preserved
  }
}
```
