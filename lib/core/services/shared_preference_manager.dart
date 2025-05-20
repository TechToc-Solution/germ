/// Created by Loayho at 28/May/2022

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  Future<void> write() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      Map<String, dynamic> userData = SharedClass.toSharedPreference();
      var json = jsonEncode(userData);
      pref.setInt("id", userData["id"]);
      pref.setInt("roleId", userData["role_id"]);
      pref.setString("name", userData["name"] ?? "");
      pref.setString("email", userData["email"] ?? "");
      pref.setString("work", userData["work"] ?? "");
      pref.setString("fcm_token", userData["fcm_token"] ?? "");
      pref.setString("token", userData["token"] ?? "");
      log(json, name: 'write method in shared pref manager');

      bool result = await pref.setString(USER_DATA_KEY, json);

      result
          ? print('[SHARED_PREFERENCE]: userData saved Successfully')
          : print(
              '[SHARED_PREFERENCE]: something went wrong during save userData');

      print(json);
    } catch (e) {
      print('[SHARED_PREFERENCE]: something went wrong during save userData');
      print(e.toString());
    }
  }

  Future<void> read() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      SharedClass.userId = pref.getInt("id").toString();
      SharedClass.name = pref.getString("name")!;
      SharedClass.email = pref.getString("email")!;
      SharedClass.roleId = pref.getInt("roleId").toString();
      SharedClass.fcmToken = pref.getString("fcm_token")!;
      SharedClass.userToken = pref.getString("token")!;
      SharedClass.work = pref.getString("work")!;
      if (pref.containsKey(USER_DATA_KEY)) {
        Map<String, dynamic> userData = {};

        String json = pref.get(USER_DATA_KEY).toString();
        log(json, name: 'read method in shared pref manager before decode');

        userData = jsonDecode(json);
        log(userData.toString(),
            name: 'read method in shared pref manager after decode');

        // copy To SharedClass
        SharedClass.fromSharedPreference(userData);

        print('[SHARED_PREFERENCE]: userData read Successfully with'
            ' The following: \n $userData');
      } else {
        // if no sharedPref exist like (first installation), write;
        print('[SHARED_PREFERENCE]: userData deosnt exist ');
        await write();
      }
    } catch (e, s) {
      print('[SHARED_PREFERENCE]: something went wrong during read userData');
      print(s);
      print(e.toString());
    }
  }

  Future<void> delete() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool result = await prefs.remove(USER_DATA_KEY);
      if (result) {
        SharedClass.userId = '';
        SharedClass.name = '';
        SharedClass.email = '';
        SharedClass.roleId = '';
        SharedClass.fcmToken = '';
        SharedClass.userToken = '';
        SharedClass.work = '';

        print('[SHARED_PREFERENCE]: userData removed Successfully');
      } else {
        print(
            '[SHARED_PREFERENCE]: something went wrong during remove userData ');
      }
    } catch (e) {
      print('[SHARED_PREFERENCE]: something went wrong during remove userData');
      print(e.toString());
    }
  }

  Future<void> updateProperty(
      {required String key, required dynamic value}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Map<String, dynamic> userData = {};
      String json = prefs.get(USER_DATA_KEY).toString();
      userData = jsonDecode(json);

      userData[key] = value;

      json = jsonEncode(userData);
      bool result = await prefs.setString(USER_DATA_KEY, json);

      if (result) {
        SharedClass.fromSharedPreference(userData);
        print('[SHARED_PREFERENCE]: $USER_DATA_KEY Edited Successfully with'
            ' The following: \n $userData');
      } else {
        print('something went wrong during edit $USER_DATA_KEY');
      }
    } catch (e) {
      print(
          '[SHARED_PREFERENCE]: something went wrong during EDIT $USER_DATA_KEY');
      print(e.toString());
    }
  }
}
