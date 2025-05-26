import 'package:GermAc/core/network/data_loader.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../core/constant.dart';
import '../core/ustils.dart';

class PartnerPage extends StatefulWidget {
  const PartnerPage({super.key});

  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitPartnerForm() async {
    if (!_formKey.currentState!.validate()) return;

    final body = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "message": _messageController.text.trim(),
    };

    setState(() => _isLoading = true);

    try {
      final res = await http.post(
        Uri.parse("${DataLoader.baseUrl}/partners"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      setState(() => _isLoading = false);

      final jsonRes = jsonDecode(res.body);

      if (res.statusCode == 200 && jsonRes['success'] == true) {
        Utils.showSuccessSnackBar(
            context, tr("partner_form_sent_successfully"));
        _formKey.currentState!.reset();
      } else {
        // معالجة أخطاء الحقول المفصلة
        if (jsonRes['errors'] != null && jsonRes['errors'] is Map) {
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
      }
    } catch (e) {
      setState(() => _isLoading = false);
      Utils.showErrorSnackBar(context, tr("network_error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("become_a_partner"),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true, // or false, depending on your needs

      backgroundColor: const Color(0xff243253),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                tr("partner_intro"),
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: tr("name"),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? tr("please_enter_name")
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: tr("email"),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => !Utils.isEmailValid(value ?? '')
                    ? tr("the_email_is_invalid")
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: tr("message"),
                  labelStyle: const TextStyle(color: Colors.white),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty
                    ? tr("please_enter_message")
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitPartnerForm,
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        tr("send"),
                        style: const TextStyle(
                            fontFamily: "Playfair Display",
                            color: Colors.white,
                            fontSize: 18),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
