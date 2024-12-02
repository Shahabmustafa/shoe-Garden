import 'dart:typed_data';

import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sofi_shoes/res/terrms_conditions.dart';
import '../../../../../viewmodel/user_preference/session_controller.dart';
import 'package:flutter/services.dart' show rootBundle;


class InvoiceExport {
  final String? id;
  final DateTime? date;
  final Salesman? saleman;
  final Customer? customer;
  final List<InvoiceItem> items;
  final String total;
  final String paymentMethod;

  InvoiceExport({
    this.id,
    this.date,
    this.saleman,
    this.customer,
    required this.items,
    required this.total,
    required this.paymentMethod,
  });
}

class Salesman {
  final String? name;
  Salesman({this.name});
}

class Customer {
  final String? name;
  Customer({this.name});
}

class InvoiceItem {
  final String product;
  final String salePrice;
  final int qty;
  final String dis;
  final String subTotal;
  final String totalAmount;

  InvoiceItem({
    required this.product,
    required this.salePrice,
    required this.qty,
    required this.dis,
    required this.subTotal,
    required this.totalAmount,
  });
}

Future<void> generateInvoice(InvoiceExport invoice) async {
  final pdf = pw.Document();
  const pageWidth = 200.0;
  const pageHeight = double.infinity;

  final Uint8List imageBytes = await rootBundle.load('assets/images/logo.jpg').then((data) => data.buffer.asUint8List());

  final pw.MemoryImage image = pw.MemoryImage(imageBytes);

  final formattedDate = invoice.date != null
      ? DateFormat('yyyy-MM-dd HH:mm').format(invoice.date!)
      : "Null";
  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(30),
      pageFormat: PdfPageFormat(
        pageWidth,
        pageHeight,
        marginAll: 10,
      ),
      build: (pw.Context context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            pw.Center(
              child: pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Center(
                          child: pw.Image(image, width: 50, height: 50), // Adjust size as needed
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          "Shoe Garden",
                          style: pw.TextStyle(
                            fontSize: 8,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          "Phone Number: ${SessionController.user.phoneNumber ?? 'Unknown'}",
                          style: pw.TextStyle(fontSize: 4),
                        ), pw.Text(
                          "Address: ${SessionController.user.address ?? "Unknown"}",
                          style: pw.TextStyle(fontSize: 4),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Invoice: ${invoice.id ?? "Null"}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 4,
                              ),
                            ),
                            pw.Text(
                              "Payment Method: ${invoice.paymentMethod}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 4,
                              ),
                            ),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Salesman: ${invoice.saleman?.name ?? "Null"}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 4,
                              ),
                            ),
                            pw.Text(
                              "Customer: ${invoice.customer?.name ?? "Null"}",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Table.fromTextArray(
                      cellPadding: const pw.EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 3,
                      ),
                      cellAlignment: pw.Alignment.center,
                      headerStyle: pw.TextStyle(
                        fontSize: 4,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      headers: [
                        'Product',
                        'Sale Price',
                        'Qty',
                        'Discount',
                        'T.Amount',
                      ],
                      data: invoice.items.map((item) {
                        return [
                          item.product,
                          item.salePrice,
                          item.qty.toString(),
                          item.dis.toString(),
                          item.totalAmount.toString(),
                        ];
                      }).toList(),
                      cellStyle: pw.TextStyle(
                        fontSize: 3,
                        fontWeight: pw.FontWeight.normal,
                      ),
                      border: pw.TableBorder.all(
                        color: PdfColors.grey,
                        width: 0.1,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text(
                          "Total Amount: ${invoice.total}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 4,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text("Thank you for shopping!",
                      style: pw.TextStyle(fontSize: 4, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      "Date: $formattedDate",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Align Phone Number and Address at the bottom center
            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "TERMS & CONDITIONS",
                    style: pw.TextStyle(fontSize: 4, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(
                    height: 3,
                  ),
                  pw.Text(
                    TermsCondition.conditionText.toString(),
                    style: pw.TextStyle(fontSize: 4),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  // Save and download the PDF
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}




