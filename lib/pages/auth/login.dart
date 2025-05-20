import 'package:GermAc/core/constant.dart';
import 'package:GermAc/core/ustils.dart';
import 'package:GermAc/pages/auth/register.dart';
import 'package:GermAc/providers/auth_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            tr("login"),
            style: const TextStyle(fontFamily: "Playfair Display"),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          foregroundColor: Colors.white,
        ),
        resizeToAvoidBottomInset: true, // or false, depending on your needs

        backgroundColor: Colors.green.shade50,
        body: Container(
          decoration: const BoxDecoration(color: Color(0xff243253)),
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.7,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Email',
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
                          decoration: InputDecoration(
                            // hintText: 'Enter your email',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr('password'),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Playfair Display",
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr('please_enter_your_password');
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            // hintText: 'Enter your password',
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
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController.text.length < 8) {
                            Utils.showErrorSnackBar(context,
                                tr('password_must_be_more_than_8_characters'));
                          } else if (!Utils.isEmailValid(
                              _emailController.text.trim())) {
                            Utils.showErrorSnackBar(
                                context, tr('the_email_is_invalid'));
                          } else {
                            _formKey.currentState!.save();

                            final body = {
                              'email': _emailController.text.trim(),
                              'password': _passwordController.text.trim()
                            };

                            authProvider.login(context, body);
                          }
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.redAccent)),
                      child: Container(
                        alignment: Alignment.center,
                        width: 90,
                        child: Text(
                          tr('login'),
                          style: const TextStyle(
                              fontFamily: "Playfair Display",
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                          text: tr('New here? '),
                          style: const TextStyle(
                              fontFamily: "Playfair Display",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: tr('register_now'),
                                style: TextStyle(
                                    fontFamily: "Playfair Display",
                                    color: Colors.redAccent.shade200,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.of(context).pushReplacement(
                                        Utils.createRoute(const SignUpPage()));
                                  })
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
