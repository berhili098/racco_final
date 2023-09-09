import 'package:get/get.dart';

import '../data/services.dart';
import '../modules/clientList/bindings/client_list_binding.dart';
import '../modules/clientList/views/client_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var INITIAL = initRoute();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    // GetPage(
    //   name: _Paths.DRAWER,
    //   page: () => const DrawerView(),
    //   binding: DrawerBinding(),
    // ),
    GetPage(
      name: _Paths.CLIENT_LIST,
      page: () => const ClientListView(),
      binding: ClientListBinding(),
    ),
  ];
}
