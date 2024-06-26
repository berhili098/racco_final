import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerWidget extends StatelessWidget {
  final String titel;
  final Uint8List image;
  final void Function()? onTap;
  const ImagePickerWidget(
      {Key? key, required this.titel, this.onTap, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$titel :",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          // width: MediaQuery.of(context).size.width,
          height: 180.w,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade200),
          alignment: Alignment.center,
          child: image.isNotEmpty
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(image),
                        )),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0XFF6171ba)),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    )
                  ],
                )
              : InkWell(
                  onTap: onTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/imgs/Mask group (9).png',
                          color: const Color(0XFF6171ba)),
                      Text(
                        titel,
                        style: const TextStyle(color: Color(0XFF6171ba)),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
