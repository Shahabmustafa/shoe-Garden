import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/warehouse/Assign%20Stock/returned_stock_from_branch_repo.dart';

import '../../../date/response/status.dart';
import '../../../model/warehouse/warehouse_return_stock_admin_model.dart';

class WReturnedStockFromBranchViewModel extends GetxController {
  final search = TextEditingController().obs;

  /// repository
  final _api = WReturnedStockFromBranchRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final returnedStockList = WReturnedStockToAdminModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAssignStockList(WReturnedStockToAdminModel value) =>
      returnedStockList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to warehouse
  void getAllReturnedStock() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllReturnedStock();
    // filterCompany();
  }
}
