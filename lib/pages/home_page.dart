import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/course_details.dart';
import 'package:GermAc/pages/courses_page.dart';
import 'package:GermAc/pages/medical_tourism.dart';
import 'package:GermAc/pages/online_cosulutions.dart';
import 'package:GermAc/pages/developing_page.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/widgets/navigation_drawer.dart';
import 'package:GermAc/widgets/services_card.dart';
import 'package:GermAc/widgets/top_courses_card.dart';
import 'package:GermAc/providers/home_provider.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/network/data_loader.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HOME';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getAllData(context);
  }

  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: homeProvider.isLoading,
      child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: Text(
              tr('home'),
              style: const TextStyle(
                  color: Colors.white, fontFamily: "Playfair Display"),
            ),
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
          ),
          drawer: const CustomNavigationDrawer(),
          body: getBody(homeProvider, context)),
    );
  }

  Widget getBody(HomeProvider homeProvider, BuildContext context) {
    switch (homeProvider.state) {
      case ERROR_STATE:
        return ErrorPage(
          errorMessage: homeProvider.errorMessage,
          callBack: () async {
            setState(() {
              homeProvider.state = LOADING_STATE;
            });

            await homeProvider.getAllData(context);
          },
        );
      case SUCCESS_STATE:
        return Container(
          decoration: const BoxDecoration(color: Color(0xff243253)),
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // cs.CarouselSlider(
                //   options: cs.CarouselOptions(
                //     height: 150,
                //     aspectRatio: 16 / 9,
                //     initialPage: 0,
                //     enableInfiniteScroll: true,
                //     reverse: false,
                //     autoPlay: true,
                //     autoPlayInterval: const Duration(seconds: 3),
                //     autoPlayAnimationDuration:
                //         const Duration(milliseconds: 800),
                //     autoPlayCurve: Curves.fastOutSlowIn,
                //     scrollDirection: Axis.horizontal,
                //   ),
                //   items:
                //       context.read<HomeProvider>().sliderImagesPath.map((path) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return Container(
                //             width: MediaQuery.of(context).size.width * 0.9,
                //             margin: const EdgeInsets.symmetric(horizontal: 5.0),
                //             child: Image.asset(
                //               path,
                //               fit: BoxFit.contain,
                //               width: MediaQuery.of(context).size.width * 0.9,
                //               height: 150,
                //             ));
                //       },
                //     );
                //   }).toList(),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black26),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Marquee(
                    startAfter: const Duration(seconds: 2),
                    text: tr(
                        'germAc a service with which you can consult the most qualified and best doctors specialists consultants and professors of the German health care system with instant messages and direct video calls in all medical specialties'),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Playfair Display"),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 60.0,
                    startPadding: 10.0,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Text(
                  tr('services'),
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      fontFamily: "Playfair Display",
                      color: HEADING_COLOR),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServicesCard(
                      useMarquee: true,
                      width: MediaQuery.of(context).size.width / 1.1,
                      heigh: 400.h,
                      icon: Icons.air_rounded,
                      title: ' ${tr("Online Consultation from Germany")} ',
                      desc:
                          ' we offer you medical consultations online, and you must now select the specialty for this medical consultation by clicking on the consultation and follow-up. ',
                      onTap: () {
                        launchUrl(Uri.parse(DataLoader.onlineConsulution));
                        // Navigator.of(context).push(
                        //     Utils.createRoute(const OnlineConclusionsPage()));
                      },
                      dimage: const DecorationImage(
                          image: AssetImage("assets/edits/1.jpg"),
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /*ServicesCard(
                      width: MediaQuery.of(context).size.width / 1.1,
                      heigh: 400.h,
                      icon: Icons.palette,
                      title: tr('Sections'),
                      desc: 'Sections and courses in our website',
                      onTap: () => Navigator.of(context)
                          .push(Utils.createRoute(const SectionsPage())),
                      dimage: const DecorationImage(
                          image: AssetImage("assets/edits/5.jpg"),
                          fit: BoxFit.cover),
                    ),*/
                    const SizedBox(
                      height: 10,
                    ),
                    ServicesCard(
                      useMarquee: true,
                      width: MediaQuery.of(context).size.width / 1.1,
                      heigh: 400.h,
                      icon: Icons.pin,
                      title:
                          " ${tr("Online courses and training from Germany")} ",
                      desc:
                          ' We are team of talented doctors and We have a human side that we would like you to know ',
                      onTap: () {
                        launchUrl(Uri.parse(DataLoader.onlineCourses));
                        // Navigator.of(context)
                        //     .push(Utils.createRoute(const CoursesPage()));
                      },
                      dimage: const DecorationImage(
                          image: AssetImage("assets/edits/2.jpg"),
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ServicesCard(
                      useMarquee: false,
                      width: MediaQuery.of(context).size.width / 1.1,
                      heigh: 400.h,
                      icon: Icons.palette,
                      title: tr('Medical Tourism'),
                      desc:
                          ' we provides medical tourism services to receive treatment abroad for all medical cases in the best and most prestigious universities and hospitals in the world.  ',
                      onTap: () {
                        launchUrl(Uri.parse(DataLoader.medicalToursim));
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) {
                        //     return const MedicalTourism();
                        //   },
                        // ));
                      },
                      dimage: const DecorationImage(
                          image: AssetImage("assets/edits/3.jpg"),
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ServicesCard(
                      useMarquee: true,
                      width: MediaQuery.of(context).size.width / 1.1,
                      heigh: 400.h,
                      icon: Icons.air_rounded,
                      title:
                          " ${tr('Developing Medical and Educational Facilities ')} ",
                      desc: '',
                      onTap: () {
                        launchUrl(Uri.parse(DataLoader.developingMedical));
                        // Navigator.of(context)
                        //     .push(Utils.createRoute(const DevelopingPage()));
                      },
                      dimage: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/edits/4.jpg")),
                    ),
                  ].animate(interval: 400.ms).slideY(
                        duration: 300.ms,
                        begin: 2,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  tr('Top Courses'),
                  style: const TextStyle(
                      fontFamily: "Playfair Display",
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: HEADING_COLOR),
                ),
                cs.CarouselSlider(
                  options: cs.CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                  items:
                      context.read<HomeProvider>().courseModels.map((course) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "${DataLoader.courseDetail}${course.id}"));
                          },
                          // onTap: () => Navigator.push(
                          //     context,
                          //     Utils.createRoute(CourseDetails(
                          //         id: course.id,
                          //         specialization: course.section!.name))),
                          // child: TopCoursesCard(
                          //   title: course.name,
                          //   desc: course.description,
                          //   imgPath: course.image,
                          // ),
                        );
                      },
                    );
                  }).toList(),
                ),
                // SizedBox(
                //   height: 20,
                // )
                // Container(
                //   padding: EdgeInsets.all(8),
                //   height: MediaQuery.of(context).size.height / 1.5,
                //   child: ListView.builder(
                //     shrinkWrap: false,
                //     itemBuilder: (context, index) {
                //       return TopCoursesCard(
                //         title: context
                //             .read<HomeProvider>()
                //             .courseModels[index]
                //             .name,
                //         desc: context
                //             .read<HomeProvider>()
                //             .courseModels[index]
                //             .description,
                //         imgPath: 'assets/images/top_courses.jpg',
                //       );
                //     },
                //     itemCount: context.read<HomeProvider>().courseModels.length,
                //   ),
                // ),

                // const SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        );

      default:
        return const LoadingWidget();
    }
  }
}
