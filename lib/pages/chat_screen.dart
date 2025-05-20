// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/models/shared_class.dart';
import 'package:GermAc/core/theme/palette.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'CHAT_SCREEN';

  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  late DatabaseReference db_Ref;
  @override
  void initState() {
    super.initState();
    // OneContext()
    //     .showProgressIndicator(builder: (_) => Utils.showLoadingWidget());
    db_Ref = FirebaseDatabase.instance
        .ref()
        .child('groupChats/${widget.chatId}/messages');

    db_Ref.onChildAdded.listen((event) {
      Map messageData = event.snapshot.value as Map;
      setState(() {
        _messages.add(ChatMessage(
          text: messageData['message'],
          sender: messageData['sender'],
        ));
      });
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    db_Ref
        .push()
        .set({
          'message': text,
          'sender': SharedClass.email,
        })
        .then((value) => log('sent successfully'))
        .onError((error, stackTrace) => log(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Chat')),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          const Divider(),
          Container(
            decoration: const BoxDecoration(color: Color(0xff243253)),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: const IconThemeData(color: Colors.white),
      child: Container(
        color: const Color(0xff243253),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: (text) {
                  _handleSubmitted(text); // Replace with the sender's ID
                },
                decoration: const InputDecoration.collapsed(
                    hintText: 'Send a message',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _handleSubmitted(_textController.text
                    .trim()); // Replace with the sender's ID
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    required this.text,
    required this.sender,
  });

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: SharedClass.email == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 10, color: Colors.brown.shade400),
          ),
          Material(
            elevation: 5,
            borderRadius: SharedClass.email == sender
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: SharedClass.email == sender ? secondaryColor : primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                '$text ',
                style: TextStyle(
                    fontSize: 16,
                    color: SharedClass.email == sender
                        ? primaryColor
                        : secondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
