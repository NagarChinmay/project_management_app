import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_management/Function/excel.dart';
import 'package:project_management/model/logModel.dart';
import 'package:project_management/model/logprojectModel.dart';
import 'package:project_management/model/updateprojectModel.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/TextManger.dart';
import 'package:project_management/resource/ViewsManger.dart';
import 'package:project_management/widget/TextBoxHr.dart';
import 'package:uuid/uuid.dart';

class EditProjectView extends StatefulWidget {
  const EditProjectView({super.key, required this.obj});
  final dynamic obj;
  @override
  State<EditProjectView> createState() => _EditProjectViewState();
}

class _EditProjectViewState extends State<EditProjectView> {
  var data;
  TextEditingController hrTextController = TextEditingController();
  var UpdateValue = 0.0;
  @override
  void initState() {
    if (this.mounted) {
      setState(() {
        data = widget.obj;
      });
    }
    super.initState();
  }

  Widget Body_View() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "${widget.obj["name"]}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(23),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              StringManger.text_initial,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "${widget.obj["inithr"]}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(23),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              "Left",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              "${widget.obj["currenthr"]}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(23),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              "New-Left",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "${UpdateValue}",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(23),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              "Enter Hour's",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (i) {
                                    //print(double.parse(i))
                                    if (i.isNotEmpty) {
                                      if (double.parse(i) >= 0 &&
                                          widget.obj["currenthr"] >=
                                              double.parse(i)) {
                                        if (this.mounted) {
                                          setState(() {
                                            if (i.toString().length <= 4) {
                                              UpdateValue =
                                                  widget.obj["currenthr"] -
                                                      double.parse(i);
                                            }
                                          });
                                        }
                                      } else {
                                        if (this.mounted) {
                                          setState(() {
                                            UpdateValue = 0.0;
                                          });
                                        }
                                      }
                                    } else {
                                      if (this.mounted) {
                                        setState(() {
                                          UpdateValue = 0.0;
                                        });
                                      }
                                    }
                                  },
                                  controller: hrTextController,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.greenAccent)),
                onPressed: () async {
                  if (UpdateValue != 0) {
                    LogProjectModel newModel = LogProjectModel(
                        data["name"],
                        data["inithr"],
                        data["currenthr"],
                        data["id"],
                        data["createTime"],
                        DateTime.now().toIso8601String());
                    var uuid = Uuid();
                    var id = uuid.v1();
                    var currentUser = await FirebaseAuth.instance.currentUser;
                    DatabaseReference ref = FirebaseDatabase.instance.ref();
                    String userId = currentUser!.uid;
                    ref
                        .child(StringManger.path_projects_root_firebase +
                            "/" +
                            userId +
                            "/" +
                            StringManger.path_projects_firebase)
                        .child(data["id"])
                        .child("currenthr")
                        .set(UpdateValue)
                        .whenComplete(() {
                      ref
                          .child(StringManger.path_projects_root_firebase +
                              "/" +
                              userId +
                              "/" +
                              StringManger.path_projectsLog_firebase)
                          .child(id)
                          .set(newModel.toJson())
                          .whenComplete(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewsManger.successful_view(false,
                              StringManger.text_ProjectUpdateSuccessfull);
                        }));
                      });
                    });
                  } else {
                    var uuid = Uuid();
                    var id = uuid.v1();
                    UpdateProjectModel newModel = UpdateProjectModel(
                        id,
                        data["name"],
                        data["inithr"],
                        data["createTime"],
                        DateTime.now().toIso8601String());
                    var currentUser = await FirebaseAuth.instance.currentUser;
                    DatabaseReference ref = FirebaseDatabase.instance.ref();
                    String userId = currentUser!.uid;
                    ref
                        .child(StringManger.path_projects_root_firebase +
                            "/" +
                            userId +
                            "/" +
                            StringManger.path_projectsHistory_firebase)
                        .child(id)
                        .set(newModel.toJson())
                        .whenComplete(() {
                      ref
                          .child(StringManger.path_projects_root_firebase +
                              "/" +
                              userId +
                              "/" +
                              StringManger.path_projects_firebase)
                          .child(data["id"])
                          .remove()
                          .whenComplete(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ViewsManger.successful_view(false,
                              StringManger.text_ProjectUpdateSuccessfull);
                        }));
                      });
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(StringManger.text_update),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.done_all_outlined)
                  ],
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            StringManger.app_editproject_title,
            style: TextManger.title_appbar,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                   List<dynamic> total_object_list = [];
                  var currentUser = await FirebaseAuth.instance.currentUser;
                  DatabaseReference ref = FirebaseDatabase.instance.ref();
                  String userId = currentUser!.uid;
                  ref
                      .child(StringManger.path_projects_root_firebase)
                      .child(userId)
                      .child(StringManger.path_projectsLog_firebase).once().then((value){
                    Map RawData = value.snapshot.value as Map;
                    Iterable list_key = RawData.keys;
                    list_key.forEach((element) {
                      if(RawData[element]["id"] == data["id"]){
                        if(this.mounted){
                          setState(() {
                            logModel newLogModel = logModel(DateTime.parse(RawData[element]["updateTime"]), RawData[element]);
                            total_object_list.add(newLogModel);
                          });
                        }
                      }
                    });
                    print(total_object_list);
                    ExcelFile exfile = ExcelFile(total_object_list, data["name"]+"-Report"+".xlsx");
                    exfile.getExcelFile();
                  });
                },
                icon: Icon(Icons.file_copy_sharp))
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body:
            Body_View() /*Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 5),child: Text(data["name"],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
            TextBoxHr(label: StringManger.,)
          ],
        ),
      )*/
        );
  }
}
