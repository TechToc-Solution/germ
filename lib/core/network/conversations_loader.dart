import 'dart:convert';

import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getConversations() async {
  http.Response response = await http.get(Uri.parse(DataLoader.convUrl),
      headers: {"Authorization": "Bearer ${SharedClass.userToken}"});
  if (response.statusCode == 200) {
    List h = jsonDecode(response.body)["conversations"];
    return h;
  } else {
    throw "request error";
  }
}
