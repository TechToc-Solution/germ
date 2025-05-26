import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/pages/auth/ResetPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/ustils.dart';
import '../../core/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> sendResetRequest() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse("${DataLoader.baseUrl}/password/forgot"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": _emailController.text.trim()}),
      );

      final jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        Utils.showSuccessSnackBar(
            context, tr('check_email_for_reset_link_or_token'));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ResetPasswordPage(email: _emailController.text.trim()),
          ),
        );
      } else {
        Utils.showErrorSnackBar(
            context, jsonData['message'] ?? 'Error occurred');
      }
    } catch (e) {
      Utils.showErrorSnackBar(context, e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('forgot_password'),
          style: const TextStyle(fontFamily: "Playfair Display"),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: true, // or false, depending on your needs

      backgroundColor: const Color(0xff243253),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(tr("enter_your_email"),
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: (value) => value == null || value.isEmpty
                    ? tr('please_enter_your_email')
                    : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                onPressed: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          sendResetRequest();
                        }
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        tr("send_reset_link"),
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
