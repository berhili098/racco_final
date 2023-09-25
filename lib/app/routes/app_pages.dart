import 'package:get/get.dart';

import '../data/services.dart';
import '../modules/affectation/bindings/affectation_binding.dart';
import '../modules/affectation/views/affectation_view.dart';
import '../modules/blocage/bindings/blocage_binding.dart';
import '../modules/blocage/views/blocage_view.dart';
import '../modules/blocageRacco/bindings/blocage_racco_binding.dart';
import '../modules/blocageRacco/views/blocage_racco_view.dart';
import '../modules/clientList/bindings/client_list_binding.dart';
import '../modules/clientList/views/client_list_view.dart';
import '../modules/declaration/bindings/declaration_binding.dart';
import '../modules/declaration/views/declaration_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart'; 
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/plannedClients/bindings/planned_clients_binding.dart';
import '../modules/plannedClients/views/planned_clients_view.dart';

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
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.DECLARATION,
      page: () => const DeclarationView(),
      binding: DeclarationBinding(),
    ),
    GetPage(
      name: _Paths.BLOCAGE,
      page: () => const BlocageView(),
      binding: BlocageBinding(),
    ),
    GetPage(
      name: _Paths.PLANNED_CLIENTS,
      page: () => const PlannedClientsView(),
      binding: PlannedClientsBinding(),
    ),
    GetPage(
      name: _Paths.AFFECTATION,
      page: () => const AffectationView(),
      binding: AffectationBinding(),
    ),
    GetPage(
      name: _Paths.BLOCAGE_RACCO,
      page: () => const BlocageRaccoView(),
      binding: BlocageRaccoBinding(),
    ),
    
  ];
}
