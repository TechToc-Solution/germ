// ignore_for_file: use_build_context_synchronously

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/core/services/shared_preference_manager.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/models/course_model.dart';
import 'package:GermAc/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isGermAcVisible = false;
  int state = IDLE_STATE;
  String errorMessage = '';
  String message = '';
  List<String> sliderImagesPath = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg',
    'assets/images/slider4.jpg',
    'assets/images/slider5.jpg',
    'assets/images/slider6.jpg',
    'assets/images/slider8.jpg',
    'assets/images/slider9.jpg',
    'assets/images/slider10.jpg',
    'assets/images/slider11.jpg',
    'assets/images/slider12.jpg',
    'assets/images/slider13.jpg',
    'assets/images/slider14.jpg',
    'assets/images/slider15.jpg',
    'assets/images/slider16.jpg',
    'assets/images/slider17.jpg',
    'assets/images/slider18.jpg',
    'assets/images/slider19.jpg',
    'assets/images/slider20.jpg',
    'assets/images/slider21.jpg',
    'assets/images/slider22.jpg',
    'assets/images/slider23.jpg',
    'assets/images/slider24.jpg',
    'assets/images/slider25.jpg',
    'assets/images/slider26.jpg',
    'assets/images/slider27.jpg',
    'assets/images/slider28.jpg',
    'assets/images/slider29.jpg',
    'assets/images/slider30.jpg',
    'assets/images/slider31.jpg',
    'assets/images/slider32.jpg',
    'assets/images/slider33.jpg',
    'assets/images/slider34.jpg',
    'assets/images/slider35.jpg',
    'assets/images/slider36.jpg',
  ];
  List<CourseModel> courseModels = [];

  Future<void> getAllData(BuildContext context) async {
    state = LOADING_STATE; //loading

    final response =
        await DataLoader.getRequest(url: DataLoader.homePageCoursesURL);
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;
      List<dynamic> data = response.data?['courses'] ?? [];
      courseModels = data
          .map<CourseModel>((course) => CourseModel.fromMap(course))
          .toList();
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
    }

    notifyListeners();
  }

  Future<void> logout(BuildContext context, Map<String, dynamic> body) async {
    state = LOADING_STATE;
    isLoading = true;
    final response = await DataLoader.getRequest(
        url: DataLoader.logoutURL,
        headers: {'Authorization': 'Bearer ${SharedClass.userToken}'});
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;

      message = response.message;
      isLoading = false;
      await SharedPreferenceManager().delete();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("key");
      pref.remove("id");
      pref.remove("roleId");
      pref.remove("name");
      pref.remove("email");
      pref.remove("work");
      pref.remove("fcm_token");
      pref.remove("token");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(message),
        ),
      );

      Navigator.pushAndRemoveUntil(
          context, Utils.createRoute(const LoginPage()), (route) => false);
    } else {
      state = ERROR_STATE;
      isLoading = false;

      message = response.message;
    }

    notifyListeners();
  }
}
