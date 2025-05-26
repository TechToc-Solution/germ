// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/models/course_model.dart';
import 'package:GermAc/models/doctor_model.dart';
import 'package:GermAc/models/section_model.dart';
import 'package:GermAc/pages/chat_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class SectionProvider extends ChangeNotifier {
  List<SectionModel> sectionModels = [];
  SectionModel sectionDetailsModels = SectionModel(
      id: '', name: '', description: '', created_at: '', updated_at: '');
  late CourseModel courseDetails;
  late DoctorModel doctorModel;
  late List<DoctorModel> doctorModels;
  bool isLoading = false;
  int state = IDLE_STATE;
  String errorMessage = '';
  Future<void> getSections(BuildContext context) async {
    isLoading = true;
    state = LOADING_STATE;

    final response =
        await DataLoader.getRequest(url: DataLoader.getSectionsURL);
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;
      List<dynamic> data = response.data?['data'] ?? [];

      sectionModels = data
          .map<SectionModel>(
              (jsonUserModel) => SectionModel.fromMap(jsonUserModel))
          .toList();
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> getSectionDetails(BuildContext context, String sectionId) async {
    state = LOADING_STATE;

    final response = await DataLoader.getRequest(
        url: '${DataLoader.getSectionDetailsURL}?section_id=$sectionId');
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;

      final data = response.data?['section'] ?? {};

      sectionDetailsModels = SectionModel.fromMap(data);
      errorMessage = response.message;
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
      // notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getCourseDetails(BuildContext context, String courseId) async {
    state = LOADING_STATE;

    final response = await DataLoader.getRequest(
        url: '${DataLoader.getCourseDetailsURL}?course_id=$courseId');
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;

      final data = response.data?['course'] ?? {};

      courseDetails = CourseModel.fromMap(data);
      errorMessage = response.message;
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
      // notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getDoctorDetails(BuildContext context, String doctorId) async {
    state = LOADING_STATE;

    final response = await DataLoader.getRequest(
        url: '${DataLoader.getDoctorDetailsURL}?doctor_id=$doctorId');
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;

      final data = response.data?['doctor'] ?? {};

      doctorModel = DoctorModel.fromMap(data);
      errorMessage = response.message;
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
      // notifyListeners();
    }

    notifyListeners();
  }

  Future<void> getOnlineConclusionsSections(BuildContext context) async {
    isLoading = true;
    state = LOADING_STATE;

    final response =
        await DataLoader.getRequest(url: DataLoader.getSectionsURL);
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;
      List<dynamic> data = response.data?['sections'] ?? [];

      sectionModels = data
          .map<SectionModel>(
              (jsonUserModel) => SectionModel.fromMap(jsonUserModel))
          .toList();
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
    }

    isLoading = false;

    notifyListeners();
  }

  Future<void> getDoctorsInSection(
      BuildContext context, String sectionId) async {
    state = LOADING_STATE;

    final response = await DataLoader.getRequest(
        url: '${DataLoader.getDoctorsInSectionURL}/?section_id=$sectionId');
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;

      log(response.data.toString());
      final data = response.data?['doctors'] ?? [];

      doctorModels = data
          .map<DoctorModel>(
              (jsonUserModel) => DoctorModel.fromMap(jsonUserModel))
          .toList();
      errorMessage = response.message;
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
      // notifyListeners();
    }

    notifyListeners();
  }

  String conversation_id = '';
  Future<void> storeConversation(BuildContext context, String doctorId) async {
    state = LOADING_STATE;
    OneContext()
        .showProgressIndicator(builder: (_) => Utils.showLoadingWidget());
    final response = await DataLoader.postRequest(
        url: DataLoader.storeConversationURL,
        body: {
          'doctor_id': doctorId
        },
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer ${SharedClass.userToken}',
        });

    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;
      OneContext().hideProgressIndicator();

      conversation_id = response.data!['conversation']['id'].toString();
      log('conversation_id $conversation_id');
      if (conversation_id != '') {
        Navigator.of(context)
            .push(Utils.createRoute(ChatScreen(chatId: conversation_id)));
      } else {
        Utils.showErrorSnackBar(context, tr('No Conversation'));
      }

      errorMessage = response.message;
    } else {
      OneContext().hideProgressIndicator();

      state = ERROR_STATE;
      errorMessage = response.message;
      Utils.showErrorSnackBar(context, errorMessage);

      // notifyListeners();
    }

    notifyListeners();
  }
}
