import 'package:flutter/cupertino.dart';
import 'package:project_management/presentation/AddProject/addproject.dart';
import 'package:project_management/presentation/Auth/Login/login.dart';
import 'package:project_management/presentation/Auth/Signup/singup.dart';
import 'package:project_management/presentation/EditProject/EditProject.dart';
import 'package:project_management/presentation/Home/Main/main.dart';
import 'package:project_management/presentation/Home/home.dart';
import 'package:project_management/presentation/Settings/settings.dart';
import 'package:project_management/presentation/Splash/splash.dart';
import 'package:project_management/widget/MessageView.dart';

class ViewsManger{
  static Widget login_view = loginView();
  static Widget signup_view = signupView();
  static Widget home_view = homeView();
  static Widget splash_view = splashView();
  static Widget settings_view = settingsView();
  static Widget main_view = mainView();
  static Widget addproject_view = AddProjectView();

  static Widget editproject_view(dynamic obj){
    return EditProjectView(obj: obj,);
  }

  static Widget successful_view(bool fail, String message) {
    return MessageView(fail: fail,message: message);
  }
}