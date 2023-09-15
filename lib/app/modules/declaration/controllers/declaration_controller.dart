import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:racco_final/app/data/vars.dart';
import 'package:http/http.dart' as http;
import 'package:racco_final/app/modules/clientList/controllers/client_list_controller.dart';
import 'package:racco_final/app/modules/home/controllers/home_controller.dart';
import 'package:racco_final/app/routes/app_pages.dart';
import 'package:racco_final/models/sav_ticket.dart';
import 'package:racco_final/models/t_user.dart';
import 'dart:typed_data';

class DeclarationController extends GetxController {
  //TODO: Implement DeclarationController
  TUser? user;
  SavTicket? savTicket;
  Uint8List image = Uint8List(0);
  Uint8List imageTestSignal = Uint8List(0);
  Uint8List imageBlockage = Uint8List(0);
  bool loading = false;
  TextEditingController descriptionController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    user = Get.arguments[1];
    savTicket = Get.arguments[0];
    update();
    super.onInit();
  }

  validate() async {
    if (imageTestSignal.isEmpty) {
      Get.snackbar('Erreur', "Veuillez Remplir l'image Test Signal.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (descriptionController.text.isEmpty) {
      Get.snackbar('Erreur', "Veuillez Choisir la solution..",
          backgroundColor: Colors.red, colorText: Colors.white);

      return false;
    } else {
      return true;
    }
  }

  Future updateDeclarationSav(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.parse('$baseUrl/addFeedback');
    try {
      var response = await http.post(uri, headers: headers, body: data);
      Get.snackbar('Message', response.body.toString().replaceAll("\"", ""),
          colorText: Colors.white, backgroundColor: Colors.amber);
      return true;
    } catch (e) {
      return false;
    }
  }

  submit() {
    validate().then((val) async {
      if (val) {
        loading = true;
        update();
        String finalImage = base64Encode(imageTestSignal);
        String imageFacFinal = base64Encode(imageBlockage);

        await updateDeclarationSav({
          "description": descriptionController.text,
          "test_signal": finalImage,
          "sav_ticket_id": savTicket!.id.toString(),
          "image_facultatif": imageFacFinal
        }).then((value) {
          loading = false;
          update();
          if (value) {
            Get.delete<HomeController>();
            Get.delete<DeclarationController>();
            Get.delete<ClientListController>();
            Get.offAndToNamed(Routes.HOME);
          } else {}
        });
      } else {}
    });
  }

  changeImage(
      VoidCallback func1, VoidCallback func2, VoidCallback func3, context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        title: Text('Changer la photo',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: primaryColor,
              fontFamily: 'cairo',
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            )),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              InkWell(
                onTap: () async {
                  Get.back();
                  func1();
                  update();
                },
                child: Row(
                  children: [
                    Icon(
                      IconlyBroken.camera,
                      color: primaryColor,
                      size: 26.h,
                    ),
                    14.horizontalSpace,
                    Text('Prendre une photo',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'cairo',
                          fontSize: 14.sp,
                        )),
                  ],
                ),
              ),
              9.verticalSpace,
              InkWell(
                onTap: () async {
                  Get.back();
                  func2();
                  update();
                },
                child: Row(
                  children: [
                    Icon(
                      IconlyBroken.image,
                      color: primaryColor,
                      size: 26.h,
                    ),
                    14.horizontalSpace,
                    Text(
                      'Choisir une photo',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'cairo',
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              9.verticalSpace,
              InkWell(
                onTap: () {
                  Get.back();
                  func3();
                },
                child: Row(
                  children: [
                    Icon(
                      IconlyBroken.delete,
                      color: const Color(0xffD16868),
                      size: 26.h,
                    ),
                    14.horizontalSpace,
                    Text('Supprimer la photo',
                        style: TextStyle(
                          color: const Color(0xffD16868),
                          fontFamily: 'cairo',
                          fontSize: 14.sp,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
