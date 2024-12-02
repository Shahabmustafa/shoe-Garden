import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/assingStock/all_stock_of_different_branches_repository.dart';
import 'package:sofi_shoes/date/repository/admin/status/status_rep.dart';
import 'package:sofi_shoes/model/admin/all_stock_of_different_branches_model.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class AllStockOfBranchesViewModel extends GetxController {
  /// repository
  final _api = AllStockOfDifferentBranchesRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;
  RxList dropdownItemsBranch = [].obs;
  final RxString selectBranch = ''.obs;
  final search = TextEditingController().obs;

  final rxRequestStatus = Status.LOADING.obs;
  final assignStockBranchList = AllStockOfDifferentBranchesModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void allStockBranchList(AllStockOfDifferentBranchesModel value) =>
      assignStockBranchList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to branch
  void getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      allStockBranchList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      allStockBranchList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// update status

  final _statusApi = StatusRepository();
  void updateStatus(String status, String userId) async {
    try {
      loading.value = true;

      Map data = {
        'status': status,
      };

      await _statusApi.updateBranch(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAll();
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

  final _branchApi = BranchRepository();
  branchDropDown() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching WareHouse Name: $error');
      // Set loading state to false
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAll();
    branchDropDown();
  }
}
