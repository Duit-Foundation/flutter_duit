import 'package:duit_kernel/duit_kernel.dart';

// extension DetachExtension<T> on UIElementController<T> {
//   void detach() {
//     driver.detachController(id);
//   }
// }

extension type DetachableController(UIElementController controller) implements UIElementController {
  void detach() {
    controller.driver.detachController(controller.id);
  }
}
