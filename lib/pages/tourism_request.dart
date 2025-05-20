import 'dart:developer';

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/widgets/medical_tour_button.dart';
import 'package:GermAc/widgets/tourism_request_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TourismRequest extends StatefulWidget {
  static const String id = 'TourismRequest';

  const TourismRequest({super.key});

  @override
  State<TourismRequest> createState() => _TourismRequestState();
}

class _TourismRequestState extends State<TourismRequest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _specilaziesController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isLoading) {
          return false;
        } else {
          return true;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                tr('Medical Tourism'),
                style: const TextStyle(fontFamily: "Playfair Display"),
              ),
              backgroundColor: AppColors.mainColor,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            // drawer: NavigationDrawer(),
            body: Center(
              child: Form(
                key: _formKey,
                child: Container(
                  color: const Color(0xff243253),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 20),
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.redAccent, width: 4),
                            )),
                            child: const Text(
                              'TOURISM REQUEST',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Playfair Display",
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        const Text(
                          'New Medical Tourism Request',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Playfair Display",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TourismRequestField(
                          hinttext: tr("Enter your name"),
                          controller: _nameController,
                          title: tr('name'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TourismRequestField(
                          hinttext: tr("Enter your phone number"),
                          controller: _phoneController,
                          title: tr('phone'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TourismRequestField(
                          hinttext: tr("Enter your country"),
                          controller: _countryController,
                          title: tr('Your Country'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TourismRequestField(
                          hinttext: tr("Enter your destination"),
                          controller: _destinationController,
                          title: tr('Your Destination'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TourismRequestField(
                          hinttext: tr("Enter your specialities"),
                          controller: _specilaziesController,
                          title: tr('Your Specialities'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TourismRequestField(
                          hinttext: tr("Enter your message"),
                          controller: _messageController,
                          title: tr('Message'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MedicalTourismButton(
                          onPressed: () async {
                            final bodyRequest = {
                              "name": _nameController.text.trim(),
                              "phone": _phoneController.text.trim(),
                              "country": _countryController.text.trim(),
                              "destination": _destinationController.text.trim(),
                              "message": _messageController.text.trim(),
                              "specialities":
                                  _specilaziesController.text.trim(),
                            };
                            if (_formKey.currentState!.validate()) {
                              await _bookMedicalTourism(context, bodyRequest);
                            }
                          },
                          title: tr('Submit'),
                          // backgroundColor: Colors.red,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  int state = -1;
  bool _isLoading = false;
  String errorMessage = '';
  Future<void> _bookMedicalTourism(
      BuildContext context, Map<String, dynamic> bodyRequest) async {
    setState(() {
      state = LOADING_STATE;
      _isLoading = true;
    });

    final response = await DataLoader.postRequest(
        url: DataLoader.bookMedicalTourismURL, body: bodyRequest);

    if (response.code == SUCCESS_CODE) {
      setState(() {
        _isLoading = false;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 4),
            content: Text(response.message),
          ),
        );

        state = SUCCESS_STATE;
        _countryController.clear();
        _destinationController.clear();
        _messageController.clear();
        _nameController.clear();
        _phoneController.clear();
        _specilaziesController.clear();
      });
    } else {
      setState(() {
        _isLoading = false;

        state = ERROR_STATE;
        errorMessage = response.message;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 4),
            content: Text(response.message),
          ),
        );
      });
    }

    log(response.data.toString());
  }
}
