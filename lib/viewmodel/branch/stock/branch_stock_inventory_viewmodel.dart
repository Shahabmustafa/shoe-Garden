import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/branch/stocks/branch_stock_repository.dart';
import 'package:sofi_shoes/model/branch/branch_stock_inventory_model.dart';

import '../../../date/response/status.dart';

class BranchStockInventoryViewModel extends GetxController {
  final searchController = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  final _api = BStockInventoryRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final branchStockInventoryList = BStockInventoryModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchStockInventoryList(BStockInventoryModel value) =>
      branchStockInventoryList.value = value;
  void setError(String value) => error.value = value;

  void getBranchStockInventory() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setBranchStockInventoryList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchStockInventoryList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
