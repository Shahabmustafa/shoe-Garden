import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/branch_target_model.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/discounts/branch_target_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class BranchTargetViewModel extends GetxController {
  final searchStartDate = ''.obs;
  final RxString selectBranch = ''.obs;
  final target = TextEditingController().obs;

  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool status = false.obs;

  RxBool loading = false.obs;
  RxList branchDropDownItems = [].obs;

  final _api = BranchTargetRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final branchTargetList = BranchTargetModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchTargetList(BranchTargetModel value) => branchTargetList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchTargetList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchTargetList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    target.value.clear();
    selectBranch.value = '';
    searchStartDate.value = "";
  }

  /// new add Target
  void add(String? startDate, endDate) {
    try {
      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'amount': target.value.text,
        'start_date': startDate,
        'end_date': endDate,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Add Branch Target');
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage('Error ${e.toString()}');
    }
  }

  /// delete user
  void delete(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAll();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  /// update user
  void updates(String userId, String? startDate, endDate) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'amount': target.value.text,
        'start_date': startDate,
        'end_date': endDate,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Update Branch Target');
        } else {
          Utils.ErrorToastMessage(value['error']);
          print("error ${value["error"]}");
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  /// fetch product api to fetch name and id

  final _branchApi = BranchRepository();
  void fetchBranchName() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        branchDropDownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Branch names: $error');
      // Set loading state to false
    });
  }

  String findBranchName(String branchId) {
    for (var branch in branchDropDownItems) {
      if (branch['id'].toString() == branchId) {
        return branch['name'];
      }
    }
    return 'Branch not found'; // Default message if branch not found
  }
//
// @override
// void onClose() {
//   description.value.dispose();
//   searchValue.value = '';
//   desposit.value.dispose();
//   withdraw.value.dispose();
//   search.value.dispose();
//
//   super.onClose();
// }
}
