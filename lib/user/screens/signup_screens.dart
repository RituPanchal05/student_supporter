import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_supporter/common/widgets/custom_button.dart';
import 'package:student_supporter/common/widgets/custom_textfield.dart';
import 'package:student_supporter/constants/globalVariables.dart';
import 'package:student_supporter/user/services/signup_Services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final signUpServices signUpservices = signUpServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
  }

  void signInUser() {
    signUpservices.signUpUser(context: context, email: _emailController.text, name: _nameController.text);
  }

  void LogInUser() {
    signUpservices.LogInUser(context: context, email: _emailController.text, name: _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: GlobalVariables.backColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter, // Align at the top
              child: Image.asset(
                'Asset/back.png',
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "STUDENET SUPPORTER",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          customTextField(
                            controller: _nameController,
                            obSecureChar: false,
                            hintText: 'Name',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          customTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            obSecureChar: false,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          customButton(
                            text: 'sign Up',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: const Text("Already Have an Account then Login"),
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                LogInUser();
                              }
                            },
                          ),
                          // customButton(
                          //   text: 'LogIn',
                          //   onTap: () {
                          //     if (_signInFormKey.currentState!.validate()) {
                          //       LogInUser();
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
