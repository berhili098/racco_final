import 'dart:convert';

import 'package:get/get.dart';
import 'package:racco_final/app/data/vars.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;
import 'package:racco_final/models/t_user.dart';

import '../../../../models/affectation.dart';
import '../../../data/network.dart';
import '../../../routes/app_pages.dart';
import '../../affectation/controllers/affectation_controller.dart';
import '../../home/controllers/home_controller.dart';

class BlocageRaccoController extends GetxController {
  final count = 0.obs;
  TextEditingController blocageType = TextEditingController();
  TextEditingController justif = TextEditingController();
  Uint8List image = Uint8List(0);
  Uint8List imageBlocage = Uint8List(0);
  Uint8List imageSchema = Uint8List(0);
  double lng = 0, lat = 0;
  bool loading = false;
  TUser? user;
  Affectations? affectation;

  returnFirstTitle() {
    switch (blocageType.text) {
      case 'Adresse erronée déployée':
        return 'Choisir une image d\'Elect';
      case 'Adresse erronée non déployée':
        return 'Choisir une image d\'Elect';
      case 'Blocage de passage coté appartement':
        return 'Choisir une image de blocage';
      case 'Blocage de passage coté magasin':
        return 'Choisir une image de blocage';
      case 'Blocage de passage coté villa':
        return 'Choisir une image de blocage';
      case 'Blocage coté Syndic':
        return 'no';
      case 'Client a annulé sa demande':
        return 'Importer un screen d\'appelle';
      case 'Contact Erronee':
        return 'Importer un screen d\'appelle';
      case 'Demande en double':
        return 'Importer un screen d\'appelle';
      case 'Hors Plaque':
        return 'no';
      case 'Indisponible':
        return 'Importer un screen d\'appelle';
      case 'Injoignable/SMS':
        return 'Importer un screen d\'appelle';
      case 'Manque ID':
        return 'no';
      case 'Câble transport dégradés':
        return 'Choisir une image de facade:';
      case 'Manque Cable transport':
        return 'Choisir une image de facade:';
      case 'Gpon saturé':
        return 'Choisir une photo de splitter:';
      case 'Non Eligible':
        return 'Choisir une image d\'Elect';
      case 'Cabel transport saturé':
        return 'Choisir une photo de transport:';
      case 'Splitter saturé':
        return 'Choisir une photo de splitter:';
      case 'Pas Signal':
        return 'Choisir une photo de splitter:';
      case 'Probléme de verticalite':
        return 'Choisir une image de schema';
      case 'Besoin BDC':
        return 'no';
      case 'Besoin Swan':
        return 'no';
      case 'Besoin jarretière':
        return 'no';
      case 'Probléme de verticalité':
        return 'Choisir une image de schema';
      default:
        return 'no';
    }
  }

  returnSecondTitle() {
    switch (blocageType.text) {
      case 'Adresse erronée déployée':
        return 'Choisir une image de facade:';
      case 'Adresse erronée non déployée':
        return 'Choisir une image de facade:';
      case 'Blocage de passage coté appartement':
        return 'Choisir une image de schema';
      case 'Blocage de passage coté magasin':
        return 'Choisir une image de schema';
      case 'Blocage de passage coté villa':
        return 'Choisir une image de schema';
      case 'Blocage coté Syndic':
        return 'no';
      case 'Client a annulé sa demande':
        return 'no';
      case 'Contact Erronee':
        return 'no';
      case 'Demande en double':
        return 'no';
      case 'Hors Plaque':
        return 'no';
      case 'Indisponible':
        return 'no';
      case 'Injoignable/SMS':
        return 'Importer une  screen de SMS';

      case 'Manque ID':
        return 'no';
      case 'Câble transport dégradés':
        return 'Choisir une image de blocage';
      case 'Manque Cable transport':
        return 'Choisir une image de blocage';
      case 'Gpon saturé':
        return 'Choisir une photo GPON saturee:';
      case 'Non Eligible':
        return 'Choisir une image de facade:';
      case 'Cabel transport saturé':
        return 'Choisir une image de transport:';
      case 'Splitter saturé':
        return 'Choisir une photo de chambre:';
      case 'Pas Signal':
        return 'Choisir une photo de chambre:';
      case 'Probléme de verticalite':
        return 'Choisir une image de blocage';
      case 'Besoin BDC':
        return 'no';
      case 'Besoin Swan':
        return 'no';
      case 'Besoin jarretière':
        return 'no';
      case 'Probléme de verticalité':
        return 'Choisir une image de blocage';
      default:
        return 'no';
    }
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

  validate() async {
    if (blocageType.text.isEmpty) {
      Get.snackbar('Erreur', "Veuillez Choisir le blocage..",
          backgroundColor: Colors.red, colorText: Colors.white);

      return false;
    } else if (imageBlocage.isEmpty && returnFirstTitle() != 'no') {
      Get.snackbar('Erreur', "Veuillez Remplir l'image 1.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (justif.text.trim().isEmpty) {
      Get.snackbar('Erreur', "Veuillez remplir la justification..",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (imageSchema.isEmpty && returnSecondTitle() != 'no') {
      Get.snackbar('Erreur', "Veuillez Remplir l'image Schema.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else {
      return true;
    }
  }

  Future updateDeclarationSav(Object data) async {
    try {
      return await http.post(Uri.parse('$baseUrl/addBlocageRacco'),
          headers: await Network.headers(), body: data);
    } catch (e) {
      return null;
    }
  }

  submit() {
    validate().then((val) async {
      if (val) {
        loading = true;
        update();
        String imageFacFinal = base64Encode(imageBlocage);
        String imagesh = base64Encode(imageSchema);

        await updateDeclarationSav({
          'affectation_id': affectation!.id.toString(),
          'cause': blocageType.text,
          'justification': justif.text,
          'lng': lng.toString(),
          'lat': lat.toString(),
          'image': imageFacFinal,
          'image_data': imagesh
        }).then((value) {
          loading = false;
          update();
          if (value != null && value.statusCode == 200) {
            Get.delete<HomeController>();
            Get.delete<BlocageRaccoController>();
            Get.delete<AffectationController>();
            Get.offAndToNamed(Routes.HOME);
          } else {
            print(value.body);
            print(value.statusCode);
            Get.snackbar('Erreur', "Contactez le support");
          }
        });
      } else {}
    });
  }

  @override
  void onInit() {
    user = Get.arguments[1];
    affectation = Get.arguments[0];
    super.onInit();
  }
}
