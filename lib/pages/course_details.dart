// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/theme/palette.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/widgets/error_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatefulWidget {
  final String id;
  final String specialization;

  const CourseDetails({
    required this.id,
    required this.specialization,
  });

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SectionProvider>().getCourseDetails(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print(SharedClass.userToken);
    final sectionProvider = Provider.of<SectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Details',
          style: TextStyle(fontFamily: "Playfair Display"),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ModalProgressHUD(
          inAsyncCall: isloading, child: getBody(sectionProvider, context)),
    );
  }

  Widget getBody(SectionProvider sectionProvider, BuildContext context) {
    switch (sectionProvider.state) {
      case LOADING_STATE:
        return const LoadingWidget();

      case SUCCESS_STATE:
        return Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      width: double.infinity,
                      color: primaryColor,
                    ),
                    Text(
                      tr('Course Details'),
                      style: const TextStyle(
                        fontFamily: "Playfair Display",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sectionProvider.courseDetails.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Playfair Display",
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        sectionProvider.courseDetails.date,
                      ),
                      const SizedBox(height: 16.0),
                      const Divider(thickness: 2),
                      Text(
                        sectionProvider.courseDetails.description,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Playfair Display",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '${tr('Specialization')}: ${sectionProvider.courseDetails.section!.name}',
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: "Playfair Display",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: <Widget>[
                          Text(
                            '${tr('Rating')}: ',
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          if (sectionProvider.courseDetails.rate != null)
                            buildRatingStars(double.tryParse(
                                    sectionProvider.courseDetails.rate!) ??
                                0),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      try {
                        http.Response response = await http.post(
                            Uri.parse("https://germ-ac.com/api/checkout"),
                            body: jsonEncode({"course_id": widget.id}),
                            headers: {
                              'Content-Type': 'application/json',
                              "Authorization":
                                  'Bearer ${SharedClass.userToken}',
                            });
                        print("Tttttttttttttttt" +
                            response.statusCode.toString());
                        if (response.statusCode == 200) {
                          Map<String, dynamic> m = jsonDecode(response.body);
                          if (m["checkout_session_url"] != null) {
                            launchUrl(Uri.parse(m["checkout_session_url"]));
                          } else {
                            launchUrl(Uri.parse(m["webViewLink"]));
                          }
                        } else {
                          Utils.showErrorSnackBar(
                              context, "Something went error");
                          setState(() {
                            isloading = false;
                          });
                        }
                        setState(() {
                          isloading = false;
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text(
                      tr("Check details"),
                      style: TextStyle(
                          fontFamily: "Playfair Display",
                          color: AppColors.mainColor),
                    ))
              ],
            ),
          ),
        );
      default:
        return ErrorPage(
          errorMessage: sectionProvider.errorMessage,
          callBack: () async {
            setState(() {
              sectionProvider.state = LOADING_STATE;
            });
            await sectionProvider.getCourseDetails(context, widget.id);
          },
        );
    }
  }

  Widget buildRatingStars(double rating) {
    List<Icon> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating) {
        stars.add(const Icon(Icons.star, color: Colors.yellow));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.yellow));
      }
    }
    return Row(children: stars);
  }
}
