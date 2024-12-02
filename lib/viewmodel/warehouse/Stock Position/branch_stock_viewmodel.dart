import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/branch/branch_repository.dart';
import 'package:sofi_shoes/date/repository/warehouse/Stock%20Position/branch_stock_repo.dart';
import 'package:sofi_shoes/model/admin/specific_branch_stock_position_model.dart';
import 'package:sofi_shoes/model/warehouse/warehouse_branch_stock_model.dart';

import '../../../date/response/status.dart';

class WBranchStockViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  //dropdown
  RxList dropdownItemsBranch = [].obs;

  //selected items
  final RxString selectBranch = ''.obs;
  final RxString selectedType = 'Select Type'.obs;

  final _api = WBranchStockRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final branchStockList = WBranchStockModel().obs;
  final branchStockSpecific = SpecificBranchStockPositionModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchStockList(WBranchStockModel value) => branchStockList.value = value;
  void setBranchStockSpecific(SpecificBranchStockPositionModel value) => branchStockSpecific.value = value;

  void setError(String value) => error.value = value;

  void getAllBranch() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getBranchById(String branchId) {
    setRxRequestStatus(Status.LOADING);
    _api.specificBranch(branchId).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchStockSpecific(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  final _branchApi = BranchRepository();
  void fetchBranch() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Branches names: $error');
      // Set loading state to false
    });
  }

  void clear() {
    quantity.value.clear();
    search.value.clear();
    searchValue.value = '';
    quantity.value.clear();
  }

  @override
  void onClose() {
    quantity.value.dispose();
    searchValue.value = '';
    search.value.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    getAllBranch();
    fetchBranch();
    super.onInit();
  }
}
