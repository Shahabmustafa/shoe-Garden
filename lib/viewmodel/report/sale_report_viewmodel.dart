import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/sale_report_model.dart';

import '../../../date/response/status.dart';
import '../../date/repository/admin/report/sale_report_rep.dart';

class SaleReportViewModel extends GetxController {
  final startDate = TextEditingController().obs;

  final endDate = TextEditingController().obs;

  RxBool loading = false.obs;
  final RxString selectBranchName = ''.obs;
  final RxString selectWarehouseName = ''.obs;

  final _api = SaleReportRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final saleList = ASaleReportModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSale(ASaleReportModel value) => saleList.value = value;
  void setError(String value) => error.value = value;

  void getSaleReport() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text
    };
    _api.getSaleReport(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSale(value);
      print(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text
    };
    _api.getSaleReport(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSale(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        if (isStartDate) {
          startDate.value.text = DateFormat('yyyy-MM-dd').format(value);
        } else {
          endDate.value.text = DateFormat('yyyy-MM-dd').format(value);
          getSaleReport();
        }
      }
    });
  }
}
