import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/salemen_salaries_model.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/salaries/salemen_salaries_rep.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class SalemenSalariesViewModel extends GetxController {
  RxBool loading = false.obs;

  final search = TextEditingController().obs;
  final searchValue = ''.obs;

  RxList dropdownItems = [].obs;
  final RxString selectSalemen = ''.obs;
  final _api = SalemenSariesRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final salariesList = ASalemenSalariesModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSalariesList(ASalemenSalariesModel value) =>
      salariesList.value = value;
  void setError(String value) => error.value = value;

  void getAllSalaries() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setSalariesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSalariesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    search.value.clear();
  }

  //update user
  void updateSalaries(String userId) async {
    try {
      loading.value = true;

      Map data = {
        'sale_men_id': selectSalemen.value,
        'salary': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'total_sale': search.value.text,
        'commission_on_total_sale': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'net_salary': searchValue.value,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllSalaries();
          Get.back();
          Utils.SuccessToastMessage('Update Salaries');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // Function to find branch name by branch_id
  final _branchApi = BranchRepository();
  void getBranch() {
    _branchApi.getAll().then((value) {
      for (var branch in value.body!.branches!) {
        dropdownItems.add(branch.toJson());
      }
    }).catchError((error) {
      print('Error fetching branch names: $error');
      // Set loading state to false
    });
  }

  // Function to find branch name by branch_id
  String findBranchName(String branchId) {
    for (var branch in dropdownItems) {
      if (branch['id'].toString() == branchId) {
        return branch['name'];
      }
    }
    return 'Branch not found'; // Default message if branch not found
  }

  @override
  void onClose() {
    search.value.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    getBranch();
    getAllSalaries();
    super.onInit();
  }
}
