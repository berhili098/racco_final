import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:racco_final/app/data/widgets/affectation_item.dart';
import 'package:racco_final/app/data/widgets/client_info_modal.dart';

import '../../../data/widgets/app_bar_widget.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/affectation_controller.dart';

class AffectationView extends GetView<AffectationController> {
  const AffectationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          title: "Liste des clients ",
          show: true,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView.separated(
            separatorBuilder: (context, index) => 10.verticalSpace,
            itemCount: controller.affectationList.length,
            itemBuilder: (context, index) {
              return GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (cont) {
                    return AffectationItem(
                      affectation: controller.affectationList[index],
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
                              return ClientInfoModalWidget(
                                user: cont.user!,
                                withPlanification: false,
                                affectation: controller.affectationList[index],
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
