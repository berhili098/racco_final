import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:racco_final/app/data/widget.dart';
import 'package:racco_final/app/modules/drawer/views/drawer_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return DrawerView(user: controller.user!);
          }),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BottomWaveClipper(),
                child: Container(
                    height: 358.w,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(1, 1.5),
                          end: Alignment(-0.94597145915031433, -0.8),
                          colors: [
                            Color.fromRGBO(89, 185, 255, 1),
                            Color.fromRGBO(97, 113, 186, 1)
                          ]),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 80.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => _key.currentState!.openDrawer(),
                            icon: SvgPicture.asset('assets/imgs/Sort-1.svg'),
                          ),
                          InkWell(
                            onTap: () => false,
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                    'assets/imgs/Notification.svg'),
                                Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: const Text(
                                      '2',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      22.verticalSpace,
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Bonjour",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 39.sp,
                                    color: Colors.white),
                              ),
                              GetBuilder<HomeController>(
                                  init: HomeController(),
                                  builder: (controller) {
                                    return controller.loading
                                        ? const Text('')
                                        : Padding(
                                            padding:
                                                EdgeInsets.only(left: 15.0.w),
                                            child: Text(
                                              '${controller.user!.firstName!} ${controller.user!.lastName!}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20.sp,
                                                  color: Colors.white),
                                            ),
                                          );
                                  }),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                      22.verticalSpace,
                      Container(
                        width: double.infinity,
                        height: 66.h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white.withOpacity(0.9),
                          border: Border.all(color: const Color(0xffeff0f2)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset('assets/imgs/card.svg'),
                                  SvgPicture.asset('assets/imgs/Document.svg'),
                                ],
                              ),
                              16.horizontalSpace,
                              Text(
                                "Demander des Clients",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.sp,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset('assets/imgs/card.svg'),
                                  const Icon(
                                    IconlyBold.download,
                                    color: Color(0xFF6171ba),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      22.verticalSpace,
                      CardStatistiqueWidget(
                        icon: const Icon(Icons.abc),
                        nbItem: 2,
                        percent: 1.0,
                        title: "Vos clients ",
                        useProgress: true,
                        onTap: () {},
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}