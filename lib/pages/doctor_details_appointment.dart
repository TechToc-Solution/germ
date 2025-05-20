// ignore_for_file: non_constant_identifier_names, avoid_print, must_be_immutable, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:GermAc/core/constant.dart';
import 'package:GermAc/pages/appointments_page.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final String doctor_id;
  String prof_title, specialization, cur_workplace, experiences;
  DetailsPage(
      {super.key,
      required this.doctor_id,
      required this.prof_title,
      required this.specialization,
      required this.cur_workplace,
      required this.experiences});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isloading = true;
  bool isloading2 = true;
  bool isloading3 = false;
  @override
  Widget build(BuildContext context) {
    print("hh${widget.doctor_id}");
    Provider.of<SectionProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
        ),
        body: body(context));
  }

  Future<Map<String, dynamic>> docdata(String docid) async {
    try {
      http.Response response = await http.get(
          Uri.parse("https://germ-ac.com/api/doctor/show?doctor_id=$docid"));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body)["doctor"];
        return data;
      } else {
        return {};
      }
    } catch (e) {
      print(e.toString());
    }
    return {};
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
      future: docdata(widget.doctor_id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return EasyLocalization.of(context)?.currentLocale ==
                  const Locale("en")
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xff243253),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColors.mainColor,
                              radius: 64,
                              child: Image(
                                image:
                                    NetworkImage(snapshot.data!["image"] ?? ""),
                                errorBuilder: (context, error, stackTrace) =>
                                    CircleAvatar(
                                  backgroundColor: AppColors.mainColor,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Text(
                              "Dr's Name: ${snapshot.data!["name"] ?? "Unavailable"}",
                              style: const TextStyle(
                                  fontFamily: "Playfair Display",
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Text(
                              "Professional Title: ${snapshot.data!["Professional_title_en"] ?? "Unavailable"}",
                              style: const TextStyle(
                                  fontFamily: "Playfair Display",
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Text(
                            "Specialization: ${snapshot.data!["specialization_en"] == null ? "Unavailable" : snapshot.data!["specialization_en"].toString().replaceAll("<br>", "\n")}",
                            style: const TextStyle(
                                fontFamily: "Playfair Display",
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Text(
                            "Experiences: ${snapshot.data!["description_en"] == null ? "Unavailable" : snapshot.data!["description_en"].toString().replaceAll("<br>", "\n")}",
                            style: const TextStyle(
                                fontFamily: "Playfair Display",
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Text(
                            "Current Workplace: ${snapshot.data!["current_workplace"] ?? "Unavailable"}",
                            style: const TextStyle(
                                fontFamily: "Playfair Display",
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AppointmentsPage(
                                        doctor_id: widget.doctor_id);
                                  },
                                ));
                              },
                              child: Text(
                                tr("Show Appointments"),
                                style: TextStyle(color: AppColors.mainColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xff243253),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColors.mainColor,
                              radius: 64,
                              child: Image(
                                image:
                                    NetworkImage(snapshot.data!["image"] ?? ""),
                                errorBuilder: (context, error, stackTrace) =>
                                    CircleAvatar(
                                  backgroundColor: AppColors.mainColor,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: Text(
                              "${tr("Dr Name")}: ${snapshot.data!["name"]}",
                              style: const TextStyle(
                                  fontFamily: "Playfair Display",
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Center(
                            child: Text(
                              "المسمّى المهني:  ${snapshot.data!["Professional_title_ar"] ?? "غير متوفر"}",
                              style: const TextStyle(
                                  fontFamily: "Playfair Display",
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Text(
                            "${tr("Specialization")}: ${snapshot.data!["specialization_ar"] == null ? "غير متوفر" : snapshot.data!["specialization_ar"].toString().replaceAll("<br>", "\n")}",
                            style: const TextStyle(
                                fontFamily: "Playfair Display",
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Text(
                            "${tr("Experiences")}: ${snapshot.data!["description_ar"] == null ? "غير متوفر" : snapshot.data!["description_ar"].toString().replaceAll("<br>", "\n")}",
                            style: const TextStyle(
                                fontFamily: "Playfair Display",
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Text(
                            "${tr("Current Workplace")}: ${snapshot.data!["current_workplace"] ?? "غير متوفر"}",
                            style: const TextStyle(
                                fontFamily: "Playfair Display",
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Divider(
                            color: AppColors.mainColor,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AppointmentsPage(
                                        doctor_id: widget.doctor_id);
                                  },
                                ));
                              },
                              child: Text(
                                tr("Show Appointments"),
                                style: TextStyle(color: AppColors.mainColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        } else {
          return Container(
            child: const LoadingWidget(),
            color: Colors.white,
          );
        }
      },
    );
  }

  // Future<void> getAppointments(
  //     BuildContext context, String appointment_id) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final response = await DataLoader.postRequest(
  //     url: DataLoader.bookAppointmentURL,
  //     body: {'appointment_id': appointment_id},
  //     headers: {
  //       'Content-Type': 'application/json',
  //       "Authorization": 'Bearer ${SharedClass.userToken}',
  //     },
  //   );

  //   if (response.code == SUCCESS_CODE) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 4),
  //         content: Text(
  //           response.message,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );

  //     Navigator.pushAndRemoveUntil(
  //         context, Utils.createRoute(HomePage()), (route) => false);
  //     // conversation_id = response.data!['conversation']['id'].toString();

  //   } else {
  //     _isLoading = false;

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         backgroundColor: primaryColor,
  //         duration: Duration(seconds: 4),
  //         content: Text(
  //           response.message,
  //           style: TextStyle(color: Colors.white),
  //         ),
  //       ),
  //     );
  //     // notifyListeners();
  //   }
  // }
}







/*
ListView.builder(
                        itemCount: snapshot.data!.length,
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return AppointmentCard(
                            date: snapshot.data![index]["appointment_time"],
                            price: snapshot.data![index]["price"],
                            onPressed: () async {
                              setState(() {
                                isloading3 = true;
                              });
                              try {
                                http.Response response = await http.post(
                                    Uri.parse(
                                        "https://germ-ac.com/api/bookAppointment"),
                                    body: jsonEncode(
                                        {"id": snapshot.data![index]["id"]}),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      "Authorization":
                                          'Bearer ${SharedClass.userToken}',
                                    });
                                print("Tttttttttttttttt${response.statusCode}");
                                if (response.statusCode == 200) {
                                  Map<String, dynamic> m =
                                      jsonDecode(response.body);
                                  launchUrl(Uri.parse(m["url"]));
                                  setState(() {
                                    isloading3 = false;
                                  });
                                } else {
                                  Utils.showErrorSnackBar(
                                      context, "Something went error");
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                          );
                        },
                      ),
                      */