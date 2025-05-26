import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import '../core/constant.dart';
import '../core/ustils.dart';
import '../core/network/data_loader.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitFeedbackForm() async {
    if (!_formKey.currentState!.validate()) return;

    final body = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
      "subject": _subjectController.text.trim(),
      "message": _messageController.text.trim(),
    };

    setState(() => _isLoading = true);

    try {
      final res = await http.post(
        Uri.parse("${DataLoader.baseUrl}/feedback"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      setState(() => _isLoading = false);

      final jsonRes = jsonDecode(res.body);

      if (res.statusCode == 200 && jsonRes['success'] == true) {
        Utils.showSuccessSnackBar(context, tr("feedback_sent_successfully"));
        _formKey.currentState!.reset();
      } else if (jsonRes['errors'] != null && jsonRes['errors'] is Map) {
        final errors = jsonRes['errors'] as Map<String, dynamic>;
        final messages = errors.entries
            .expand((entry) => (entry.value as List).map((e) => "- $e"))
            .join("\n");

        Utils.showErrorSnackBar(context, messages);
      } else if (jsonRes['message'] != null) {
        Utils.showErrorSnackBar(context, jsonRes['message']);
      } else {
        Utils.showErrorSnackBar(context, tr("something_went_wrong"));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Utils.showErrorSnackBar(context, tr("network_error"));
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("feedback"),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff243253),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(tr("name")),
                validator: (value) => value == null || value.isEmpty
                    ? tr("please_enter_name")
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(tr("email")),
                validator: (value) => !Utils.isEmailValid(value ?? '')
                    ? tr("the_email_is_invalid")
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(tr("phone")),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration(tr("subject")),
                validator: (value) => value == null || value.isEmpty
                    ? tr("please_enter_subject")
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: _inputDecoration(tr("message")),
                validator: (value) => value == null || value.isEmpty
                    ? tr("please_enter_message")
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitFeedbackForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        tr("send"),
                        style: const TextStyle(
                            fontFamily: "Playfair Display",
                            color: Colors.white,
                            fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
