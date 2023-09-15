import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/widgets/app_bar_widget.dart';
import '../../../data/widgets/notification_widget.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          title: "Vos notifications",
          show: true,
        ),
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.separated(
                  separatorBuilder: (context, index) => 10.verticalSpace,
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    return GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (cont) {
                          return NotificationItemWidget(
                            notification: controller.notifications[index],
                          );
                        });
                  },
                ),
              );
            }));
  }
}
