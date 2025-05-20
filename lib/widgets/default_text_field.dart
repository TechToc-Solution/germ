// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatter;
  final String labelText;
  final int minLines;
  final int maxLines;
  bool isPassword;
  bool enabled;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  DefaultTextFiled(
      {super.key,
      this.inputFormatter,
      required this.controller,
      required this.labelText,
      required this.isPassword,
      required this.validator,
      required this.keyboardType,
      required this.minLines,
      required this.maxLines,
      this.enabled = true});

  @override
  State<DefaultTextFiled> createState() => _DefaultTextFiledState();
}

class _DefaultTextFiledState extends State<DefaultTextFiled> {
  final FocusNode focusNode = FocusNode();
  late final TextStyle labelStyle;
  void onFocusChange() {
    setState(() {
      labelStyle = focusNode.hasFocus
          ? const TextStyle(color: Colors.black)
          : const TextStyle(color: Colors.grey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 100.w, right: 100.w),
      child: TextFormField(
        enabled: widget.enabled,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        focusNode: focusNode,
        obscureText: widget.isPassword,
        inputFormatters: widget.inputFormatter,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          errorMaxLines: 2,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30),
          errorStyle: TextStyle(
            color: Colors.red,
            fontFamily: "Playfair Display",
            fontSize: 30.sp,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 38.sp,
            fontFamily: "Playfair Display",
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          border: const OutlineInputBorder(),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
