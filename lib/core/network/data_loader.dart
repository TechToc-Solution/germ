// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:http/http.dart' as http;
import 'package:GermAc/core/constant.dart';
import 'package:GermAc/models/api_respone_model.dart';
import 'package:http/io_client.dart';

class DataLoader {
  static String baseUrl = 'https://germ-ac.com/api';

  static String homePageCoursesURL = '$baseUrl/course/home';
  static String allCoursesURL = '$baseUrl/course';
  static String getCourseDetailsURL = '$baseUrl/course/show';
  static String contactURL = '$baseUrl/contact';
  static String getSectionsURL = '$baseUrl/sections';
  static String getSectionDetailsURL = '$baseUrl/section/show';
  static String storeFeedbackURL = '$baseUrl/feedback/store';
  static String bookMedicalTourismURL = '$baseUrl/tourism/store';
  static String getDoctorDetailsURL = '$baseUrl/doctor/show';
  //Auth
  static String loginURL = '$baseUrl/login';
  static String registerURL = '$baseUrl/register';
  static String logoutURL = '$baseUrl/logout';
  //
  static String getDoctorsInSectionURL = '$baseUrl/section/doctors';
  //store conversation
  static String storeConversationURL = '$baseUrl/conversation-store';

  static String showDoctorAppointmentsURL = '$baseUrl/getAppointments';
  static String bookAppointmentURL = '$baseUrl/bookAppointment';
  static String convUrl = '$baseUrl/conversations';
  static String paymentUrl = '$baseUrl/bookAppointment';
  static Future<ApiResponse> getRequest(
      {String? url,
      int? timeout = 30,
      Map<String, String> headers = const {
        'Content-Type': 'application/json'
      }}) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    Uri parsedUrl = Uri.parse(url!);
    try {
      print('************ body request ***********');
      print(url);
      print(headers);
      final response = await http
          .get(parsedUrl, headers: headers)
          .timeout(Duration(seconds: timeout!));

      log(name: 'POST_REQUEST_RESPONSE', response.body.toString());
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300 ||
          response.statusCode == 404) {
        return ApiResponse.fromJson({
          "code": "1",
          "message": decodedResponse['message'],
          "data": decodedResponse as Map<String, dynamic>
        });
      } else {
        print(response);
        return ApiResponse.fromJson({
          "code": GENERAL_ERROR_CODE,
          "message": decodedResponse['message'],
          "data": null,
        });
      }
    } on TimeoutException catch (e) {
      log(name: 'TimeoutException', e.toString());

      return ApiResponse.fromJson({
        "code": TIME_OUT_ERROR_CODE,
        "message": TIME_OUT_ERROR_MESSAGE,
        "data": null,
      });
    } on SocketException catch (e) {
      log(name: 'SOCKET_EXCEPTION_ERROR', e.toString());

      return ApiResponse.fromJson({
        "code": NO_INTERNET_CONNECTION_ERROR_CODE,
        "message": NO_INTERNET_CONNECTION_ERROR_MESSAGE,
        "data": null,
      });
    } catch (e) {
      print('error : + ${e.toString()}');

      log(name: 'POST_REQUEST_ERROR', e.toString());
      return ApiResponse.fromJson({
        "code": GENERAL_ERROR_CODE,
        "message": GENERAL_ERROR_MESSAGE,
        "data": null,
      });
    }
  }

  static Future<ApiResponse> postRequest({
    String? url,
    Map<String, dynamic>? body,
    int? timeout = 30,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  }) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    Uri parsedUrl = Uri.parse(url!);
    try {
      print('************ body request ***********');
      print('URL  $url');
      print('HEADERS : $headers');
      print('BODY: ${jsonEncode(body)}');

      final response = await http
          .post(parsedUrl, headers: headers, body: json.encode(body))
          .timeout(Duration(seconds: timeout!));
      log(name: 'POST_REQUEST_RESPONSE', response.body.toString());
      final decodedResponse = jsonDecode(response.body);
      log(name: 'RESPONSE_STATUS_CODE', response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.fromJson({
          "code": "1",
          "message": decodedResponse['message'] ?? SUCCESS_MESSAGE,
          "data": decodedResponse as Map<String, dynamic>
        });
      } else {
        return ApiResponse.fromJson({
          "code": GENERAL_ERROR_CODE,
          "message": decodedResponse['message'] ?? GENERAL_ERROR_MESSAGE,
          "data": decodedResponse,
        });
      }
    } on TimeoutException catch (e) {
      log(name: 'TimeoutException', e.toString());

      return ApiResponse.fromJson({
        "code": TIME_OUT_ERROR_CODE,
        "message": TIME_OUT_ERROR_MESSAGE,
        "data": null,
      });
    } on SocketException catch (e) {
      log(name: 'SOCKET_EXCEPTION_ERROR', e.toString());

      return ApiResponse.fromJson({
        "code": NO_INTERNET_CONNECTION_ERROR_CODE,
        "message": NO_INTERNET_CONNECTION_ERROR_MESSAGE,
        "data": null,
      });
    } catch (e) {
      print('error : + ${e.toString()}');

      log(name: 'POST_REQUEST_ERROR', e.toString());
      return ApiResponse.fromJson({
        "code": GENERAL_ERROR_CODE,
        "message": GENERAL_ERROR_MESSAGE,
        "data": null,
      });
    }
  }
}
