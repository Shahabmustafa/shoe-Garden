import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/claim/returned_stock_rep.dart';
import 'package:sofi_shoes/model/admin/returned_stock_branch_model.dart';

import '../../../date/repository/admin/status/status_rep.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class ReturnedStockBranchViewModel extends GetxController {
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString usertype = ''.obs;
  RxBool loading = false.obs;

  final _api = ReturnedStockRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final returnedStockBranchList = AReturnedStockBranchModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setReturendStockBranch(AReturnedStockBranchModel value) =>
      returnedStockBranchList.value = value;

  void setError(String value) => error.value = value;

  void clear() {
    search.value.clear();
    searchValue.value = '';
  }

  void getAllReturnedStockBranch() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllReturnedStockBranch().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      clear();
      setReturendStockBranch(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllReturnedStockBranch().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setReturendStockBranch(value);
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

      await _statusApi.updateReturned(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllReturnedStockBranch();
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllReturnedStockBranch();
  }
}
