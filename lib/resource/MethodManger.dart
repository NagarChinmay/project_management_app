import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/ViewsManger.dart';

class MethodManger {


  static Future<bool> internetConnectionChecker() async {
    bool LocalInternet = await InternetConnectionChecker().hasConnection;
    return LocalInternet;
  }

  static Future<String> getAuthUUID() async{
    var currentUser = await FirebaseAuth.instance.currentUser;
    return currentUser!.uid;
  }

  static void CheckAuth(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Fluttertoast.showToast(
            msg: StringManger.firebaseAuthUserNotLogin,
            toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ViewsManger.login_view;
        }));
      } else {
        Fluttertoast.showToast(
            msg: StringManger.firebaseAuthUserLogin,
            toastLength: Toast.LENGTH_SHORT);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ViewsManger.home_view;
        }));
      }
    });
  }
}
