import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:video_tut/helper/helper_function.dart';
import 'package:video_tut/shared/constants.dart';
import 'package:video_tut/pages/video_info.dart';
import 'pages/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp();
    options:
    FirebaseOptions(
        apiKey: constants.apiKey,
        appId: constants.appId,
        messagingSenderId: constants.messagingSenderId,
        projectId: constants.projectId);
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSingedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInState();
  }

  getUserLoggedInState() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSingedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Peeps',
      theme: ThemeData(
        primaryColor: constants().primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: _isSingedIn ? const HomePage() : const LoginPage(),
    );
  }
}
