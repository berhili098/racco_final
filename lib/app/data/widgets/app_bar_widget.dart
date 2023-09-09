import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:racco_final/app/data/widgets/bottom_wave_clipper_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool show;

  const AppBarWidget({
    Key? key,
    this.title,
    this.show = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(1000.0.h), // here the desired height
        child: ClipPath(
            clipper: BottomWaveClipper(),
            child: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.0.r),
                )),
                leading: show
                    ? IconButton(
                        icon: SvgPicture.asset(
                            'assets/imgs/Arrow - Left Circle.svg'),
                        onPressed: () {
                          Get.back();
                        },
                      )
                    : const SizedBox(),
                centerTitle: false,
                title: SizedBox(
                  width: 150.w,
                  child: Text(
                    title ?? '',
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 23.sp,
                        color: Colors.white),
                  ),
                ),
                flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment(1, 1.5),
                            end: Alignment(-0.94597145915031433, -0.8),
                            colors: [
                      Color.fromRGBO(89, 185, 255, 1),
                      Color.fromRGBO(97, 113, 186, 1)
                    ]))))));
  }
}
