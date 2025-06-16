import 'dart:developer';

import 'package:GermAc/core/network/data_loader.dart';
import 'package:GermAc/pages/auth/ResetPasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/models/shared_class.dart';
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
  final _passwordController = TextEditingController();
  final _passwordConfoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showPassword = true;
  Future<void> sendResetRequest() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse("${DataLoader.baseUrl}/password/forgot"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "email": _emailController.text.trim(),
        }),
      );
      log(response.body);
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('email'),
                    style: const TextStyle(
                        fontFamily: "Playfair Display",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return tr('please_enter_your_email');
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                        tr("reset_password"),
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
