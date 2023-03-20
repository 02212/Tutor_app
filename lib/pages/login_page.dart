import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_tut/pages/register_page.dart';
import 'package:video_tut/services/auth_services.dart';
import 'package:video_tut/services/database_services.dart';
import 'package:video_tut/shared/constants.dart';
import 'package:video_tut/pages/video_info.dart';
import 'package:video_tut/widgets.dart';
import '../helper/helper_function.dart';
import 'home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../shared/colors.dart' as color;
import 'dart:ui';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Peeps",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login Now To join your class",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset("img/communication.png"),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email,
                                  color: color.AppColor
                                      .gradientFirst) /*Theme.of(context).primaryColor)*/),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                              print(email);
                            });
                          },
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please Enter A valid Email";
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock,
                                  color: Theme.of(context).primaryColor)),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else if (val.isEmpty) {
                              return "Please Enter password";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                            //validate password
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "SignIn",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                            text: "Don't have an account ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Register here",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 36, 138, 151),
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, RegisterPage());
                                  },
                              ),
                            ])),
                      ],
                    ),
                  ),
                ),
              ));
  }

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authServices
          .loginUserWithEmailPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot = await DatabaseService(
                  userID: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullname']);
          await HelperFunction.saveUserEmailSF(email);
          nextScreenReplacement(context, HomePage());
        } else {
          showSnackbar(
            context,
            color.AppColor.homePageDetail,
            value,
          );
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
