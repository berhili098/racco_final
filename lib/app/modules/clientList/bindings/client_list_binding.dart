import 'package:get/get.dart';

import '../controllers/client_list_controller.dart';

class ClientListBinding extends Bindings {
  @override
  void dependencies() { 
    Get.lazyPut<ClientListController>(
      () => ClientListController(),
    );
  }
}
