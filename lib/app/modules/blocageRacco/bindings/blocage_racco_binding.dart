import 'package:get/get.dart';

import '../controllers/blocage_racco_controller.dart';

class BlocageRaccoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlocageRaccoController>(
      () => BlocageRaccoController(),
    );
  }
}
