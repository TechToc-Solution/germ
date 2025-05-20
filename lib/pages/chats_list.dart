// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/network/conversations_loader.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr("Chats"),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Playfair Display",
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: getConversations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> details = {};
                  for (var i = 0; i < 2; i++) {
                    if (snapshot.data![index]["participants"][i]["user"] !=
                        null) {
                      details =
                          snapshot.data![index]["participants"][i]["user"];
                      break;
                    }
                  }
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        isloading = true;
                      });
                      try {
                        http.Response response = await http.post(
                            Uri.parse(
                                "https://germ-ac.com/api/store-doctor-user/${details["id"]}"),
                            headers: {
                              'Content-Type': 'application/json',
                              "Authorization":
                                  'Bearer ${SharedClass.userToken}',
                            });
                        print(response.body);
                        if (response.statusCode == 200) {
                          Map<String, dynamic> m = jsonDecode(response.body);
                          launchUrl(Uri.parse(m["url"]));
                          setState(() {
                            isloading = false;
                          });
                        } else {
                          Utils.showErrorSnackBar(
                              context, "Something went error");
                          setState(() {
                            isloading = false;
                          });
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: ChatBox(
                      name: details["name"],
                      date:
                          "${details["updated_at"].toString().substring(0, 10)} ${details["updated_at"].toString().substring(11, 16)}",
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ChatBox extends StatelessWidget {
  ChatBox({super.key, required this.name, required this.date});
  String name, date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 0,
          thickness: 5,
          color: AppColors.mainColor,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: 100,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundColor: AppColors.mainColor,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 24,
                        color: AppColors.mainColor,
                        fontFamily: "Playfair Display",
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(date,
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.mainColor,
                          fontFamily: "Playfair Display",
                          fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
        Divider(
          height: 0,
          thickness: 5,
          color: AppColors.mainColor,
        ),
      ],
    );
  }
}
