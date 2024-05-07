import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_management/presentation/Splash/splash.dart';
import 'package:project_management/resource/ColorManger.dart';
import 'package:project_management/resource/StringManger.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringManger.app_name,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorManger.p_softBlue),
        useMaterial3: true,
      ),
      home: splashView(),
    );
  }
}