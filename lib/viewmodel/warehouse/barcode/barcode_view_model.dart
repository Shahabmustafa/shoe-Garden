import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sofi_shoes/model/warehouse/barcode_generater_model.dart';

import '../../../date/repository/warehouse/barcode/barcode_generator_repo.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class BarcodViewModel extends GetxController {
  final search = TextEditingController().obs;

  /// repository
  final _api = WBarcodeGeneratorRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final barcodeList = BarcodeModel().obs;

  RxString error = ''.obs;
  RxString generatedBarcode = ''.obs;
  RxString barcodeText = ''.obs;
  final TextEditingController barcodeController = TextEditingController();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setClaimStockList(BarcodeModel value) => barcodeList.value = value;
  void setError(String value) => error.value = value;

  /// get all data assign stock to warehouse
  void getBarcode() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setClaimStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setClaimStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void generateBarcode() async {
    try {
      loading.value = true;
      Map data = {};
      await _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getBarcode();
          Utils.SuccessToastMessage('Generate Barcode successfully');
          generatedBarcode.value = value['body']['barcode'] ?? '';
          barcodeController.text = generatedBarcode.value;
          print(value['body']['barcode']);
        } else {
          Utils.ErrorToastMessage(value['error']);
          print(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
      print(e.toString());
    }
  }

  void deleteBarcode(String id) {
    _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage("Deleted Barcode");
        Get.back();
      } else {
        Utils.ErrorToastMessage("Something error");
      }
      getBarcode();
    }).onError((error, stackTrace) {
      Utils.ErrorToastMessage(error.toString());
    });
  }

  void printBarcode(BuildContext context, String? barcodeData, String? articalN,
      String? colorN, String? sizeN) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Padding(
              padding: const pw.EdgeInsets.all(5), // Adding some padding

              child: pw.Center(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Artical: ${articalN}',
                      style: pw.TextStyle(
                        fontSize: 12, // Smaller font size
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5), // Smaller space between elements
                    pw.Text(
                      'Size: ${sizeN}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10), // Space before the barcode
                    pw.BarcodeWidget(
                      data: barcodeData!,
                      barcode: pw.Barcode.ean13(),
                      width: 120, // Reduced width to fit the small page
                      height: 40, // Reduced height for a more compact barcode
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Color: ${colorN}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  // void printBarcode(BuildContext context, String barcodeData) async {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(build: (context) {
  //       return pw.Column(
  //           mainAxisAlignment: pw.MainAxisAlignment.center,
  //           children: [
  //             pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Text(
  //                     'Product Name: xyz',
  //                     style: pw.TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     'Size: xyz',
  //                     style: pw.TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                 ]),
  //             pw.SizedBox(height: 10),
  //             pw.BarcodeWidget(
  //               data: barcodeData,
  //               barcode: pw.Barcode.ean13(),
  //               width: 200,
  //               height: 80,
  //             ),
  //             pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Text(
  //                     'Color: black',
  //                     style: pw.TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Text(
  //                     'Size: male',
  //                     style: pw.TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                 ]),
  //           ]);
  //     }),
  //   );

  //   await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => pdf.save());
  // }

  @override
  void onInit() {
    super.onInit();
    getBarcode();
  }
}
