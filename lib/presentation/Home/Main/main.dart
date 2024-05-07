import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_management/resource/MethodManger.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/ViewsManger.dart';

class mainView extends StatefulWidget {
  const mainView({super.key});

  @override
  State<mainView> createState() => _mainViewState();
}

class _mainViewState extends State<mainView> {
  bool internet = false;
  var userUUID;
  List<dynamic> Projectlist = [];

  @override
  void initState() {
    MethodManger.getAuthUUID().then((value) {
      if (this.mounted) {
        setState(() {
          userUUID = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MethodManger.internetConnectionChecker().then((value) {
      if (this.mounted) {
        setState(() {
          internet = value;
        });
      }
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: internet == true
            ? Projectlist.isEmpty
                ? StreamBuilder(
                    stream: FirebaseDatabase()
                        .reference()
                        .child(StringManger.path_projects_root_firebase)
                        .child(userUUID +
                            "/" +
                            StringManger.path_projects_firebase)
                        .onValue,
                    builder: (context, snap) {
                      if (snap.hasData &&
                          !snap.hasError &&
                          snap.data!.snapshot.value != null) {
                        Map data = snap.data!.snapshot.value as Map;
                        List item = [];
                        data.forEach((key, value) {
                          item.add(value);
                        });
                        //print(item[0]);
                        return ListView.builder(
                          itemCount: item.length,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 100,
                              child: Card(
                                child: Center(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(context,
                              MaterialPageRoute (builder: (context) {return ViewsManger.editproject_view(item[index]);})
                          );
                                    },
                                    leading: Icon(
                                      Icons.rocket_launch,
                                      size: 40,
                                    ),
                                    title: Text(
                                      "${item[index]["name"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    trailing: Wrap(
                                      children: [
                                        Column(
                                          children: [
                                            Text("Initial"),
                                            Text(
                                                "${item[index]["inithr"] != null ? item[index]["inithr"] : 0}")
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Text("Left"),
                                            Text(
                                                "${item[index]["currenthr"] != null ? item[index]["currenthr"] : 0}"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else
                        return Center(
                          child: Text(StringManger.text_NoProjectFound),
                        );
                    },
                  )
                : Card()
            : Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sentiment_very_dissatisfied,
                          size: 150,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      width: MediaQuery.sizeOf(context).width,
                      height: 30,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          StringManger.text_NoInternet,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
      floatingActionButton: internet == true
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewsManger.addproject_view;
                }));
              },
              child: Icon(
                Icons.add,
                size: 30,
                weight: 50,
              ),
            )
          : null,
    );
  }
}
