import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/models/course_model.dart';
import 'package:flutter/material.dart';

class CoursesProvider extends ChangeNotifier {
  List<CourseModel> courseModels = [];
  bool isLoading = false;
  int state = IDLE_STATE;
  String errorMessage = '';

  Future<void> getCourses(BuildContext context) async {
    isLoading = true;
    state = LOADING_STATE;
    final response = await DataLoader.getRequest(url: DataLoader.allCoursesURL);
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;

      Map<String, dynamic> data = response.data?['data'] ?? {};

      courseModels = data['courses']
          .map<CourseModel>(
              (jsonUserModel) => CourseModel.fromMap(jsonUserModel))
          .toList();
    } else {
      state = ERROR_STATE;
      errorMessage = response.message;
    }

    isLoading = false;

    notifyListeners();
  }
}
