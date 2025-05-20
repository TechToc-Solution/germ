import 'package:flutter/material.dart';

class TopCoursesCard extends StatefulWidget {
  final String title;
  final String desc;
  final String imgPath;
  const TopCoursesCard(
      {super.key,
      required this.title,
      required this.desc,
      required this.imgPath});

  @override
  State<TopCoursesCard> createState() => _TopCoursesCardState();
}

class _TopCoursesCardState extends State<TopCoursesCard> {
  bool isDescriptionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(
        widget.imgPath,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/images/top_courses.jpg"),
      ),
    );
  }
}
