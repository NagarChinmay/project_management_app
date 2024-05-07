import 'package:flutter/material.dart';
import 'package:project_management/resource/ViewsManger.dart';

class TabManger {
  static int count = 2;
  static Widget buttomTabView =
      TabBarView(children: [ViewsManger.main_view, ViewsManger.settings_view]);
  static PreferredSizeWidget buttomTab = TabBar(
    tabs: [
      Tab(icon: Icon(Icons.home_filled)),
      Tab(icon: Icon(Icons.settings)),
    ],
  );
}
