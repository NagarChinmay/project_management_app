import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_management/resource/MethodManger.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/TextManger.dart';
import 'package:project_management/resource/TimerManger.dart';

class splashView extends StatefulWidget {
  const splashView({super.key});

  @override
  State<splashView> createState() => _splashViewState();
}

class _splashViewState extends State<splashView> {
  @override
  void initState() {
    Timer(
      TimerManger.splashTime,
      () => MethodManger.CheckAuth(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Center(
          child: Image.asset(StringManger.path_img1),
        ),
      ),
    );
  }
}
