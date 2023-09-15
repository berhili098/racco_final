import 'package:get/get.dart';

import '../controllers/planned_clients_controller.dart';

class PlannedClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlannedClientsController>(
      () => PlannedClientsController(),
    );
  }
}
