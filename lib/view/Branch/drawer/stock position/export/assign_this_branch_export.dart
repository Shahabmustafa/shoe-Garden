import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../viewmodel/branch/assign_stock/assign_stock_to_my_branch.dart';
import '../../../../../viewmodel/branch/stock_position/all_branch_stock_viewmodel.dart';
import '../../../../../viewmodel/user_preference/session_controller.dart';

class AssignThisBranchStockExport {
  final controller = Get.put(AssignStockToMyBranchViewModel());
  static const int rowsPerPage = 30;
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    // Define the title widget
    final title = pw.Align(
        alignment: pw.Alignment.topCenter,
        child: pw.Text(
          'Shoe Garden',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ));

    /// Define the sub title widget
    final subTitle = pw.Align(
        alignment: pw.Alignment.topCenter,
        child: pw.Text(
          'My Branch Stock Report',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ));
    /// Footer widget for session information (SessionController number and name)
    final footer = pw.Align(
      alignment: pw.Alignment.bottomCenter,
      child: pw.Column(
        children: [
          pw.Text(
            "Phone Number: ${SessionController.user.phoneNumber}",
            style: pw.TextStyle(fontSize: 12),
          ),
          pw.Text(
            "Address: ${SessionController.user.address}",
            style: pw.TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
    final List<pw.Widget> headers = [
      '#',
      'Product',
      'Company',
      'Brand',
      'Color',
      'Size',
      'Type',
      'Quantity',
      'Remaining Quantity',
    ]
        .map(
          (header) => pw.Padding(
        child: pw.Text(
          header,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 6,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
        padding: const pw.EdgeInsets.all(5),
      ),
    )
        .toList();

    // Create a list to hold table rows
    final List<List<String>> rows = [];
    for (int i = 0; i < controller.AssignStockToMyBranchList.value.body!.branchStocks!.length; i++) {
      final stock = controller.AssignStockToMyBranchList.value.body!.branchStocks![i];
      rows.add([
        "${i + 1}",
        (stock.product?.name ?? 'Null'),
        (stock.company?.name.toString() ?? 'Null'),
        (stock.brand?.name.toString() ?? 'Null'),
        (stock.color?.name?.toString() ?? 'Null'),
        (stock.size?.number.toString() ?? "Null"),
        (stock.type?.name ?? "Null"),
        (stock.quantity?.toString() ?? "Null"),
        (stock.remainingQuantity?.toString() ?? "Null"),
      ]);
    }

    // Add table to the PDF
// Split rows into pages
    for (int start = 0; start < rows.length; start += rowsPerPage) {
      final rowsForPage = rows.sublist(
          start,
          (start + rowsPerPage > rows.length)
              ? rows.length
              : start + rowsPerPage);

      pdf.addPage(
        pw.Page(
          margin: const pw.EdgeInsets.all(15),
          build: (pw.Context context) {
            return pw.Column(
              children: [
                title,
                pw.SizedBox(height: 10),
                subTitle,
                pw.SizedBox(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey),
                  children: [
                    pw.TableRow(
                      children: headers,
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.black,
                      ),
                    ),
                    ...rowsForPage.map(
                          (row) => pw.TableRow(
                        children: row
                            .map(
                              (cellData) => pw.Expanded(
                            flex: 1,
                            child: pw.Padding(
                              child: pw.Text(
                                textAlign: pw.TextAlign.center,
                                cellData,
                                style: const pw.TextStyle(
                                    fontSize: 6, color: PdfColors.black),
                              ),
                              padding: const pw.EdgeInsets.all(5),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Total Item Remaining Quantity"),
                    pw.Text(controller.AssignStockToMyBranchList.value.body?.sumOfQuantity.toString() ?? "0"),
                    pw.Text("Total Item Sale Price"),
                    pw.Text(controller.AssignStockToMyBranchList.value.body?.sumOfSalePrice.toString() ?? "0"),
                  ],
                ),
                /// Add footer only on the last page
                if (start + rowsForPage.length >= rows.length) ...[
                  pw.Spacer(),
                  footer,
                ],
              ],
            );
          },
        ),
      );
    }

    // Save the PDF as bytes
    return pdf.save();
  }

  Future<void> printPdf() async {
    // Generate the PDF
    final Uint8List bytes = await generatePdf();

    // Print the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => bytes,
    );
  }
}
