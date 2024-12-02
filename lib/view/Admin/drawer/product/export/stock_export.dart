import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sofi_shoes/viewmodel/admin/product/stock_inventory_viewmodel.dart';

import '../../../../../viewmodel/user_preference/session_controller.dart';

class StockExport {
  final StockInventoryViewModel controller = Get.put(StockInventoryViewModel());
  static const int rowsPerPage = 30;

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    // Define title and subtitle widgets
    final pw.Widget title = pw.Text(
      'Shoe Garden',
      textAlign: pw.TextAlign.center,
      style: pw.TextStyle(
        fontSize: 22, // Reduced font size to fit full page
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.black,
      ),
    );

    final pw.Widget subTitle = pw.Text(
      'Stock Inventory Report',
      textAlign: pw.TextAlign.center,
      style: pw.TextStyle(
        fontSize: 16, // Slightly reduced size
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.black,
      ),
    );
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
    // Create headers for the table
    final List<pw.Widget> headers = [
      '#',
      'Barcode',
      'Product',
      'Company',
      'Brand',
      'Color',
      'Type',
      'Size',
      'Quantity'
    ].map((header) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: pw.Text(
          header,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
          ),
        ),
      );
    }).toList();

    // Generate table rows
    final List<List<String>> rows = controller.stockInventoryList.value.body!.productStock!.asMap().entries.map((entry) {
      final index = entry.key;
      final stock = entry.value;
      return [
        "${index + 1}",
        stock.barcode ?? 'Null',
        stock.product?.name ?? 'Null',
        stock.company?.name ?? 'Null',
        stock.brand?.name ?? 'Null',
        stock.color?.name ?? 'Null',
        stock.type?.name ?? 'Null',
        stock.size?.number?.toString() ?? 'Null',
        stock.quantity?.toString() ?? 'Null',
      ];
    }).toList();

    // Add table pages
    for (int start = 0; start < rows.length; start += rowsPerPage) {
      final List<List<String>> rowsForPage = rows.sublist(
        start,
        start + rowsPerPage > rows.length ? rows.length : start + rowsPerPage,
      );

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

    // Return PDF bytes
    return pdf.save();
  }

  Future<void> printPdf() async {
    final Uint8List pdfBytes = await generatePdf();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }
}
