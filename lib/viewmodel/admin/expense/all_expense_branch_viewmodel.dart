import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/branch_expense_model.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/expense/all_branch_expense_repository.dart';
import '../../../date/repository/admin/expense/expense_head.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class AllBranchExpenseViewModel extends GetxController {
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final amount = TextEditingController().obs;
  final search = TextEditingController().obs;
  RxList expenseHeadDropdownItems = [].obs;
  RxList branchDropdownItems = [].obs;
  final RxString selectBranch = ''.obs;
  final RxString selectExpenseHead = ''.obs;

  final _api = AllBranchExpenseRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final branchExpenseList = AAllBranchExpenseModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchExpenseList(AAllBranchExpenseModel value) =>
      branchExpenseList.value = value;
  void setError(String value) => error.value = value;

  void getAllExpenseDetail() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setBranchExpenseList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchExpenseList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    amount.value.clear();
    selectExpenseHead.value = '';
    selectBranch.value = '';
  }

  /// add branch expense function
  void addBranchExpense() {
    try {
      loading.value = true;
      Map data = {
        'expense_id': selectExpenseHead.value,
        'branch_id': selectBranch.value,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllExpenseDetail();
          Get.back();
          Utils.SuccessToastMessage(
            'Add Branch Expense',
          );
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  /// delete branch expense function
  void deleteBranchExpense(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllExpenseDetail();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  /// update branch expense function
  void updateBranchExpense(String userId) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'expense_id': selectExpenseHead.value,
        'branch_id': selectBranch.value,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllExpenseDetail();
          Get.back();
          Utils.SuccessToastMessage('Update Branch Expanse');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  /// fetch expenseHead api to fetch name and id

  final _expenseHeadApi = ExpenseHeadRepository();
  final _branchApi = BranchRepository();
  void fetchHeadName() async {
    await _expenseHeadApi.getAllExpenseHead().then((value) {
      for (var entry in value.body!.expenses!) {
        expenseHeadDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }

  /// fetch brand api to fetch name and id

  void fetchBranchName() async {
    await _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        branchDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }

  @override
  void onClose() {
    amount.value.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllExpenseDetail();
    fetchBranchName();
    fetchHeadName();
  }
}
