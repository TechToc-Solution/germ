// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/chats_list.dart';
import 'package:GermAc/widgets/appoitment_user_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: SharedClass.email);
  final TextEditingController _nameController =
      TextEditingController(text: SharedClass.name);
  final TextEditingController _passwordController = TextEditingController();
  bool isloading = false;
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  final TextEditingController _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(SharedClass.userToken);
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        floatingActionButton: SharedClass.roleId == '3'
            ? Form(
                key: formKey2,
                child: FloatingActionButton(
                  tooltip: tr("Add Appointment"),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100));

                    if (newDate == null) return;

                    TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                            hour: dateTime.hour, minute: dateTime.minute));
                    if (newTime == null) return;

                    final newDateTime = DateTime(
                      newDate.year,
                      newDate.month,
                      newDate.day,
                      newTime.hour,
                      newTime.minute,
                    );
                    dateTime = newDateTime;
                    print(dateTime.toIso8601String());
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tr("Enter the price"),
                                  style: TextStyle(
                                      fontFamily: "Playfair Display",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: AppColors.mainColor),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _priceController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Field shouldn't be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24))),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (formKey2.currentState!.validate()) {
                                        try {
                                          http.Response response = await http.post(
                                              Uri.parse(
                                                  "https://germ-ac.com/api/storeAppointment"),
                                              body: jsonEncode({
                                                "appointment_time":
                                                    dateTime.toIso8601String(),
                                                "price": _priceController.text
                                              }),
                                              headers: {
                                                'Content-Type':
                                                    'application/json',
                                                "Authorization":
                                                    'Bearer ${SharedClass.userToken}',
                                              });
                                          print(response.statusCode);
                                          if (response.statusCode == 200) {
                                            Map<String, dynamic> m =
                                                jsonDecode(response.body);

                                            Utils.showSuccessSnackBar(
                                                context, m["message"]);
                                            Navigator.pop(context);
                                          } else {
                                            Utils.showErrorSnackBar(context,
                                                "Something went error");
                                            Navigator.pop(context);
                                          }
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      }
                                    },
                                    child: Text(
                                      tr("Submit"),
                                      style: TextStyle(
                                          fontFamily: "Playfair Display",
                                          color: AppColors.mainColor),
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add),
                ),
              )
            : null,
        appBar: AppBar(
          title: Text(
            tr('My Profile'),
            style: const TextStyle(fontFamily: "Playfair Display"),
          ),
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          color: const Color(0xff243253),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: tr('Name'),
                        labelStyle: const TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: tr('Email'),
                        labelStyle: const TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      // You can add more email validation logic here.
                      return null;
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: tr('Password'),
                        labelStyle: const TextStyle(color: Colors.white)),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  /*TextFormField(
                    controller: _confirmPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),*/
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      print(SharedClass.userToken);
                      if (_formKey.currentState!.validate()) {
                        if (_passwordController.text.length < 8) {
                          Utils.showErrorSnackBar(context,
                              tr('password_must_be_more_than_8_characters'));
                        } else {
                          setState(() {
                            isloading = true;
                          });
                          try {
                            http.Response response = await http.post(
                                Uri.parse(
                                  "https://germ-ac.com/api/update-password",
                                ),
                                body: {
                                  "new_password": _passwordController.text
                                },
                                headers: {
                                  "Authorization":
                                      "Bearer ${SharedClass.userToken}"
                                });
                            if (response.statusCode == 200) {
                              Utils.showSuccessSnackBar(context,
                                  jsonDecode(response.body)["message"]);
                            } else {
                              Utils.showErrorSnackBar(
                                  context, tr("Something went error"));
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                          setState(() {
                            isloading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      tr('Submit'),
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontFamily: "Playfair Display",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ChattingButton(),
                  Center(
                      child: Text(
                    tr("Your appoitments"),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: "Playfair Display",
                        fontWeight: FontWeight.bold),
                  )),
                  Divider(
                    color: AppColors.mainColor,
                  ),
                  FutureBuilder(
                    future: getUserAppoitments(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              String getdocName() {
                                if (SharedClass.roleId == '3') {
                                  if (snapshot.data![index]["user"] == null) {
                                    return tr("Free appoitment");
                                  } else {
                                    return snapshot.data![index]["user"]
                                        ["name"];
                                  }
                                } else {
                                  return snapshot.data![index]["doctor"]
                                      ["name"];
                                }
                              }

                              return Column(
                                children: [
                                  AppoitmentUserCard(
                                    drName: getdocName(),
                                    price: snapshot.data![index]["price"]
                                        .toString(),
                                    date: snapshot.data![index]
                                        ["appointment_time"],
                                    onpressed: () async {
                                      setState(() {
                                        isloading = true;
                                      });
                                      http.Response response = await http.post(
                                          Uri.parse(
                                            "https://germ-ac.com/api/conversations/store/${snapshot.data![index]["doctor_id"].toString()}",
                                          ),
                                          body: {
                                            "appointment_id": snapshot
                                                .data![index]["id"]
                                                .toString()
                                          },
                                          headers: {
                                            "Authorization":
                                                "Bearer ${SharedClass.userToken}"
                                          });
                                      if (response.statusCode != 200) {
                                        Utils.showErrorSnackBar(
                                            context,
                                            jsonDecode(
                                                response.body)["message"]);
                                      } else {
                                        launchUrl(Uri.parse(
                                            jsonDecode(response.body)["url"]));
                                      }
                                      setState(() {
                                        isloading = false;
                                      });
                                    },
                                    onpressedDelete: () async {
                                      setState(() {
                                        isloading = true;
                                      });
                                      http.Response response = await http.delete(
                                          Uri.parse(
                                              "https://germ-ac.com/api/appointments/${snapshot.data![index]["id"]}"),
                                          headers: {
                                            "Authorization":
                                                "Bearer ${SharedClass.userToken}"
                                          });
                                      if (response.statusCode == 200) {
                                        setState(() {
                                          isloading = false;
                                        });
                                        Utils.showSuccessSnackBar(
                                            context,
                                            jsonDecode(
                                                response.body)["message"]);
                                      } else {
                                        setState(() {
                                          isloading = false;
                                        });
                                        Utils.showErrorSnackBar(
                                            context, "Error");
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              );
                            },
                            itemCount: snapshot.data!.length);
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<List> getUserAppoitments() async {
  String url = (SharedClass.roleId == '3')
      ? "https://germ-ac.com/api/doctor/appointments"
      : "https://germ-ac.com/api/user/appointments";
  print(SharedClass.userToken);
  http.Response response = await http.get(Uri.parse(url),
      headers: {"Authorization": "Bearer ${SharedClass.userToken}"});
  print(response.statusCode);
  dynamic data = jsonDecode(response.body);
  print(data);
  return data["appointments"];
}

class ChattingButton extends StatelessWidget {
  const ChattingButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (SharedClass.roleId == "3") {
      return ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatList(),
                ));
          },
          child: Text(
            tr("View chat list"),
            style: TextStyle(
                fontFamily: "Playfair Display",
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor),
          ));
    } else {
      return const SizedBox();
    }
  }
}
