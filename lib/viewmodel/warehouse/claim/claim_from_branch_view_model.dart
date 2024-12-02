import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/warehouse/claims/w_claim_for_branch_rep.dart';

import '../../../date/response/status.dart';
import '../../../model/warehouse/warehouse_claim_model.dart';

class WClaimFromBranchViewModel extends GetxController {
  final search = TextEditingController().obs;
  final quantiy = TextEditingController().obs;
  final description = TextEditingController().obs;

  /// repository
  final _api = WClaimFromBranchRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final claimList = WClaimModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setClaimStockList(WClaimModel value) => claimList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to warehouse
  void getAllClaim() {
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllClaim();
  }
}
