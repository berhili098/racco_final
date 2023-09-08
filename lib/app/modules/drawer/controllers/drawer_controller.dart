import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DrawerController extends GetxController {
  //TODO: Implement DrawerController

  String version = "";
  String nbBuild = "";
  Future<void> getInfoApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = '${packageInfo.version} + ${packageInfo.buildNumber}';

    nbBuild = packageInfo.buildNumber.toString();

    update();
  }

  @override
  void onInit() {
    getInfoApp();
    super.onInit();
  }
}
