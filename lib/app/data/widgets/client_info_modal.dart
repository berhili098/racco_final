import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:racco_final/app/data/widgets/affectation_item.dart';
import 'package:racco_final/app/data/widgets/icon_button_widget.dart';
import 'package:racco_final/app/modules/affectation/controllers/affectation_controller.dart';
import 'package:racco_final/app/routes/app_pages.dart';
import 'package:racco_final/models/affectation.dart';
import 'package:racco_final/models/t_user.dart';

import '../services.dart';
import 'date_picker_widget.dart';
import 'icon_widget.dart';

class ClientInfoModalWidget extends StatelessWidget {
  final Affectations affectation;
  final TUser user;

  final bool withPlanification;

  const ClientInfoModalWidget(
      {super.key,
      required this.user,
      required this.affectation,
      required this.withPlanification});

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    DateTime date = DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * .95,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
              offset: Offset(0, 0),
              blurRadius: 15)
        ],
        color: Color.fromRGBO(240, 240, 240, 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            10.verticalSpace,
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Client",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 23.sp),
                    ),
                    10.verticalSpace,
                    Container(
                      height: 1.h,
                      color: Colors.grey.shade300,
                    ),
                    10.verticalSpace,
                    AffectationItem(
                      affectation: affectation,
                      showInfoIcon: false,
                    ),
                    Container(
                      height: 1.h,
                      color: Colors.grey.shade300,
                    ),
                    Column(
                      children: [
                        20.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Type d'installation",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21.sp),
                                ),
                                Text('${affectation.client!.offre}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Type de routeur",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21.sp),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${affectation.client!.routeurType}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.sp,
                                        )),
                                    Text(
                                      ' ( ${affectation.client!.debit} MB )',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red,
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        12.verticalSpace,
                        Text(
                          "Numéro de télephone",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.sp),
                        ),
                        7.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(affectation.client!.phoneNo ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.sp,
                                )),
                            10.horizontalSpace,
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const IconCercleWidgt(
                                icon: Icons.copy_all_outlined,
                                size: 50,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text: affectation.client!.phoneNo))
                                    .then((_) {
                                  Get.snackbar('success', 'Copie avec success');
                                });

                                // final Uri telLaunchUri = Uri(
                                //   scheme: 'tel',
                                //   path: affectation.client!.phoneNo ?? '',
                                // );

                                // launchUrl(telLaunchUri);
                              },
                            ),
                          ],
                        ),
                        25.verticalSpace,
                        Text(
                          "Adresse",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.sp),
                        ),
                        7.verticalSpace,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SelectableText(
                                    affectation.client!.address ?? '',
                                    textAlign: TextAlign.center,
                                    toolbarOptions: const ToolbarOptions(
                                      copy: true,
                                      selectAll: true,
                                    ),
                                    showCursor: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          "Position GPS",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.sp),
                        ),
                        7.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${affectation.client!.lat ?? ''},${affectation.client!.lng ?? ''}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.sp,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const IconCercleWidgt(
                                icon: Icons.copy_all_outlined,
                                size: 50,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text:
                                            '${affectation.client!.lat ?? ''},${affectation.client!.lng ?? ''}'))
                                    .then((_) {});
                                Get.snackbar('success', 'Copie avec success');

                                // final Uri telLaunchUri = Uri(
                                //   scheme: 'tel',
                                //   path: affectation.client!.phoneNo ?? '',
                                // );

                                // launchUrl(telLaunchUri);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0.w, horizontal: 10.0.h),
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: affectation.status == "Terminé"
                    //         ? [
                    //             Expanded(
                    //               child: Visibility(
                    //                 visible: affectation.status == "Terminé",
                    //                 child: IconBottonWidget(
                    //                   icon: IconlyLight.edit,
                    //                   text: "Modifier la déclaration",
                    //                   onTap: () {},
                    //                 ),
                    //               ),
                    //             ),
                    //             Expanded(
                    //               child: Visibility(
                    //                 visible: affectation.status == "Terminé",
                    //                 child: IconBottonWidget(
                    //                   icon: IconlyLight.edit,
                    //                   text: "Modifier la Validation",
                    //                   onTap: () {},
                    //                 ),
                    //               ),
                    //             ),
                    //           ]
                    //         : [
                    //             Visibility(
                    //               visible: (affectation.status == "En cours" ||
                    //                   affectation.status == "Planifié"),
                    //               child: IconBottonWidget(
                    //                 icon: IconlyLight.paper_plus,
                    //                 text: "Déclarer",
                    //                 onTap: () {},
                    //               ),
                    //             ),
                    //             GetBuilder<ClientListController>(
                    //                 init: ClientListController(),
                    //                 builder: (controller) {
                    //                   return Visibility(
                    //                     visible: (affectation.status ==
                    //                                 "En cours" ||
                    //                             affectation.status !=
                    //                                 "Terminé") &&
                    //                         // affectation.status != "Planifié" &&
                    //                         affectation.status != "Bloqué" &&
                    //                         affectation.status != "Déclaré" &&
                    //                         timeAgo(affectation.createdAt!) ==
                    //                             true,
                    //                     child: IconBottonWidget(
                    //                         icon: IconlyLight.calendar,
                    //                         text: "Planifier",
                    //                         onTap: () {
                    //                           showCupertinoDatePicker(context,
                    //                               mode: CupertinoDatePickerMode
                    //                                   .dateAndTime,
                    //                               initialDateTime: time,
                    //                               leftHanded: false,
                    //                               backgroundColor: Colors.white,
                    //                               action: () {},
                    //                               use24hFormat: true,
                    //                               onDateTimeChanged:
                    //                                   (DateTime time) {
                    //                             if (time.hour > 0 ||
                    //                                 time.minute > 0) {
                    //                               controller.planifiedDate =
                    //                                   DateTime(
                    //                                       time.year,
                    //                                       time.month,
                    //                                       time.day,
                    //                                       time.hour,
                    //                                       time.minute);
                    //                             }
                    //                           });
                    //                         }),
                    //                   );
                    //                 }),
                    //             Visibility(
                    //               visible: (affectation.status == "En cours" ||
                    //                   affectation.status == "Planifié"),
                    //               child: IconBottonWidget(
                    //                 icon: IconlyLight.shield_fail,
                    //                 text: "Blocage",
                    //                 onTap: () {},
                    //               ),
                    //             ),
                    //           ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: affectation.status == "Terminé"
                            ? [
                                Expanded(
                                  child: Visibility(
                                    visible: affectation.status == "Terminé",
                                    child: IconBottonWidget(
                                      icon: IconlyLight.edit,
                                      text: "Modifier la déclaration",
                                      onTap: () {
                                        // context.pop();
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Visibility(
                                    visible: affectation.status == "Terminé",
                                    child: IconBottonWidget(
                                      icon: IconlyLight.edit,
                                      text: "Modifier la Validation",
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ]
                            : [
                                Visibility(
                                  visible: (affectation.status == "En cours" ||
                                      affectation.status == "Planifié"),
                                  child: IconBottonWidget(
                                    icon: IconlyLight.paper_plus,
                                    text: "Déclarer",
                                    onTap: () {
                                      // ignore: use_build_context_synchronously
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: (affectation.status == "En cours" ||
                                          affectation.status != "Terminé") &&
                                      // affectation.status != "Planifié" &&
                                      affectation.status != "Bloqué" &&
                                      affectation.status != "Déclaré" &&
                                      timeAgo(affectation.createdAt!) == true,
                                  child: GetBuilder<AffectationController>(
                                      init: AffectationController(),
                                      builder: (controller) {
                                        return IconBottonWidget(
                                            icon: IconlyLight.calendar,
                                            text: "Planifier",
                                            onTap: () {
                                              showCupertinoDatePicker(context,
                                                  mode: CupertinoDatePickerMode
                                                      .dateAndTime,
                                                  initialDateTime: time,
                                                  leftHanded: false,
                                                  backgroundColor: Colors.white,
                                                  action: () {
                                                    controller
                                                        .planificationAffectation(
                                                            context,
                                                            affectation.id
                                                                .toString(),
                                                            user.technicien!.id
                                                                .toString());
                                                  },
                                                  use24hFormat: true,
                                                  onDateTimeChanged:
                                                      (DateTime time) {
                                                    if (time.hour > 0 ||
                                                        time.minute > 0) {
                                                      controller.planifiedDate =
                                                          DateTime(
                                                              time.year,
                                                              time.month,
                                                              time.day,
                                                              time.hour,
                                                              time.minute);
                                                    }
                                                  });
                                            });
                                      }),
                                ),
                                GetBuilder<AffectationController>(
                                    init: AffectationController(),
                                    builder: (controller) {
                                      return Visibility(
                                        visible: (affectation.status ==
                                                "En cours" ||
                                            affectation.status == "Planifié"),
                                        child: IconBottonWidget(
                                          icon: IconlyLight.shield_fail,
                                          text: "Blocage",
                                          onTap: () {
                                            Get.toNamed(Routes.BLOCAGE_RACCO,
                                                arguments: [
                                                  affectation,
                                                  controller.user
                                                ]);
                                          },
                                        ),
                                      );
                                    }),
                                Visibility(
                                  visible: (affectation.status != "En cours" ||
                                          affectation.status == "Déclaré") &&
                                      affectation.status != "Planifié" &&
                                      affectation.status != "Terminé" &&
                                      affectation.status != "Bloqué",
                                  child: IconBottonWidget(
                                    icon: IconlyLight.tick_square,
                                    text: " Valider ",
                                    onTap: () {},
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
