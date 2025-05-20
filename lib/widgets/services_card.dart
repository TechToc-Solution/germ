// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ServicesCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  final double width;
  final double heigh;
  final Function() onTap;
  final DecorationImage dimage;
  bool useMarquee;
  ServicesCard(
      {super.key,
      required this.title,
      required this.desc,
      required this.icon,
      required this.width,
      required this.heigh,
      required this.onTap,
      required this.dimage,
      required this.useMarquee});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: heigh,
        decoration: BoxDecoration(
            image: dimage, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.all(6),
        child: useMarquee == false
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Playfair Display",
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                maxLines: 1,
              )
            : Marquee(
                startAfter: const Duration(seconds: 2),
                crossAxisAlignment: CrossAxisAlignment.start,
                text: " $title  ",
                style: const TextStyle(
                    fontFamily: "Playfair Display",
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
      ),
    );
  }
}
