import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/theme/palette.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  final String number;
  final String desc;
  final IconData icon;

  const HomeCard(
      {super.key,
      required this.number,
      required this.desc,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      width: 400.w,
      height: 300.h,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 26,
                color: primaryColor,
              ),
              Text(
                number,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Playfair Display",
                    color: HEADING_COLOR),
              )
            ],
          ),
          Text(tr(desc))
        ],
      ),
    );
  }
}
