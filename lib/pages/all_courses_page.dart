import 'package:GermAc/core/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AllCoursesPage extends StatelessWidget {
  static const String id = 'all_courses';

  const AllCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('all_courses'),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 24,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
