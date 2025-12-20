## 4.1.0

- Added new widgets: AnimatedPositionedDirectional, ClipRect, ClipOval, PageView, Badge
- Implemented focus management capability and API

## 4.0.0

- Maintain new remote commands API and implement BottomSheet and Dialog commands
- Rework themes and move it from kernel to framework
- Implement action calls debounce and throttle
- Added Fragment widget
- Component merge with data refactor
- Added external event source binding to driver
- Optimized object-model tree handling up to 4x

## 3.6.0

- New widgets: Offstage, AbsorbPointer, AnimatedCrossFade, AnimatedSlide, PhysicalModel, AnimatedPhysicalModel, CustomScrollView, SliverPadding, SliverFillRemaining, SliverToBoxAdapter, SliverFillViewport, SliverOpacity, SliverVisibility, SliverAnimatedOpacity, SliverSafeArea, SliverOffstage, SliverIgnorePointer, SliverList, SliverAppBar, FlexibleSpaceBar and SliverGrid (+21)
- Improved providing of animated values
- Fixed ListView.separated separator behavior

## 3.5.0

- Added missing props for ElevatedButton attributes
- Passing Scaffold body property through widget child instead of attributes
- Fixed `onEnd` callback on implicitly animated widgets
- Added text decoration attributes to TextStyle
- New windgets: AnimatedAlign, AnimatedPositioned, AnimatedPadding, AnimatedRotation, AnimatedScale

## 3.4.0

- New widgets: AnimatedContainer, CarouselView, InkWell, Scaffold, AppBar, Card, GridView
- Flutter SDK minimum version increased

## 3.3.0

- WASM-compatible WebSocket transport
- New widgets: RemoteSubtree, SafeArea, IntrinsicWidth
- Custom widget controller auto-typecast
- Rebinding the controller after type casting
- Fixed attributes to object assigning

## 3.2.0

- BackdropFilter and AnimatedOpacity widgets
- Staggered animations support
- Driver shared mode
- Embedded components
- Improve connect response handling

## 3.1.0

- Improve library exports
- Added `customActionExecutor` property to `DuitDriver` consructors
- Added `customEventResolver` property to `DuitDriver` consructors
- Added `logger` property to `DuitDriver` consructors
- Added error logging and animation command handling for `ViewController`
- Removed related code for event handling and action execution from `DuitDriver`

## 3.0.0

- Migration to duit_kernel v3
- Removed deprecated features
- Removed DevMetrics feature (rework needed)
- Removed deprecated LayoutUpdate event handling
- Removed isolates support
- Improve library exports
- Update example app
- Action and events handling refactoring
- Re-exporting duit_kernel API as part of flutter_duit public API
- The Transform widget attribute type has been clarified

## 2.3.0

- Added RotatedBox widget
- Added error widget builder for DuitViewHost
- Fixed GestureDetector multiple events call when its not passed as attribute parameters
- Fixed Text widget unexpected behavior
- Fixed incorrect controllers creation/destruction, detach and disposing
- Fixed custom widgets subviews display

## 2.2.0

- IntrinsicHeight widget
- Improved data merging with component template
- ValueReference default value prop
- Custom decoders & encoders
- Fixes: Key creation
- Testing: setup test environment, added test for component, button, align and center widgets

## 2.1.0

- AttributeValueMapper import
- DuitDriver constructor with static content (json)
- AnimatedBuilder controller reuse
- Duit native module constructor (use duit as BDUI engine at native apps)
- Startup metrics
- New event type: Timer

## 2.0.1

- Fixed an issue with animations not working when using AnimatedBuilder inside components

## 2.0.0

- Migration to duit_kernel v2
- Added experimental implicit animation widget - AnimatedSize
- Added experimental support of animations via AnimatedBuilder

## 1.13.1

- Added ID property to attribute objects
- Added Keys for duit views based on ID

## 1.13.0

- Added RepaintBoundary widget
- Added OverflowBox widget
- Added DuitMetaData inherited widget

## 1.12.0

- Added ListView widget

## 1.11.0

- Added concurrent mode experimental feature

## 1.10.0

- Added Meta widget
- Added Subtree widget

## 1.9.1

- Fixed incorrect transmission of script metadata

## 1.9.0

- Added ScriptRunner API
- Added sequenced and common event groups
- Replaced text with empty data property using SizedBox.shrink

## 1.8.0

- Fixed unnecessary convert function call on num type
- FittedBox widget
- Switch widget
- Custom events

## 1.7.0

- Fixed a problem with duplicate ids of controlled widgets within the component
- Widget tree caching
- Added local executed actions
- Added SingleChildScrollView widget
- Added Radio and RadioGroupContext widgets
- Added Opacity widget
- Added IgnorePointer widget
- Added Slider widget

## 1.6.1

- Added a reference to the BuildContext in the navigation event handler

## 1.6.0

- Added components rendering
- Added LifecycleEventListener widget
- Added external event handling

## 1.5.0

- Added Text.rich widget
- Added Wrap widget
- Added gesture interceptor behaviors

## 1.4.0

- Added Transform and Align widgets
- Update documentation

## 1.3.0

- Added hooks to listen on driver events

## 1.2.1

- Switched dependencies from local package to package from pub.dev (duit_kernel)

## 1.2.0

- Added GestureDetector widget

## 1.1.0

- Added update layout event handling

## 1.0.0

- First release
