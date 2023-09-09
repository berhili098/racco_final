import 'package:get/get.dart';
import 'package:racco_final/models/sav_ticket.dart';

class ClientListController extends GetxController {
  //TODO: Implement ClientListController

  String pageType = "racco";
  List<SavTicket> savList = [];
  @override
  void onInit() {
    pageType = Get.parameters['pageType'] ?? "racco";
    savList = Get.arguments ?? [];
    update();
    super.onInit();
  }
}
