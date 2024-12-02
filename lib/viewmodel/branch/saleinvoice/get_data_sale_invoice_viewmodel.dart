import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/branch/sale%20invoice/sale_invoice_respository.dart';
import 'package:sofi_shoes/date/response/status.dart';

import '../../../date/repository/branch/sale invoice/exchange_repository.dart';
import '../../../model/branch/sale_invoice/sale_invoice_models.dart';
import '../../user_preference/session_controller.dart';

class GetDataSaleInvoiceViewmodel extends GetxController {
  final searchValue = ''.obs;
  final search = TextEditingController().obs;
  RxBool loading = false.obs;

  final _api = SaleInvoiceRespository();
  final rxRequestStatus = Status.LOADING.obs;
  final saleInvoiceList = SaleInvoiceModels().obs;
  final exchangeProductList = ExchangeProductRepository();
  RxString error = ''.obs;
  RxString warehouseName = ''.obs;

  var products = <Product>[].obs;

  var items = List<int>.generate(5, (index) => 0).obs;

  void increment(int index) {
    items[index]++;
  }

  void decrement(int index) {
    if (items[index] > 0) {
      items[index]--;
    }
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleInvoicesList(SaleInvoiceModels value) =>
      saleInvoiceList.value = value;
  void setError(String value) => error.value = value;

  void getSaleInvoice() {
    saleInvoiceList.value = SaleInvoiceModels();
    setRxRequestStatus(Status.LOADING);
    _api.getSaleInvoice().then((value) {
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
    _api.getSaleInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleInvoicesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getSpecificSaleInvoice(String id) {
    setRxRequestStatus(Status.LOADING);
    _api.specificSaleInvoice(id).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleInvoicesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  // Maps to store id to name/number mapping
  Map<String, String> productIdToNameMap = {};
  Map<String, String> colorIdToNameMap = {};
  Map<String, String> sizeIdToNumberMap = {};

  Map<String, String> salemanIdToNameMap = {};

  Map<String, String> customerIdToNameMap = {};

  final _saleApi = SaleInvoiceRespository();
  String? getSalesmanName(String salesmanId) {
    return salemanIdToNameMap[salesmanId];
  }

  // Get salesman
  Future<void> getSalesman() async {
    await _saleApi.getAllSaleman().then((value) {
      for (var entry in value.body!.saleMen!) {
        salemanIdToNameMap[entry.id.toString()] = entry.name.toString();
      }
    }).catchError((error) {
      print('Error Fetching Salesman Name: $error');
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSaleInvoice();

    refreshApi();
  }
}
