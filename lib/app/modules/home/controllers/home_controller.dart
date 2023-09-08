import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:racco_final/app/data/services.dart';
import 'package:racco_final/models/t_user.dart';

class HomeController extends GetxController {
  TUser? user;
  bool loading = false;

  @override
  void onInit() {
    super.onInit();
    loading = true;
    update();
    getUserFromMemory().then((value)async {
      user = value; 
      loading = false;
      update();
    });
  }
}
