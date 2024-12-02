import 'package:excel/excel.dart';

class ExcelController {
  exportToExcel() {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet()];
    sheet!.setColumnWidth(2, 50);
    sheet.setColumnAutoFit(3);
    excel.save();
  }
}
