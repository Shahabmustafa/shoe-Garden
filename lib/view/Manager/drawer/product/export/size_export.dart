import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sofi_shoes/viewmodel/admin/product/size_viewmodel.dart';

import '../../../../../viewmodel/user_preference/session_controller.dart';

class SizeExport {
  final controller = Get.put(SizeViewModel());
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

    // Define the sub title widget
    final subTitle = pw.Align(
        alignment: pw.Alignment.topCenter,
        child: pw.Text(
          'Size Report',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.black,
          ),
        ));
// Footer widget for session information (SessionController number and name)
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
    // Create a list to hold table headers
    final List<pw.Widget> headers = [
      '#',
      'Size Number',
    ]
        .map((header) => pw.Padding(
            child: pw.Text(header,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white)),
            padding: const pw.EdgeInsets.all(5)))
        .toList();

    // Create a list to hold table rows
    final List<List<String>> rows = [];
    for (int i = 0; i < controller.sizeList.value.body!.sizes!.length; i++) {
      final size = controller.sizeList.value.body!.sizes![i];
      rows.add([
        "${i + 1}",
        (size.number.toString() ?? 'Null'),
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
                // Add footer only on the last page
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