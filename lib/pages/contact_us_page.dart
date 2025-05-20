import 'dart:developer';

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/models/api_respone_model.dart';
import 'package:GermAc/models/contact_model.dart';
import 'package:GermAc/widgets/default_text_field.dart';
import 'package:GermAc/widgets/loading_widget.dart';
import 'package:GermAc/widgets/navigation_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  static const String id = 'CONTACT_US';

  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  bool _isLoading = false;
  final bool _isLoading1 = false;
  List<ContactModel> contactModels = [];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  ApiResponse response = ApiResponse(code: '', message: '', data: {});

  String responseMessage = '';

  Future<void> getContact() async {
    setState(() {
      _isLoading = true;
    });

    response = await DataLoader.getRequest(url: DataLoader.contactURL);
    log(response.toString());

    List<dynamic> data = response.data?['contact'] ?? [];
    setState(() {
      contactModels = data
          .map<ContactModel>(
              (jsonUserModel) => ContactModel.fromMap(jsonUserModel))
          .toList();
      log(contactModels.length.toString());
      responseMessage = response.message;
      log(responseMessage);

      _isLoading = false;
    });
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _launchPhone(String call) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: call,
    );
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr('Contact Us'),
            style: const TextStyle(fontFamily: "Playfair Display"),
          ),
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        drawer: const CustomNavigationDrawer(),
        body: _isLoading
            ? const LoadingWidget()
            : Container(
                padding: const EdgeInsets.all(6),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom:
                                BorderSide(color: Colors.redAccent, width: 4),
                          )),
                          child: Text(
                            tr('Contact Us'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: "Playfair Display",
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Text(
                        tr('To keep in touch with each other always, you can know our whereabouts and you can also communicate with us by sending us a message in the following form that includes your name and message .'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Playfair Display",
                          fontSize: 18,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 5,
                          ),
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  DefaultTextFiled(
                                    isPassword: false,
                                    keyboardType: TextInputType.text,
                                    controller: nameController,
                                    labelText: tr('name'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return tr('please_enter_your_name');
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                    minLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DefaultTextFiled(
                                    isPassword: false,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    labelText: tr('email'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return tr('please_enter_your_email');
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                    minLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DefaultTextFiled(
                                    isPassword: false,
                                    keyboardType: TextInputType.text,
                                    controller: subjectController,
                                    labelText: tr('Subject'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return tr('please_enter_some_data');
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                    minLines: 1,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  DefaultTextFiled(
                                    isPassword: false,
                                    keyboardType: TextInputType.multiline,
                                    controller: messageController,
                                    labelText: tr('Message'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return tr('please_enter_some_data');
                                      }
                                      return null;
                                    },
                                    maxLines: 20,
                                    minLines: 3,
                                  ),
                                  ElevatedButton(
                                    onPressed: _isLoading1
                                        ? null
                                        : () async {
                                            final data = {
                                              "name":
                                                  nameController.text.trim(),
                                              "email":
                                                  emailController.text.trim(),
                                              "subject":
                                                  subjectController.text.trim(),
                                              "message":
                                                  messageController.text.trim(),
                                            };

                                            if (formKey.currentState!
                                                .validate()) {
                                              await createFeedBack(
                                                  context, data);
                                            }
                                          },
                                    child: Text(
                                      tr('Submit'),
                                      style: const TextStyle(
                                          fontFamily: "Playfair Display"),
                                    ),
                                  ),
                                ],
                              )),
                          const SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              children: [
                                TextSpan(text: '${tr('Location')}: \n'),
                                TextSpan(
                                  text: contactModels.first.location,
                                  style: const TextStyle(
                                      fontFamily: "Playfair Display",
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _launchEmail(contactModels.first.email);
                                },
                                child: Text(
                                  '${tr('email')} : ${contactModels.first.email}',
                                  style: const TextStyle(
                                      fontFamily: "Playfair Display"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () {
                                  _launchPhone(contactModels.first.call);
                                },
                                child: Text(
                                  '${tr('Call')} : ${contactModels.first.call}',
                                  style: const TextStyle(
                                      fontFamily: "Playfair Display"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }

  Future<void> createFeedBack(
      BuildContext context, Map<String, dynamic> data) async {
    setState(() {
      _isLoading = true;
    });

    final response = await DataLoader.postRequest(
        url: DataLoader.storeFeedbackURL, body: data);
    log(response.toString());
    if (response.code == '1') {
      setState(() {
        nameController.clear();
        emailController.clear();
        subjectController.clear();
        messageController.clear();

        _isLoading = false;
      });
      Utils.showSuccessSnackBar(context, tr('Your feedback sent successfully'));
    }

    setState(() {
      _isLoading = false;
    });
  }
}
