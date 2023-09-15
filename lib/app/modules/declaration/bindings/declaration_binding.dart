import 'package:get/get.dart';

import '../controllers/declaration_controller.dart';

class DeclarationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeclarationController>(
      () => DeclarationController(),
    );
  }
}
