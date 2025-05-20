// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/widgets/appointment_card.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/providers/sections_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppointmentsPage extends StatefulWidget {
  final String doctor_id;
  const AppointmentsPage({super.key, required this.doctor_id});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<SectionProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
          appBar: AppBar(
            title: Text(tr('Appointments')),
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
            foregroundColor: Colors.white,
          ),
          body: body(context)),
    );
  }

  Future<List<dynamic>> res(String docid) async {
    try {
      http.Response response = await http.get(Uri.parse(
          "https://germ-ac.com/api/getAppointments/?doctor_id=$docid"));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> data =
            jsonDecode(response.body)["freeAppointments"];
        List h = [];
        data.forEach((key, value) {
          h.add(value);
        });
        return h;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Widget body(BuildContext context) {
    return FutureBuilder(
      future: res(widget.doctor_id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(child: Text(tr('Ops! No Appointments')));
          } else {
            return Container(
              color: const Color(0xff243253),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    date: snapshot.data![index]["appointment_time"],
                    price: snapshot.data![index]["price"],
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      try {
                        http.Response response = await http.post(
                            Uri.parse(
                                "https://germ-ac.com/api/bookAppointment"),
                            body:
                                jsonEncode({"id": snapshot.data![index]["id"]}),
                            headers: {
                              'Content-Type': 'application/json',
                              "Authorization":
                                  'Bearer ${SharedClass.userToken}',
                            });
                        print("Tttttttttttttttt${response.statusCode}");
                        if (response.statusCode == 200) {
                          Map<String, dynamic> m = jsonDecode(response.body);
                          launchUrl(Uri.parse(m["url"]));
                          setState(() {
                            isloading = false;
                          });
                        } else {
                          Utils.showErrorSnackBar(
                              context, tr("Something went error"));
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
            );
          }
        } else {
          return const LoadingWidget();
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
