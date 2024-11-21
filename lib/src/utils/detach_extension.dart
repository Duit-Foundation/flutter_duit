import 'package:duit_kernel/duit_kernel.dart';

extension type DetachableController(UIElementController controller) implements UIElementController {
  void detach() {
    controller.driver.detachController(controller.id);
  }
}
