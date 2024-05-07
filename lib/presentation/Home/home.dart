import 'package:flutter/material.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/TabManger.dart';
import 'package:project_management/resource/TextManger.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: TabManger.count,
        child: Scaffold(
          appBar: AppBar(
            actionsIconTheme: IconThemeData(color: Colors.transparent),
            centerTitle: true,
            title: Text(
              StringManger.app_home_title,
              style: TextManger.title_appbar,
            ),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: TabManger.buttomTabView,
          bottomNavigationBar: TabManger.buttomTab,
        ));
  }
}
