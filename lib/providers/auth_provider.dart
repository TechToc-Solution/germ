// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/auth/login.dart';
import 'package:GermAc/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  int state = IDLE_STATE;
  String message = '';

  Future<void> login(BuildContext context, Map<String, dynamic> body) async {
    state = LOADING_STATE;
    isLoading = true;

    OneContext()
        .showProgressIndicator(builder: (_) => Utils.showLoadingWidget());
    final res = await http.post(Uri.parse(DataLoader.loginURL), body: body);
    Map<String, dynamic> data = jsonDecode(res.body);
    final h = data["user"];
    final response =
        await DataLoader.postRequest(url: DataLoader.loginURL, body: body);
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;
      OneContext().hideProgressIndicator();
      message = response.message;
      Utils.showSuccessSnackBar(context, message);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt("id", h["id"]);
      pref.setInt("roleId", h["role_id"]);
      pref.setString("name", h["name"] ?? "");
      pref.setString("email", h["email"] ?? "");
      pref.setString("work", h["work"] ?? "");
      pref.setString("fcm_token", h["fcm_token"] ?? "");
      pref.setString("token", data["token"] ?? "");
      SharedClass.userId = h['id'].toString();
      SharedClass.name = h['name'] ?? '';
      SharedClass.email = h['email'] ?? '';
      SharedClass.work = h['work'] ?? '';
      SharedClass.fcmToken = h['fcm_token'] ?? '';
      SharedClass.roleId = h['role_id'].toString();
      SharedClass.userToken = data['token'] ?? '';

      Navigator.pushAndRemoveUntil(
        context,
        Utils.createRoute(const HomePage()),
        (route) => false,
      );
    } else {
      state = ERROR_STATE;
      OneContext().hideProgressIndicator();
      isLoading = false;

      message = response.message;

      Utils.showErrorSnackBar(context, message);
    }

    notifyListeners();
  }

  Future<void> register(BuildContext context, Map<String, dynamic> body) async {
    state = LOADING_STATE;
    isLoading = true;
    OneContext()
        .showProgressIndicator(builder: (_) => Utils.showLoadingWidget());
    final response =
        await DataLoader.postRequest(url: DataLoader.registerURL, body: body);
    if (response.code == SUCCESS_CODE) {
      state = SUCCESS_STATE;
      OneContext().hideProgressIndicator();
      message = response.message;
      Utils.showSuccessSnackBar(context, message);

      Navigator.pushAndRemoveUntil(
        context,
        Utils.createRoute(const LoginPage()),
        (route) => false,
      );
      isLoading = false;
    } else {
      state = ERROR_STATE;
      OneContext().hideProgressIndicator();
      isLoading = false;

      message = response.message;

      Utils.showErrorSnackBar(context, message);
    }

    notifyListeners();
  }
}
