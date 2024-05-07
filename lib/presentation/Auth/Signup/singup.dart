import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/TextManger.dart';
import 'package:project_management/resource/ViewsManger.dart';

class signupView extends StatefulWidget {
  const signupView({super.key});

  @override
  State<signupView> createState() => _signupViewState();
}

class _signupViewState extends State<signupView> {
  // define function for controller for email id and password
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  // define form key
  final formGlobalKey = GlobalKey<FormState>();

  // define function pass valid
  bool isPasswordValid(String inputpassword) => inputpassword.length == 6;

  // define function email valid
  bool isEmailValid(String inputemail) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regexp = RegExp(pattern);
    return regexp.hasMatch(inputemail);
  }

  @override
  void initState() {
    super.initState();
  }
  Widget BodyView(){
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Form(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringManger.text_signup.toUpperCase(),
                style: TextManger.title_body,
              ),
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: emailTextController,
                      validator: (email) {
                        if (isEmailValid(email!))
                          return null;
                        else
                          return StringManger.validatorTextFormFieldEmail;
                      },
                      decoration: InputDecoration(
                          labelText: StringManger.labelTextFormFieldEmail,
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      controller: passwordTextController,
                      validator: (password) {
                        if (isPasswordValid(password!))
                          return null;
                        else
                          return StringManger.validatorTextFormFieldPassword;
                      },
                      decoration: InputDecoration(
                          labelText: StringManger.labelTextFormFieldPassword,
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    if (emailTextController.value.text.isEmpty) {
                      Fluttertoast.showToast(msg: StringManger.toastMsgEmail);
                      return;
                    }
                    if (passwordTextController.value.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: StringManger.toastMsgPassword);
                      return;
                    }
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                          email: emailTextController.value.text,
                          password: passwordTextController.value.text)
                          .whenComplete(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return ViewsManger.home_view;
                            }));
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        Fluttertoast.showToast(
                            msg: StringManger.firebaseExceptionWeakPassword);
                      } else if (e.code == 'email-already-in-use') {
                        Fluttertoast.showToast(
                            msg: StringManger
                                .firebaseExceptionEmailAlreadyUse);
                      }
                    } catch (e) {
                      print(e);
                      Fluttertoast.showToast(msg: "${e}");
                    }
                  },
                  child: Text(StringManger.text_submit)),
              SizedBox(
                height: 50,
              ),
              Divider(indent: 40,endIndent: 40,),
              TextButton(
                  onPressed: () async {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return ViewsManger.login_view;
                        }));
                  },
                  child: Text(StringManger.text_login)),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BodyView(),
      ),
    );
  }
}
