import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

class PdfInvoice {
  Future<Uint8List> generateInvoicePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Text(
                'Hyper Drive Fashions',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                  '#167, Hyper Drive lane, 2nd Cross\nSobha Apartment Road, Sanpur ORR Bellandur\nBengaluru, Karnataka, 560103\nGSTIN: 4578425'),
              pw.SizedBox(height: 16),
              pw.Text('Customer: Anamika Deshpande'),
              pw.Text('Pyt. Type: Cash  Date: 12/07/2017'),
              pw.Text('BILL NO: Hyp/0042  CR: 01'),
              pw.SizedBox(height: 16),
              pw.Divider(),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Text('Item Name',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(
                      child: pw.Text('HSN',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(
                      child: pw.Text('Qty',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(
                      child: pw.Text('Basic Rate',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(
                      child: pw.Text('Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                ],
              ),
              pw.Divider(),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Cello Black Solid V')),
                  pw.Expanded(child: pw.Text('2323')),
                  pw.Expanded(child: pw.Text('2')),
                  pw.Expanded(child: pw.Text('847.46')),
                  pw.Expanded(child: pw.Text('1694.92')),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('PL Striped Blue V')),
                  pw.Expanded(child: pw.Text('2323')),
                  pw.Expanded(child: pw.Text('2')),
                  pw.Expanded(child: pw.Text('677.87')),
                  pw.Expanded(child: pw.Text('1355.85')),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Phosphorus Red S')),
                  pw.Expanded(child: pw.Text('2323')),
                  pw.Expanded(child: pw.Text('1')),
                  pw.Expanded(child: pw.Text('229.87')),
                  pw.Expanded(child: pw.Text('229.87')),
                ],
              ),
              pw.Divider(),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Text('CGST',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('274.58')),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Text('SGST',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('274.58')),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Text('CESS',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('0.00')),
                ],
              ),
              pw.Divider(),
              pw.Row(
                children: [
                  pw.Expanded(
                      child: pw.Text('Grand Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  pw.Expanded(child: pw.Text('4099.00')),
                ],
              ),
              pw.Spacer(),
              pw.Text('THANK YOU FOR SHOPPING'),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
