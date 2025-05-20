import 'package:flutter/material.dart';

class TourismRequestField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hinttext;
  const TourismRequestField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Playfair Display"),
        ),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hinttext,
            fillColor: Colors.white,
            filled: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
        )
      ],
    );
  }
}
