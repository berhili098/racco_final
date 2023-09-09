import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:racco_final/app/data/network.dart';
import 'package:racco_final/app/data/vars.dart';
import 'package:racco_final/app/routes/app_pages.dart';
import 'package:racco_final/models/t_user.dart';
import 'package:http/http.dart' as http;

initRoute() async {
  bool loggedIn = await SessionManager().get('isLoggedIn') ?? false;
  if (loggedIn) {
    TUser user = await getUserFromMemory();
    await resaveUserToSessionFromBd(user);
    return Routes.HOME;
  } else {
    return Routes.LOGIN;
  }
}

Future<TUser> getUserFromMemory() async {
  return TUser.fromJson(await SessionManager().get('user') ?? {});
}

saveUserToSession(TUser user) async {
  if (user.id != null) {
    await SessionManager().set('user', user);
  }
}

resaveUserToSessionFromBd(TUser user) async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none &&
      user.id != null &&
      user.id != 0) {
    await getUserFromBd().then((value) {
      saveUserToSession(value);
    });
  }
}

Future<TUser> getUserFromBd() async {
  TUser user = await getUserFromMemory(); 
  http.Response response;

  try {
    response = await http.get(
      Uri.parse('$baseUrl/getCurrentUser/${user.id}'),
      headers: await Network.headers(),
    );
  } catch (e) {
    // Handle the error here, e.g., log or throw an exception
    // throw Exception('Failed to fetch user: $e');
    return TUser();
  }

  if (response.statusCode == 200) {
    TUser returnedUser = TUser.fromJson(jsonDecode(response.body)['user']);
    return returnedUser;
  } else {
    // Handle unexpected status codes
    return TUser();
  }
}

Future<String> getDeviceIdentifier() async {
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceIdentifier = iosInfo.identifierForVendor ?? '';
  }
  return deviceIdentifier;
}

handlerPermission() async {
  var permission = await Permission.sensors.status;
  if (permission.isDenied) {
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.storage.request();
    // await Permission.locationAlways.request();
  }
  if (permission.isRestricted) {
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.storage.request();
    // await Permission.locationAlways.request();
  }
  if (permission.isPermanentlyDenied) {
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.storage.request();
    // await Permission.locationAlways.request();
  }
  if (permission.isLimited) {
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.storage.request();
    // await Permission.locationAlways.request();
  }
}

Future<void> initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Debug.setAlertLevel(OSLogLevel.none);
  OneSignal.initialize("9d7161b3-0c5e-4dd0-93fa-67e6b57fe2dd");
  OneSignal.User.pushSubscription.addObserver((state) async {});
  OneSignal.Notifications.addPermissionObserver((state) {
    print("Has permission $state");
  });
  OneSignal.Notifications.addClickListener((event) {
    print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
  });

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    print(
        'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');
    event.preventDefault();
    event.notification.display();
  });
}

getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  return '${packageInfo.version} + ${packageInfo.buildNumber}';
}

getBuild() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  return packageInfo.buildNumber;
}

logoutApi() async {
  TUser user = await getUserFromMemory();
  return await http.post(
    Uri.parse('$baseUrl/logoutApi/${user.id}'),
    headers: await Network.headers(),
  );
}

logout() async {
  Get.defaultDialog(
    title: "Vous êtes sûr ?",
    titlePadding: EdgeInsets.all(33.w),
    titleStyle: TextStyle(
      fontSize: 20.sp,
      color: primaryColor,
    ),
    middleText: "Vous allez être déconnecté ",
    middleTextStyle: TextStyle(
      fontSize: 16.sp,
      color: Colors.black,
    ),
    textConfirm: 'Oui',
    textCancel: 'Non',
    confirmTextColor: Colors.white,
    cancelTextColor: primaryColor,
    buttonColor: primaryColor,
    onConfirm: () async {
      await logoutApi().then((response) async {
        Get.snackbar(
          "Déconnexion",
          jsonDecode(response.body)['message'],
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      });
      await SessionManager().destroy();
      Get.offAllNamed(Routes.LOGIN);
    },
  );
}
