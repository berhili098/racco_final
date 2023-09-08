import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:racco_final/app/data/vars.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PrimaryTextField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  Icon? prefixIcon;
  bool? visibility;
  bool? centered;
  bool? isPassword;

  PrimaryTextField({
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.visibility = false,
    this.centered = true,
    this.isPassword = false,
    Key? key,
  }) : super(key: key);

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xffeff0f2)),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.visibility ?? false,
        decoration: InputDecoration(
            label: Text(widget.hintText),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: const Color(0xff14213D),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: const Color(0xff14213D).withOpacity(0.50),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.r),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword!
                ? IconButton(
                    icon: Icon(
                      widget.visibility!
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                      size: 18.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.visibility = !widget.visibility!;
                      });
                    },
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  )),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        color: primaryColor,
        size: 50.sp,
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CardStatistiqueWidget extends StatelessWidget {
  bool? isSav = false;
  final String title;
  int nbItem = -1;
  final Icon icon;
  final double percent;
  final bool useProgress;
  final Function()? onTap;

  CardStatistiqueWidget(
      {Key? key,
      this.isSav = false,
      required this.title,
      required this.icon,
      this.onTap,
      required this.useProgress,
      required this.nbItem,
      required this.percent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        height: 170.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white.withOpacity(0.9),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(15.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150.w,
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                  color: Colors.black),
                            ),
                          ),
                          useProgress
                              ? const SizedBox()
                              : Icon(
                                  IconlyLight.calendar,
                                  size: 30.sp,
                                ),
                        ],
                      ),
                      nbItem == 0
                          ? isSav == null || isSav == false
                              ? const Text('Aucun Client')
                              : const Text('Aucun Client Sav')
                          : Text('Il vous reste $nbItem Clients'),
                    ],
                  ),
                  SvgPicture.asset('assets/imgs/Arrow - Right Square.svg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: !useProgress
                  ? SizedBox(
                      width: 120.w,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              nbItem.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 40.sp,
                                  color: const Color(0XFF6171ba)),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 74,
                          stepSize: 15.w,
                          padding: 0,
                          width: 120.w,
                          height: 120.w,
                          selectedStepSize: 15.w,
                          roundedCap: (_, __) => true,
                          gradientColor: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromRGBO(89, 185, 255, 1),
                              Color.fromRGBO(97, 113, 186, 1)
                            ],
                          ),
                          unselectedColor: Colors.red,
                        ),
                        Text(
                          nbItem.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 40.sp,
                            color: const Color(0XFF6171ba),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
