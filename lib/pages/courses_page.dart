import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/auth/login.dart';
import 'package:GermAc/pages/course_details.dart';
import 'package:GermAc/widgets/course_card.dart';
import 'package:GermAc/providers/courses_provider.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatefulWidget {
  static const String id = 'courses_page';

  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CoursesProvider>().getCourses(context);
  }

  @override
  Widget build(BuildContext context) {
    final coursesProvider = Provider.of<CoursesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('Courses'),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: buildBody(context, coursesProvider),
    );
  }

  Widget buildBody(BuildContext context, CoursesProvider coursesProvider) {
    switch (coursesProvider.state) {
      case ERROR_STATE:
        return ErrorPage(
          errorMessage: coursesProvider.errorMessage,
          callBack: () {},
        );

      case SUCCESS_STATE:
        return Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(color: Color(0xff243253)),
          child: Center(
            child: coursesProvider.courseModels.isEmpty
                ? Text(
                    tr('Ops! No Courses'),
                    style: const TextStyle(fontFamily: "Playfair Display"),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ListView.builder(
                      itemBuilder: (context, index) => CourseCard(
                        title: coursesProvider.courseModels[index].name,
                        imagePath: 'assets/images/slider1.jpg',
                        onTap: () {
                          // Navigator.pushNamed(context, SectionDetailedPage.id);
                          if (SharedClass.userToken != '') {
                            Navigator.push(
                                context,
                                Utils.createRoute(
                                  CourseDetails(
                                    id: coursesProvider.courseModels[index].id,
                                    specialization: coursesProvider
                                        .courseModels[index].section!.name,
                                  ),
                                ));
                          } else {
                            Navigator.of(context)
                                .push(Utils.createRoute(const LoginPage()));
                          }
                        },
                      ),
                      itemCount: coursesProvider.courseModels.length,
                    ),
                  ),
          ),
        );

      default:
        return const LoadingWidget();
    }
  }
}
