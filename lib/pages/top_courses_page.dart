import 'package:GermAc/core/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TopCoursesPage extends StatefulWidget {
  static const String id = 'top_courses';

  const TopCoursesPage({super.key});

  @override
  State<TopCoursesPage> createState() => _TopCoursesPageState();
}

class _TopCoursesPageState extends State<TopCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('top_courses')),
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
