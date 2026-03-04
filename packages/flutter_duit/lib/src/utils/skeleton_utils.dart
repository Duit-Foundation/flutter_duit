import "package:duit_kernel/duit_kernel.dart";
import "package:flutter/material.dart";

/// Abstract builder for custom skeleton placeholders used by [DuitSkeletonBox].
///
/// Extend this class to provide custom loading/skeleton UI
/// while content is being fetched. The builder receives the skeleton [type] from
/// the Duit payload and a [source] to read additional attributes.
///
/// ## **Usage:**
///
/// ### 1. Define an enum for skeleton variants and register it with [DuitRegistry]:
///
/// ```dart
/// enum SkeletonType { box, circle }
///
/// DuitRegistry.registerCustomEnumFactory<SkeletonType>((value) {
///   return switch (value) {
///     "box" => SkeletonType.box,
///     "circle" => SkeletonType.circle,
///     _ => throw ArgumentError("Invalid skeleton type: $value"),
///   };
/// });
/// ```
///
/// ### 2. Implement the builder:
///
/// ```dart
/// final class SkeletonBuilder extends CustomSkeletonBuilder<SkeletonType> {
///   const SkeletonBuilder();
///
///   @override
///   Widget build(SkeletonType type, DuitDataSource source) {
///     return switch (type) {
///       SkeletonType.box => _SkeletonBox(
///         size: Size(
///           source.tryGetDouble(key: "width") ?? 0,
///           source.tryGetDouble(key: "height") ?? 0,
///         ),
///       ),
///       SkeletonType.circle => _SkeletonBox(
///         size: Size.square(source.getDouble(key: "dimension")),
///       ),
///     };
///   }
/// }
/// ```
///
/// ### 3. Pass the builder to [DuitViewHost]:
///
/// ```dart
/// DuitViewHost.withDriver(
///   driver: driver,
///   customSkeletonBuilder: const SkeletonBuilder(),
/// )
/// ```
///
/// ### 4. Use [DuitSkeletonBox] in your layout with attributes:
///
/// ```json
/// {
///   "type": "SkeletonBox",
///   "id": "skeleton_header",
///   "attributes": {"width": 300, "height": 40, "type": "box"}
/// }
/// ```
///
/// [DuitSkeletonBox] obtains the builder via [DuitViewContext] and invokes
/// [build] with the parsed enum and payload. If no custom builder is set,
/// it falls back to a default Flutter [Placeholder].
abstract class CustomSkeletonBuilder<T extends Enum> {
  /// The [Type] of [T], used by [DuitSkeletonBox] to deserialize enum from payload.
  @preferInline
  Type get underlayingTypeArgument => T;

  const CustomSkeletonBuilder();

  /// Builds a skeleton widget for the given [type] using [source] for extra attributes.
  Widget build(T type, DuitDataSource source);
}
