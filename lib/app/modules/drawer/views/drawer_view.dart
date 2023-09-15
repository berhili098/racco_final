import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:racco_final/app/modules/home/controllers/home_controller.dart';
import 'package:racco_final/app/routes/app_pages.dart';

import '../../../../models/t_user.dart';
import '../../../data/services.dart';
import '../controllers/drawer_controller.dart' as drawer_controller;

class DrawerView extends GetView<drawer_controller.DrawerController> {
  final TUser user;
  const DrawerView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(1, 1.5),
                        end: Alignment(-0.94597145915031433, -0.8),
                        colors: [
                          Color.fromRGBO(89, 185, 255, 1),
                          Color.fromRGBO(97, 113, 186, 1)
                        ]),
                  ),
                  accountName: Text('${user.firstName} ${user.lastName}'),
                  accountEmail: Text(user.email!),
                  currentAccountPicture:
                      // backgroundColor: Colors.orange,
                      Image.network(
                          "https://cdn-icons-png.flaticon.com/512/1995/1995545.png",
                          width: 150.w,
                          height: 150.h)),
              ListTile(
                leading: const Icon(IconlyLight.profile),
                title: const Text("Client Affecter"),
                onTap: () {},
              ),
              GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return ListTile(
                      leading: const Icon(IconlyLight.user),
                      title: const Text("Client Sav Affecter"),
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.CLIENT_LIST,
                            arguments: controller.tickets,
                            parameters: {"pageType": "sav"});
                      },
                    );
                  }),
              ListTile(
                leading: const Icon(IconlyLight.calendar),
                title: const Text("Client planifier"),
                onTap: () {},
              ),
              GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return ListTile(
                      leading: const Icon(IconlyBold.calendar),
                      title: const Text("Client Sav planifier"),
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.PLANNED_CLIENTS,
                          arguments: controller.plannedTickets,
                        );
                      },
                    );
                  }),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Historique"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(IconlyLight.logout, color: Colors.red),
                title: const Text("Déconnecter",
                    style: TextStyle(color: Colors.red)),
                onTap: () async {
                  logout();
                },
              ),
            ],
          ),
          GetBuilder<drawer_controller.DrawerController>(
              init: drawer_controller.DrawerController(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'version ${controller.version}',
                    style: const TextStyle(color: Colors.black38),
                  ),
                );
              })
        ],
      ),
    );
  }
}
