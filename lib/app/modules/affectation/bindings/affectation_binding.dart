import 'package:get/get.dart';

import '../controllers/affectation_controller.dart';

class AffectationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AffectationController>(
      () => AffectationController(),
    );
  }
}
