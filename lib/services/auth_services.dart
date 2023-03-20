import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_tut/helper/helper_function.dart';
import 'package:video_tut/services/database_services.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login func
  Future loginUserWithEmailPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register func
  Future registerUserWithEmailPassword(String fName, String lName, String email,
      String password, String rePassword) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseService(userID: user.uid).updateUserData(fName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserNameSF("");
      await HelperFunction.saveUserEmailSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
