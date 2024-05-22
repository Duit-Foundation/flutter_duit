/// A class for extending attribute classes.
///
/// Adds the necessary properties for correct
/// handling of attribute changes during animation
base class AnimatedPropertyOwner<T> {
  /// A set of property names that should be animated.
  final Set<String>? affectedProperties;

  /// ID of parent builder instance
  ///
  /// This property allows you to avoid reading animated attributes
  /// if the view refers to an incorrect inherited widget in the widget tree
  final String? parentBuilderId;

  const AnimatedPropertyOwner({
    required this.parentBuilderId,
    required this.affectedProperties,
  });
}
