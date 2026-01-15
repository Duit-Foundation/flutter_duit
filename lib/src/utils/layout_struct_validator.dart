import "package:duit_kernel/duit_kernel.dart";

sealed class LayoutStructValidator {
  @preferInline
  static bool isValidViewStruct(Map<String, dynamic> json) {
    switch (json) {
      case {
          "type": String _,
          "id": String _,
        }:
      case {
          "root": Map<String, dynamic> _,
        }:
      case {
          "widgets": Map _,
        }:
        return true;
      default:
        return false;
    }
  }

  @preferInline
  static bool isWidgetStruct(Map<String, dynamic> json) {
    if (json
        case {
          "type": String _,
          "id": String _,
        }) {
      return true;
    }
    return false;
  }

  @preferInline
  static bool isRootStruct(Map<String, dynamic> json) {
    if (json
        case {
          "root": Map<String, dynamic> _,
        }) {
      return true;
    }
    return false;
  }

  @preferInline
  static bool isWidgetsStruct(Map<String, dynamic> json) {
    if (json
        case {
          "widgets": Map<String, dynamic> _,
        }) {
      return true;
    }
    return false;
  }
}
