import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:racco_final/app/data/widgets/client_sav_modal_widget.dart';

import '../../../data/widgets/app_bar_widget.dart';
import '../../../data/widgets/sav_ticket_widget.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/planned_clients_controller.dart';

class PlannedClientsView extends GetView<PlannedClientsController> {
  const PlannedClientsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          title: "Liste des clients SAV  planifiés",
          show: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            separatorBuilder: (context, index) => 10.verticalSpace,
            itemCount: controller.savList.length,
            itemBuilder: (context, index) {
              return GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (cont) {
                    return SavTicketItem(
                      affectation: controller.savList[index],
                      showInfoIcon: true,
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0))),
                            context: context,
                            builder: (context) {
                              return ClientSavInfoModalWidget(
                                user: cont.user!,
                                withPlanification: false,
                                affectation: controller.savList[index],
                              );
                            }).whenComplete(() {});
                      },
                    );
                  });
            },
          ),
        ));
  }
}
