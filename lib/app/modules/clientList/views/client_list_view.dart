import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:racco_final/app/data/widgets/app_bar_widget.dart';
import 'package:racco_final/app/data/widgets/sav_ticket_widget.dart';
import 'package:racco_final/models/sav_ticket.dart';

import '../controllers/client_list_controller.dart';

class ClientListView extends GetView<ClientListController> {
  const ClientListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title:
              "Liste des clients ${controller.pageType == "sav" ? "Sav" : "Racco"}",
          show: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            separatorBuilder: (context, index) => 10.verticalSpace,
            itemCount: controller.savList.length,
            itemBuilder: (context, index) {
              return SavTicketItem(
                affectation: SavTicket(
                    id: 1,
                    client: controller.savList[index].client,
                    description: "Description",
                    status: "En cours",
                    type: "Sav"),
                showInfoIcon: true,
                onTap: () {},
              );
            },
          ),
        ));
  }
}
