import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;
  const MessageWidget(
      {super.key,
      required this.sender,
      required this.message,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 10,
              color: Colors.brown.shade400,
              fontFamily: "Playfair Display",
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
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
            color: isMe ? Colors.blue.shade700 : Colors.green.shade700,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Text(
                '$message ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: "Playfair Display",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
