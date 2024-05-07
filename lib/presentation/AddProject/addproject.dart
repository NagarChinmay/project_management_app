import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_management/model/projectModel.dart';
import 'package:project_management/resource/StringManger.dart';
import 'package:project_management/resource/ViewsManger.dart';
import 'package:uuid/uuid.dart';

class AddProjectView extends StatefulWidget {
  const AddProjectView({super.key});

  @override
  State<AddProjectView> createState() => _AddProjectViewState();
}

class _AddProjectViewState extends State<AddProjectView> {
  // define Text Controller
  TextEditingController projectName = TextEditingController();
  // define Text Controller -> Total Hour
  TextEditingController projectTotalHour = TextEditingController();
  // define bool for loading screen
  bool SetToFirebase = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(StringManger.app_addproject_title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
      ),
      body: SetToFirebase == false
          ? Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          controller: projectName,
                          decoration: InputDecoration(
                              labelText: StringManger.label_ProjectName,
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
                          controller: projectTotalHour,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: StringManger.label_ProjectHour,
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.greenAccent)),
                      onPressed: () async {
                        if (projectName.value.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: StringManger.toastMsgProjectName);
                          return;
                        }
                        if (projectTotalHour.value.text.trim().isEmpty) {
                          Fluttertoast.showToast(
                              msg: StringManger.toastMsgProjectHour);
                          return;
                        }
                        var uuid = Uuid();
                        var id = uuid.v1();
                        ProjectModel RawDataModel = ProjectModel(
                            projectName.value.text.trim().toUpperCase(),
                            double.parse(projectTotalHour.value.text.trim()),
                            double.parse(projectTotalHour.value.text.trim()),
                            id,
                            DateTime.now().toIso8601String());
                        print(RawDataModel.toJson());
                        var currentUser =
                            await FirebaseAuth.instance.currentUser;
                        DatabaseReference ref = FirebaseDatabase.instance
                            .ref();
                        String userId = currentUser!.uid;
                        print(userId);
                        if (this.mounted) {
                          setState(() {
                            SetToFirebase = true;
                          });
                        }
                        ref
                            .child(StringManger.path_projects_root_firebase+"/"+userId+"/"+StringManger.path_projects_firebase)
                            .child(id)
                            .set(RawDataModel.toJson())
                            .whenComplete(() {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return ViewsManger.successful_view(
                                false, StringManger.text_ProjectAddSuccessfull);
                          }));
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(StringManger.text_done),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.done)
                        ],
                      ))
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
