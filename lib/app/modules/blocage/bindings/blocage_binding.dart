import 'package:get/get.dart';

import '../controllers/blocage_controller.dart';

class BlocageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlocageController>(
      () => BlocageController(),
    );
  }
}
