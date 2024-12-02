import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/branch_claim_model.dart';

import '../../../date/repository/admin/claim/branch_claim_repository.dart';
import '../../../date/repository/admin/status/status_rep.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class BranchClaimViewModel extends GetxController {
  RxList companyDropdownItems = [].obs;
  RxList brandDropdownItems = [].obs;
  RxList productDropdownItems = [].obs;
  RxList colorDropdownItems = [].obs;
  RxList sizeDropdownItems = [].obs;
  RxString company = "".obs;
  RxString brand = "".obs;
  RxString product = "".obs;
  RxString color = "".obs;
  RxString size = "".obs;
  RxString type = "".obs;
  final search = TextEditingController().obs;
  final quantity = TextEditingController().obs;
  final description = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString usertype = ''.obs;
  RxBool loading = false.obs;

  final _api = BranchClaimRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final branchClaimList = ABranchClaimModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchClaimList(ABranchClaimModel value) =>
      branchClaimList.value = value;
  void setError(String value) => error.value = value;

  void clear() {
    search.value.clear();
    searchValue.value = '';
  }

  void getAllBranchClaim() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      clear();
      setBranchClaimList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchClaimList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// update status
  ///
  final _statusApi = StatusRepository();
  void updateStatus(String status, String userId) async {
    try {
      loading.value = true;

      Map data = {
        'status': status,
      };

      await _statusApi.updateClaim(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllBranchClaim();
          Utils.SuccessToastMessage(value['body']);
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  @override
  void onClose() {
    searchValue.value = '';
    search.value.dispose();
    super.onClose();
  }
}
