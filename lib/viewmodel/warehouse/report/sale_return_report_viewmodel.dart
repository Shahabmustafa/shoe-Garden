

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../date/repository/branch/sale invoice/sale_invoice_respository.dart';
import '../../../date/response/status.dart';
import '../../../model/branch/sale_invoice/sale_return_invoice.dart';
import '../../user_preference/session_controller.dart';

class WarehouseSaleReturnInvoiceReportViewModel extends GetxController{
  final searchValue = ''.obs;
  final search = TextEditingController().obs;
  RxBool loading = false.obs;
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;

  final _api = SaleInvoiceRespository();
  final rxRequestStatus = Status.LOADING.obs;
  final saleReturnInvoiceList = SaleReturnModel().obs;
  RxString error = ''.obs;
  RxString warehouseName = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleInvoicesList(SaleReturnModel value) => saleReturnInvoiceList.value = value;
  void setError(String value) => error.value = value;

  void filterSaleReturnInvoice() {
    saleReturnInvoiceList.value = SaleReturnModel();
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "start_date" : startDate.value.text,
      "end_date" : endDate.value.text,
    };
    _api.filterSaleReturnInvoice(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleInvoicesList(value);
      print(value.toJson());
      warehouseName.value = SessionController.user.name!;
    }).onError((error, stackTrace) {
      setError(error.toString());
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "start_date" : "",
      "end_date" : "",
    };
    _api.filterSaleReturnInvoice(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleInvoicesList(value);
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
          filterSaleReturnInvoice();
        }
      }
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    filterSaleReturnInvoice();
    refreshApi();
  }

}