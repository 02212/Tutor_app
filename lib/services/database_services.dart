import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? userID;
  DatabaseService({this.userID});
  //reference to the
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  //updating the user data
  Future updateUserData(
    String fName,
    String email,
  ) async {
    return await userCollection.doc(userID).set({
      "firstName": fName,
      "email": email,
      "groups": [],
      "profile": "",
      "uid": userID
    });
  }

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
