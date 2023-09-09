import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
