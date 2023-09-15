import 'dart:io';

import 'package:get/get.dart';
import 'package:racco_final/app/data/network.dart';
import 'package:racco_final/app/data/services.dart';
import 'package:racco_final/app/data/vars.dart';
import 'package:racco_final/models/affectation.dart';
import 'package:http/http.dart' as http;
import 'package:racco_final/models/t_user.dart';

import '../../../data/widgets/date_picker_widget.dart';
import '../../../routes/app_pages.dart';
import '../../clientList/controllers/client_list_controller.dart';
import '../../home/controllers/home_controller.dart';

class AffectationController extends GetxController {
  //TODO: Implement AffectationController
  List<Affectations> affectationList = [];
  bool loading = true;
  TUser? user;

  DateTime planifiedDate = DateTime.now();

  Future planifierAffectations(
      String id, DateTime datePlanification, String technicienId) async {
    return http.post(Uri.parse('$baseUrl/planifierAffectation'),
        headers: await Network.headers(),
        body: {
          'id': id,
          'planification_date': datePlanification.toString(),
          'technicien_id': technicienId
        });
  }

  Future<void> planificationAffectation(context, String id, String technicienId,
      {bool callNotify = false}) async {
    loading = false;
    print('no');
    try {
      loading = true;
      update();
      var response =
          await planifierAffectations(id, planifiedDate, technicienId);
      switch (response.statusCode) {
        case 200:
          Get.snackbar("Succès", "Planifié avec succès",
              colorText: Colors.white, backgroundColor: Colors.green);
          Get.delete<ClientListController>();
          Get.delete<HomeController>();
          Get.delete<AffectationController>();
          Get.toNamed(Routes.HOME);
          break;
        case 409:
          Get.snackbar(
              "Erreur", "Vous avez dépassé la limite de planification.",
              colorText: Colors.white, backgroundColor: Colors.red);

          break;
        default:
          Get.snackbar(
              'Erreur', "Vous avez dépassé la limite de planification.",
              colorText: Colors.white, backgroundColor: Colors.red);

          break;
      }
    } on SocketException {
      update();
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    return;
  }

  @override
  void onInit() {
    getUserFromMemory().then((value) {
      user = value;
      update();
    });
    affectationList = Get.arguments;
    super.onInit();
  }
}
