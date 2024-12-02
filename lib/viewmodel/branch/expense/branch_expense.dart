import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/repository/admin/expense/expense_head.dart';
import 'package:sofi_shoes/date/repository/branch/expense/branch_expense_repository.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/branch/expense/branch_expense_model.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

class BranchExpenseViewModel extends GetxController {
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final amount = TextEditingController().obs;
  final search = TextEditingController().obs;
  RxList expenseHeadDropdownItems = [].obs;
  final RxString selectExpenseHead = ''.obs;

  final _api = BExpenseRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final branchExpenseList = BranchExpenseModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchExpenseList(BranchExpenseModel value) => branchExpenseList.value = value;
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
  }

  /// add branch expense function
  void addBranchExpense() {
    try {
      loading.value = true;
      Map data = {
        'expense_id': selectExpenseHead.value,
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
      Map data = {
        'expense_id': selectExpenseHead.value,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllExpenseDetail();
          Get.back();
          Utils.SuccessToastMessage('Update Bank Entry');
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
  void fetchHeadName() {
    _expenseHeadApi.getAllExpenseHeadForBranch().then((value) {
      for (var entry in value.body!.expenses!) {
        expenseHeadDropdownItems.add(entry.toJson());
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
    fetchHeadName();
    getAllExpenseDetail();
  }
}
