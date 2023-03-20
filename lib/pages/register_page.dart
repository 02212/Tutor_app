import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_tut/helper/helper_function.dart';
import 'package:video_tut/pages/home_page.dart';
import 'package:video_tut/pages/login_page.dart';
import 'package:video_tut/services/auth_services.dart';
import '../shared/colors.dart' as color;
import '../widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String rePassword = '';
  String fName = '';
  String lName = '';
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ))
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
                          "Join our community and make your dreams possible",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset("img/programming.png"),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "First Name",
                              prefixIcon: Icon(Icons.person,
                                  color: color.AppColor
                                      .gradientFirst) /*Theme.of(context).primaryColor)*/),
                          onChanged: (val) {
                            setState(() {
                              fName = val;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your first name";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "Last Name",
                              prefixIcon: Icon(Icons.person,
                                  color: color.AppColor
                                      .gradientFirst) /*Theme.of(context).primaryColor)*/),
                          onChanged: (val) {
                            setState(() {
                              lName = val;
                            });
                          },
                        ),
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Re-Enter Password",
                              prefixIcon: Icon(Icons.lock,
                                  color: Theme.of(context).primaryColor)),
                          validator: (val) {
                            if (val != password) {
                              return "Password must be at least 6 characters";
                            } else if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Please Enter password";
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
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Login here",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 36, 138, 151),
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreen(context, LoginPage());
                                  },
                              ),
                            ])),
                      ],
                    ),
                  ),
                ),
              ));
  }

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authServices
          .registerUserWithEmailPassword(
              fName, lName, email, password, rePassword)
          .then((value) async {
        if (value == true) {
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(fName);
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
