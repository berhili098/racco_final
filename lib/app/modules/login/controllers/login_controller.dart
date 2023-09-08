import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:racco_final/app/data/network.dart';
import 'package:racco_final/app/data/services.dart';
import 'package:racco_final/app/data/vars.dart';
import 'package:racco_final/app/routes/app_pages.dart';
import 'package:racco_final/models/t_user.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool visibility = true.obs;
  bool isPassword = true;
  RxBool loading = false.obs;
  Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@neweracom.ma',
  );

  validate() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar('Erreur', 'Veuillez vérifier votre connexion internet',
          colorText: Colors.white, backgroundColor: Colors.red[700]);
    } else if (emailController.text.trim().isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer votre adresse e-mail',
          colorText: Colors.white, backgroundColor: Colors.red[700]);
      return false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Erreur', 'Veuillez entrer une adresse e-mail valide',
          colorText: Colors.white, backgroundColor: Colors.red[700]);
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer votre mot de passe',
          colorText: Colors.white, backgroundColor: Colors.red[700]);
      return false;
    } else {
      return true;
    }
  }

  submit() async {
    validate().then((value) async {
      if (value) {
        loading.toggle();
        update();

        login().then((value) {
          loading.value = false;
          update();
        });
      }
    });
  }

  Future login() async {
    String deviceKey = await getDeviceIdentifier();
    String buildNumber = await getBuild() ?? '0';
    await http.post(
      Uri.parse('$baseUrl/newLoginApi'),
      headers: await Network.headers(),
      body: {
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'device_key': deviceKey,
        'build_number': buildNumber
      },
    ).then((response) async { 
      loading.value = true;
      update();
      switch (response.statusCode) {
        case 200:
          TUser user = TUser.fromJson(jsonDecode(response.body)['user']);

          await saveUserToSession(user);
          await SessionManager().set('isLoggedIn', true);

          Get.offAllNamed(
            Routes.HOME,
          );
          loading.value = false;
          update();

          break;
        case 401:
          Get.snackbar("Erreur", jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loading.value = false;
          update();
          break;
        default:
          Get.snackbar('Erreur', jsonDecode(response.body)['message'],
              colorText: Colors.white, backgroundColor: Colors.red);
          loading.value = false;
          update();
          break;
      }
    }).catchError((error) {
      loading.value = false;
      update();
      throw error;
    });
  }
}
