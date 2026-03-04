/// Represents the type of an image.
enum ImageType {
  /// The image is loaded from an asset.
  asset,

  /// The image is loaded from a network URL.
  network,

  /// The image is loaded from memory.
  memory;

  static ImageType fromString(String type) {
    return ImageType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => ImageType.network,
    );
  }
}
