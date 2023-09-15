import 'dart:convert';

import 'package:get/get.dart';
import 'package:racco_final/app/data/network.dart';
import 'package:racco_final/app/modules/home/controllers/home_controller.dart';
import 'package:racco_final/app/routes/app_pages.dart';
import 'package:racco_final/models/sav_ticket.dart';
import 'package:http/http.dart' as http;

import '../../../data/vars.dart';
import '../../../data/widgets/date_picker_widget.dart';

class PlannedClientsController extends GetxController {
  //TODO: Implement PlannedClientsController

  String pageType = "racco";
  List<SavTicket> savList = [];
  DateTime planifiedDate = DateTime.now();

  Future planifierTicket(SavTicket savTicket) async {
    await http.post(
      Uri.parse('$baseUrl/addPlanned'),
      headers: await Network.headers(),
      body: {
        'sav_ticket_id': savTicket.id.toString(),
        'planification_date': planifiedDate.toString()
      },
    ).then((response) async {
      switch (response.statusCode) {
        case 200:
          Get.snackbar("Succès", "Planifié avec succès",
              colorText: Colors.white, backgroundColor: Colors.green);
          Get.delete<PlannedClientsController>();
          Get.delete<HomeController>();
          Get.toNamed(Routes.HOME);
          break;
        case 401:
          Get.snackbar("Erreur", jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);

          break;
        default:
          Get.snackbar('Erreur', jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);

          break;
      }
    }).catchError((error) {
      throw error;
    });
  }

  @override
  void onInit() {
     
    savList = Get.arguments ?? [];
    update();
    super.onInit();
  }
}
