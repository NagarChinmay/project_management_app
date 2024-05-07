///Dart import
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

///Package imports
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: avoid_classes_with_only_static_members
///To save the Excel file in the device
class FileSaveHelper {
  static const MethodChannel _platformCall = MethodChannel('launchFile');

  static Future<bool> getPermissions() async {
    bool gotPermissions = false;

    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var release =
        androidInfo.version.release; // Version number, example: Android 12
    var sdkInt = androidInfo.version.sdkInt; // SDK, example: 31
    var manufacturer = androidInfo.manufacturer;
    var model = androidInfo.model;

    print('Android $release (SDK $sdkInt), $manufacturer $model');

    if (Platform.isAndroid) {
      var storage = await Permission.storage.status;
      if (storage != PermissionStatus.granted) {
        await Permission.storage.request();
      }

      if (sdkInt > 30 && sdkInt < 30) {
        var storage_external = await Permission.manageExternalStorage.status;

        if (storage_external != PermissionStatus.granted) {
          await Permission.manageExternalStorage.request();
        }

        storage_external = await Permission.manageExternalStorage.status;

        if (storage_external == PermissionStatus.granted &&
            storage == PermissionStatus.granted) {
          gotPermissions = true;
        }
      } else if(sdkInt >= 30){
        var storage_external = await Permission.manageExternalStorage.status;

        if (storage_external != PermissionStatus.granted) {
          await Permission.manageExternalStorage.request();
        }
        return true;
      }else {
        // (SDK < 30)
        storage = await Permission.storage.status;

        if (storage == PermissionStatus.granted) {
          gotPermissions = true;
        }
      }
    }

    return gotPermissions;
  }

  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    String? path;
    try {
      if (Platform.isAndroid) {
        final Directory? directory = await getExternalStorageDirectory();
        path = directory?.path;
      } else if (Platform.isIOS || Platform.isLinux || Platform.isWindows) {
        final Directory directory = await getApplicationSupportDirectory();
        path = directory.path;
      } else {
        path = await PathProviderPlatform.instance.getApplicationSupportPath();
      }
      final boolPermission = await getPermissions();
      if (boolPermission == true) {
        final File file =
        File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
        await file.writeAsBytes(bytes, flush: true).then((value) {
          Fluttertoast.showToast(msg: "File Created!");
          print('$path/$fileName');
          Fluttertoast.showToast(
              msg: '$path/$fileName', toastLength: Toast.LENGTH_LONG);
        });
        // Show a toast message with the file path
        // Try to open the file
        final result = await OpenFile.open('$path/$fileName');
        if (result.type != ResultType.done) {
          print('Error opening file: ${result.message}');
          Fluttertoast.showToast(
              msg: 'Error opening file: ${result.message}',
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(msg: "Permissions not Granted");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print('Error: $e');
      // Handle the error here (e.g., show a message to the user)
    }
  }
}