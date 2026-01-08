import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mingle/components/mingle-button.dart';
import 'package:mingle/components/mingle-title.dart';
import 'package:mingle/screens/login/register-upload-dp.dart';
import 'package:mingle/styles/colors.dart';
import 'package:mingle/styles/login-register-bg.dart';
import 'package:mingle/styles/widget-styles.dart';
import 'package:mingle/utils/form-validator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginRegisterBg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.05),
            mingleTitle(size: 64),
            Text(
              "Sign Up For Free.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "Fashionable and professional pre-loved",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: height * 0.10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: textFieldDeco.copyWith(hintText: "Name"),
                    validator: (value) => FormValidator.isEmpty(value, "name"),
                  ),
                  SizedBox(height: height * 0.033),
                  TextFormField(
                    autofillHints: [AutofillHints.email],
                    controller: email,
                    decoration: textFieldDeco.copyWith(hintText: "Email"),
                    validator: FormValidator.validateEmail,
                  ),
                  SizedBox(height: height * 0.033),
                  TextFormField(
                    obscureText: !passwordVisible,
                    controller: password,
                    decoration: textFieldDeco.copyWith(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: passwordVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        color: passwordVisible ? secondary : grey,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                    ),
                    validator:
                        (value) => FormValidator.isEmpty(value, "password"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.033,
                horizontal: 0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: mingleButton(
                      text: "Sign Up",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Pass user data to RegisterUploadDP
                          Get.to(
                            RegisterUploadDP(
                              name: name.text,
                              email: email.text,
                              password: password.text,
                            ),
                            transition: pageTransitionStyle,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.18),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: "Login",
                    style: const TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }
}