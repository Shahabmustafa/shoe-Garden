import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/saleman_model.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/salemen/salemen_rep.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class SalemenViewModel extends GetxController {
  final name = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final address = TextEditingController().obs;
  final salary = TextEditingController().obs;
  final commission = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  // List? bankNameDropdown = [];
  RxList dropdownItems = [].obs;
  final RxString selectBranch = ''.obs;

  final _api = SalemenRepository();
  var branchName = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final salemenList = ASalemenModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSalemenList(ASalemenModel value) => salemenList.value = value;
  void setError(String value) => error.value = value;

  void getAllSalemen() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSalemenList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSalemenList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    salary.value.clear();
    name.value.clear();
    search.value.clear();
    searchValue.value = '';
    name.value.clear();
    phoneNumber.value.clear();
    address.value.clear();
    selectBranch.value = '';
    commission.value.clear();
  }

  //new add customer
  void addSalemen() {
    try {
      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'name': name.value.text,
        'phone_number': phoneNumber.value.text,
        'address': address.value.text,
        'salary': salary.value.text,
        'commission': commission.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllSalemen();

          Get.back();
          Utils.SuccessToastMessage('Add Saleman');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // delete user
  void deleteSalemen(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllSalemen();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateSalemen(String userId) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'name': name.value.text,
        'phone_number': phoneNumber.value.text,
        'address': address.value.text,
        'salary': salary.value.text,
        'commission': commission.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllSalemen();
          Get.back();
          Utils.SuccessToastMessage('Update Saleman');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

//fetch branch name
  final _branchApi = BranchRepository();
  void fetchBranchName() {
    _branchApi.getAll().then((value) {
      for (var branch in value.body!.branches!) {
        dropdownItems.add(branch.toJson());
      }
    }).catchError((error) {
      print('Error fetching branch names: $error');
      // Set loading state to false
    });
  }

  /// Function to find branch name by branch_id
  String findBranchName(String branchId) {
    for (var branch in dropdownItems.value) {
      if (branch['id'].toString() == branchId) {
        return branch['name'];
      }
    }
    return 'Branch not found';
  }

  @override
  void onInit() {
    getAllSalemen();
    fetchBranchName();
    super.onInit();
  }
}
