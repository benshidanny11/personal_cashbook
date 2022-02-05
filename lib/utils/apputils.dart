import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUtils {
  static final _firestore = FirebaseFirestore.instance;
  static String getSuBEmail(String email) {
    String returnValue = "";
    for (var i = 0; i < email.length; i++) {
      if (email[i] == '@') {
        returnValue = email.substring(0, i);
      }
    }
    return returnValue;
  }



  static String getUserEmail() {
    var userEmail = FirebaseAuth.instance.currentUser!.email;
    return userEmail!;
  }
}
