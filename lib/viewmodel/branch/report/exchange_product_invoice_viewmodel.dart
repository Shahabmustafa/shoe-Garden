import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../date/repository/branch/sale invoice/exchange_repository.dart';
import '../../../date/response/status.dart';
import '../../../model/branch/sale_invoice/exchange_product_model.dart';
import '../../user_preference/session_controller.dart';

class ExchangeProductInvoiceViewmodel extends GetxController{
  final searchValue = ''.obs;
  final search = TextEditingController().obs;
  RxBool loading = false.obs;
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;

  final _api = ExchangeProductRepository();
  final rxRequestStatus = Status.LOADING.obs;
  final exchangeProduct = ExchangeProductModel().obs;
  RxString error = ''.obs;
  RxString warehouseName = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setExchangeProductList(ExchangeProductModel value) => exchangeProduct.value = value;
  void setError(String value) => error.value = value;

  void filterExchangeProduct() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "start_date" : startDate.value.text,
      "end_date" : endDate.value.text,
    };
    _api.filterExchangeProduct(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setExchangeProductList(value);
      print(value.toJson());
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
    _api.filterExchangeProduct(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setExchangeProductList(value);
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
          filterExchangeProduct();
        }
      }
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    filterExchangeProduct();
    refreshApi();
  }
}