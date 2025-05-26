import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/network/data_loader.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/ustils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _tokenController = TextEditingController();

  bool _isLoading = false;

  Future<void> resetPassword() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.post(
        Uri.parse("${DataLoader.baseUrl}/password/reset"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "email": widget.email,
          "password": _passwordController.text,
          "password_confirmation": _confirmController.text,
          "token": _tokenController.text,
        }),
      );

      final jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        Utils.showSuccessSnackBar(context, tr('password_reset_success'));
        Navigator.popUntil(context, (route) => route.isFirst); // Back to login
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
          tr("reset_password"),
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
              TextFormField(
                controller: _tokenController,
                decoration: InputDecoration(labelText: tr('reset_token')),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: tr('new_password')),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmController,
                decoration:
                    InputDecoration(labelText: tr('confirm_new_password')),
                obscureText: true,
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
                          resetPassword();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
