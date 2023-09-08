import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/palette.dart';
import '../../../data/widget.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'assets/imgs/login_bg.jpg',
        fit: BoxFit.cover,
        height: double.infinity,
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white.withOpacity(0.6),
      ),
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xffeff0f2)),
              ),
              height: 500.h,
              width: kIsWeb ? 220.w : double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) {
                      return Column(
                        children: [
                          35.verticalSpace,
                          Image.asset(
                            'assets/imgs/logo_black.png',
                            height: 50.h,
                          ),
                          10.verticalSpace,
                          const Text('Bienvenue'),
                          10.verticalSpace,
                          const Text(
                            'Connectez-vous pour continuer sur Neweraconnect',
                            style: TextStyle(
                              color: Color(0xff959396),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          30.verticalSpace,
                          PrimaryTextField(
                              prefixIcon: Icon(
                                IconlyBroken.message,
                                color: const Color.fromARGB(255, 157, 159, 163),
                                size: 23.sp,
                              ),
                              controller: controller.emailController,
                              hintText: 'Adresse E-mail'),
                          12.verticalSpace,
                          PrimaryTextField(
                            prefixIcon: Icon(
                              IconlyBroken.lock,
                              color: const Color.fromARGB(255, 157, 159, 163),
                              size: 23.sp,
                            ),
                            controller: controller.passwordController,
                            hintText: 'Mot de passe',
                            visibility: controller.visibility.value,
                            isPassword: true,
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 45.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Palette.kToDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ), 
                              onPressed: () {
                                if (controller.loading.value) {
                                  return;
                                } else {
                                  controller.submit();
                                }
                              },
                              child: controller.loading.value
                                  ? Container(
                                      width: 24.w,
                                      height: 24.h,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Text(
                                      'connexion'.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                            ),
                          ),
                          5.verticalSpace,
                          InkWell(
                            onTap: () {
                              launchUrl(controller.emailLaunchUri);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.w),
                              child: Text(
                                "Contacter le support",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Palette.kToDark,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              )),
        ),
      ),
    ]));
  }
}
