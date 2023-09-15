import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:racco_final/app/data/vars.dart';

import '../../../data/services.dart';
import '../../../data/widgets/app_bar_widget.dart';
import '../../../data/widgets/image_widget.dart';
import '../controllers/blocage_controller.dart';

class BlocageView extends GetView<BlocageController> {
  const BlocageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
                width: double.infinity,
                height: 45.h,
                child: GetBuilder<BlocageController>(
                    init: BlocageController(),
                    builder: (controller) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                        ),
                        onPressed: () {
                          controller.loading ? null : controller.submit();
                        },
                        child: controller.loading
                            ? Container(
                                width: 24.w,
                                height: 24.h,
                                padding: const EdgeInsets.all(2.0),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                'Declarer',
                                style: TextStyle(color: Colors.white),
                              ),
                      );
                    }))),
        appBar: const AppBarWidget(
          title: "Declarer Sav Blocage",
          show: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              10.verticalSpace,
              Row(
                children: [
                  Text(
                    "Type de blocage :",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              12.verticalSpace,
              GetBuilder<BlocageController>(
                  init: BlocageController(),
                  builder: (controller) {
                    return CustomDropdown.search(
                      hintText: 'Selectionnez le type',
                      items: const [
                        'Adresse erronée déployée',
                        'Adresse erronée non déployée',
                        'Blocage de passage coté appartement',
                        'Blocage de passage coté magasin',
                        'Blocage de passage coté villa',
                        'Blocage coté Syndic',
                        'Client a annulé sa demande',
                        'Contact Erronee',
                        'Demande en double',
                        'Hors Plaque',
                        'Indisponible',
                        'Injoignable/SMS',
                        'Manque ID',
                        'Câble transport dégradés',
                        'Manque Cable transport',
                        'Gpon saturé',
                        'Non Eligible',
                        'Cabel transport saturé',
                        'Splitter saturé',
                        'Pas Signal',
                        'Probléme de verticalite',
                        'Besoin BDC',
                        'Besoin Swan',
                        'Besoin jarretière',
                        'Probléme de verticalité',
                      ],
                      controller: controller.blocageType,
                    );
                  }),
              12.verticalSpace,
              GetBuilder<BlocageController>(
                  init: BlocageController(),
                  builder: (contr) {
                    return ImagePickerWidget(
                      titel: "Photo Blocage",
                      image: contr.imageBlocage,
                      onTap: () {
                        contr.changeImage(() async {
                          contr.imageBlocage = await getImageFromCamera();
                          contr.update();
                        }, () async {
                          contr.imageBlocage = await getImageFromGallery();
                          contr.update();
                        }, () async {
                          contr.imageBlocage = deleteImage();
                          contr.update();
                        }, context);
                      },
                    );
                  }),
              12.verticalSpace,
            ],
          ),
        ));
  }
}
