import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/auth/login.dart';
import 'package:GermAc/pages/course_details.dart';
import 'package:GermAc/widgets/course_card.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionDetailedPage extends StatefulWidget {
  static const String id = 'sections_detailes';

  final String sectionId;

  const SectionDetailedPage({super.key, required this.sectionId});

  @override
  State<SectionDetailedPage> createState() => _SectionDetailedPageState();
}

class _SectionDetailedPageState extends State<SectionDetailedPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<SectionProvider>()
        .getSectionDetails(context, widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    final sectionProvider = Provider.of<SectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('Section Details'),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: getBody(sectionProvider, context),
    );
  }

  Widget getBody(SectionProvider sectionProvider, BuildContext context) {
    switch (sectionProvider.state) {
      case ERROR_STATE:
        return ErrorPage(
          errorMessage: sectionProvider.errorMessage,
          callBack: () async {
            setState(() {
              sectionProvider.state = LOADING_STATE;
            });
            await sectionProvider.getSections(context);
          },
        );
      case SUCCESS_STATE:
        return Container(
          decoration: const BoxDecoration(color: Color(0xff243253)),
          child: Center(
            child: sectionProvider.sectionDetailsModels.coursesModel!.isEmpty
                ? Text(
                    tr('Ops! No Courses'),
                    style: const TextStyle(
                        color: Colors.white, fontFamily: "Playfair Display"),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: ListView.builder(
                      itemBuilder: (context, index) => CourseCard(
                        title: sectionProvider
                            .sectionDetailsModels.coursesModel![index].name,
                        imagePath: 'assets/images/slider${index + 1}.jpg',
                        onTap: () {
                          if (SharedClass.userToken != '') {
                            Navigator.push(
                                context,
                                Utils.createRoute(
                                  CourseDetails(
                                    id: sectionProvider.sectionDetailsModels
                                        .coursesModel![index].id,
                                    specialization: sectionProvider
                                        .sectionDetailsModels.name,
                                  ),
                                ));
                          } else {
                            Navigator.of(context)
                                .push(Utils.createRoute(const LoginPage()));
                          }
                        },
                      ),
                      itemCount: sectionProvider
                          .sectionDetailsModels.coursesModel!.length,
                    ),
                  ),
          ),
        );

      default:
        return const LoadingWidget();
    }
  }
}
