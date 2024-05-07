import 'dart:convert';
import 'package:project_management/model/logModel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../Export/save_file.dart';

class ExcelFile {
  List<dynamic> newObjectDataList;
  String NameString;
  ExcelFile(this.newObjectDataList,this.NameString);

  Future<void> getExcelFile() async {
    //Creating a workbook.
    final Workbook workbook = Workbook(0);
    //Adding a Sheet with name to workbook.
    final Worksheet sheet1 = workbook.worksheets.addWithName('Report');
    sheet1.showGridlines = false;
    sheet1.protect("password");
    sheet1.getRangeByName('A1').setText('No');
    sheet1.getRangeByName('A1').columnWidth = 5;

    sheet1.getRangeByName('B1').setText('Date');
    sheet1.getRangeByName('B1').autoFit();

    sheet1.getRangeByName('C1').setText('Time');
    sheet1.getRangeByName('C1').autoFit();

    sheet1.getRangeByName('D1').setText('Initial');
    sheet1.getRangeByName('D1').autoFit();

    sheet1.getRangeByName('E1').setText('Left');
    sheet1.getRangeByName('E1').autoFit();

    var length = newObjectDataList.length+1;
    newObjectDataList.forEach((element) {
      logModel newModel = element;
      var index = newObjectDataList.indexOf(element);
      if (true) {
        sheet1.getRangeByName('A${index + 2}').setText("${index + 1}");
        sheet1.getRangeByName('A${index + 2}').autoFit();

        sheet1.getRangeByName('B${index + 2}').setText(DateTime(
            newModel.key.year,
            newModel.key.month,
            newModel.key.day,
            newModel.key.hour,
            newModel.key.minute,
            newModel.key.second)
            .toIso8601String()
            .split("T")
            .first);
        sheet1.getRangeByName('B${index + 2}').autoFit();

        sheet1.getRangeByName('C${index + 2}').setText(DateTime(
            newModel.key.year,
            newModel.key.month,
            newModel.key.day,
            newModel.key.hour,
            newModel.key.minute,
            newModel.key.second)
            .toIso8601String()
            .split("T")
            .last);
      }
      sheet1.getRangeByName('C${index + 2}').autoFit();

      sheet1.getRangeByName('D${index + 2}').setText("${newModel.value["inithr"] + 1}");
      //sheet1.getRangeByName('D${index + 2}').autoFit();

      sheet1.getRangeByName('E${index + 2}').setText("${newModel.value["currenthr"] + 1}");
      //sheet1.getRangeByName('E${index + 2}').autoFit();
    });

    ///Create a table with the data in a range
    final ExcelTable table = sheet1.tableCollection
        .create('Table1', sheet1.getRangeByName('A1:E' + length.toString()));

    ///Formatting table with a built-in style
    //table.builtInTableStyle = ExcelTableBuiltInStyle.tableStyleMedium1;
    table.showTotalRow = true;
    table.showFirstColumn = true;
    table.showBandedColumns = true;
    table.showBandedRows = true;

    final List<int> bytes = workbook.saveSync();
    workbook.dispose();

    //Launch file.
    if(NameString.isEmpty){
      await FileSaveHelper.saveAndLaunchFile(bytes, 'ProjectReport.xlsx');}
    else{
      await FileSaveHelper.saveAndLaunchFile(bytes, NameString);
    }
    newObjectDataList.clear();
  }
}