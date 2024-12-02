import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/stockposition/branch_stock_rep.dart';
import '../../../date/response/status.dart';
import '../../../model/admin/assign_stock_branch_model.dart';
import '../../../model/admin/specific_branch_stock_position_model.dart';

class BranchStockViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  /// dropdown
  RxList dropdownItemsBranch = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownItemsProduct = [].obs;
  RxList dropdownItemsCompany = [].obs;
  RxList dropdownItemsBrand = [].obs;

  /// selected items
  final RxString selectColor = ''.obs;
  final RxString selectBrand = ''.obs;
  final RxString selectCompany = ''.obs;
  final RxString selectSize = ''.obs;
  final RxString selectProduct = ''.obs;
  final RxString selectbranch = ''.obs;
  final RxString selectedType = 'Select Type'.obs;

  final _api = BranchStockRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final assignStockBranchList = AAssignStockToBranchModel().obs;
  final specificAssignStockBranch = SpecificBranchStockPositionModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAssignStockList(AAssignStockToBranchModel value) => assignStockBranchList.value = value;
  void setSpecific(SpecificBranchStockPositionModel value) => specificAssignStockBranch.value = value;
  void setError(String value) => error.value = value;

  void getAllBranch() {
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

  /// specific warehouse
  void getBranchById(String branchId) {
    setRxRequestStatus(Status.LOADING);
    _api.getSpecific(branchId).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSpecific(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    quantity.value.clear();
    search.value.clear();
    searchValue.value = '';
    quantity.value.clear();
    selectColor.value = '';
  }

  final _branchApi = BranchRepository();
  void fetchBranch() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Branch names: $error');
      // Set loading state to false
    });
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
    fetchBranch();
    getAllBranch();
    super.onInit();
  }
}
