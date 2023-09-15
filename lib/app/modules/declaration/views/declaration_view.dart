import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:racco_final/app/data/widgets/image_widget.dart';

import '../../../data/services.dart';
import '../../../data/vars.dart';
import '../../../data/widgets/app_bar_widget.dart';
import '../controllers/declaration_controller.dart';

class DeclarationView extends GetView<DeclarationController> {
  const DeclarationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
                width: double.infinity,
                height: 45.h,
                child: GetBuilder<DeclarationController>(
                    init: DeclarationController(),
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
          title: "Déclaration Sav client",
          show: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                GetBuilder<DeclarationController>(
                    init: DeclarationController(),
                    builder: (contr) {
                      return ImagePickerWidget(
                        titel: "Photo test Signal",
                        image: contr.imageTestSignal,
                        onTap: () {
                          contr.changeImage(() async {
                            contr.imageTestSignal = await getImageFromCamera();
                            contr.update();
                          }, () async {
                            contr.imageTestSignal = await getImageFromGallery();
                            contr.update();
                          }, () async {
                            contr.imageTestSignal = deleteImage();
                            contr.update();
                          }, context);
                        },
                      );
                    }),
                12.verticalSpace,
                GetBuilder<DeclarationController>(
                    init: DeclarationController(),
                    builder: (contr) {
                      return ImagePickerWidget(
                        titel: "Photo facultatif",
                        image: contr.imageBlockage,
                        onTap: () {
                          contr.changeImage(() async {
                            contr.imageBlockage = await getImageFromCamera();
                            contr.update();
                          }, () async {
                            contr.imageBlockage = await getImageFromGallery();
                            contr.update();
                          }, () async {
                            contr.imageBlockage = deleteImage();
                            contr.update();
                          }, context);
                        },
                      );
                    }),
                12.verticalSpace,
                Row(
                  children: [
                    Text(
                      "Solution :",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                12.verticalSpace,
                GetBuilder<DeclarationController>(
                    init: DeclarationController(),
                    builder: (controller) {
                      return CustomDropdown.search(
                        hintText: 'Selectionnez la solution',
                        items: const [
                          'Probleme de jarretiere',
                          'Changement de jarretiere',
                          'Probleme de PTO',
                          'Changement de PTO',
                          'Changement de transformateur',
                          'Probleme au PBI',
                          'Probleme au PBO',
                          'Changement de cable abonné',
                          'Probleme au niveau de la chambre',
                          'Changement de cable transport',
                          'Changement de routeur',
                          'Changement routeur payant',
                          'Rien a signaler',
                          'Probleme de config',
                          'Changement de téléphone',
                          'Emplacement',
                        ],
                        controller: controller.descriptionController,
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
