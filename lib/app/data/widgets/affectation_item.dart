import 'package:iconly/iconly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:racco_final/models/affectation.dart';

import 'package:intl/intl.dart';

class AffectationItem extends StatelessWidget {
  final Affectations affectation;
  final bool showInfoIcon;
  final void Function()? onTap;
  const AffectationItem(
      {super.key,
      required this.affectation,
      required this.showInfoIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.r)),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                offset: Offset(0, 0),
                blurRadius: 15)
          ],
          color: const Color.fromRGBO(251, 251, 251, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(97, 113, 186, 0.2199999988079071),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                    height: 55.w,
                    width: 55.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF6171ba),
                    ),
                    child: const Icon(
                      IconlyBold.profile,
                      // color: Color.fromRGBO(151, 72, 150, 1),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              20.horizontalSpace,
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Id client : ',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: SelectableText(
                              affectation.client!.clientId ?? '',
                              textAlign: TextAlign.start,
                              toolbarOptions: const ToolbarOptions(
                                copy: true,
                                selectAll: true,
                              ),
                              showCursor: true,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          'Client : ',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              affectation.client!.name ?? '',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          'SIP : ',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        Expanded(
                          child: SelectableText(
                            affectation.client!.sip ?? '',
                            // overflow: TextOverflow.ellipsis,
                            toolbarOptions: const ToolbarOptions(
                              copy: true,
                              selectAll: true,
                            ),
                            showCursor: true,
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    affectation.datePlanification != null
                        ? Visibility(
                            visible: affectation.status != 'Bloqué' &&
                                affectation.status != 'Validé' &&
                                affectation.status != 'En cours',
                            child: Row(
                              children: [
                                Text(
                                  'Planifié : ',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                                Expanded(
                                  child: Text(
                                    affectation.datePlanification!.isNotEmpty
                                        ? DateFormat('dd/MM/yyyy HH:mm').format(
                                            DateTime.parse(
                                                affectation.datePlanification!))
                                        : '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Visibility(
                visible: showInfoIcon,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 1,
                    color: const Color.fromARGB(255, 212, 208, 208),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(97, 113, 186, 0.2199999988079071),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Container(
                    height: 55.w,
                    width: 55.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF6171ba),
                    ),
                    child: const Icon(
                      IconlyBroken.show,
                      // color: Color.fromRGBO(151, 72, 150, 1),
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
