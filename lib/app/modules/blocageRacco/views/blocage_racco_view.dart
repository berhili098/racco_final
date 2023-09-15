import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:racco_final/app/data/vars.dart';

import '../../../data/services.dart';
import '../../../data/widgets/app_bar_widget.dart';
import '../../../data/widgets/field_description_widget.dart';
import '../../../data/widgets/image_widget.dart';
import '../controllers/blocage_racco_controller.dart';

class BlocageRaccoView extends GetView<BlocageRaccoController> {
  const BlocageRaccoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
                width: double.infinity,
                height: 45.h,
                child: GetBuilder<BlocageRaccoController>(
                    init: BlocageRaccoController(),
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
          title: "Declarer  Blocage",
          show: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                10.verticalSpace,
                Row(
                  children: [
                    Text(
                      "Type de blocage :",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                12.verticalSpace,
                GetBuilder<BlocageRaccoController>(
                    init: BlocageRaccoController(),
                    builder: (controller) {
                      return CustomDropdown.search(
                        onChanged: (p0) {
                          controller.imageBlocage = Uint8List(0);
                          controller.imageSchema = Uint8List(0);
                          controller.update();
                        },
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
                GetBuilder<BlocageRaccoController>(
                    init: BlocageRaccoController(),
                    builder: (contr) {
                      return Visibility(
                        visible: controller.blocageType.text.isNotEmpty &&
                            controller.returnFirstTitle() != 'no',
                        child: ImagePickerWidget(
                          titel: controller.returnFirstTitle(),
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
                        ),
                      );
                    }),
                12.verticalSpace,
                GetBuilder<BlocageRaccoController>(
                    init: BlocageRaccoController(),
                    builder: (contr) {
                      return Visibility(
                        visible: contr.blocageType.text.isNotEmpty &&
                            contr.returnSecondTitle() != 'no',
                        child: ImagePickerWidget(
                          titel: controller.returnSecondTitle(),
                          image: contr.imageSchema,
                          onTap: () {
                            contr.changeImage(() async {
                              contr.imageSchema = await getImageFromCamera();
                              contr.update();
                            }, () async {
                              contr.imageSchema = await getImageFromGallery();
                              contr.update();
                            }, () async {
                              contr.imageSchema = deleteImage();
                              contr.update();
                            }, context);
                          },
                        ),
                      );
                    }),
                12.verticalSpace,
                GetBuilder<BlocageRaccoController>(
                    init: BlocageRaccoController(),
                    builder: (controller) {
                      return Visibility(
                        visible: controller.blocageType.text.isNotEmpty,
                        child: FieldDescriptionWidget(
                          title: 'Justification',
                          hint: 'Veuillez entrer Justification',
                          readOnly: false, height: 200,
                          controller: controller.justif,
                          maxLines: 20,

                          // minLines: 1
                        ),
                      );
                    }),
                98.verticalSpace,
              ],
            ),
          ),
        ));
  }
}
