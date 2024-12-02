import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/expense_detail_model.dart';

import '../../../date/repository/admin/expense/expense_detail_model.dart';
import '../../../date/repository/admin/expense/expense_head.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class ExpenseDetailViewModel extends GetxController {
  final description = TextEditingController().obs;
  final amount = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  // List? bankNameDropdown = [];
  RxList dropdownItems = [].obs;
  final RxString selectExpenseHead = ''.obs;

  final _api = ExpenseDetailRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final expenseDetailList = AExpenseDetailModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setExpenseDetailList(AExpenseDetailModel value) =>
      expenseDetailList.value = value;
  void setError(String value) => error.value = value;

  void getAllExpenseDetail() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllExpenseDetail().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setExpenseDetailList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllExpenseDetail().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setExpenseDetailList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    description.value.clear();
    amount.value.clear();
    selectExpenseHead.value = '';
  }

  //new add customer
  void addExpenseDetail() {
    try {
      loading.value = true;
      Map data = {
        'expense_id': selectExpenseHead.value,
        'description': description.value.text,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.addExpenseDetail(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllExpenseDetail();
          Get.back();
          Utils.SuccessToastMessage(
            'Add Expanse Details',
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

  // delete user
  void deleteExpenseDetail(String id) async {
    await _api.deleteExpenseDetail(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllExpenseDetail();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateExpenseDetail(String userId) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'expense_id': selectExpenseHead.value,
        'description': description.value.text,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      await _api.updateExpenseDetail(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllExpenseDetail();
          Get.back();
          Utils.SuccessToastMessage('Update Expense Details');
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
    _expenseHeadApi.getAllExpenseHead().then((value) {
      for (var entry in value.body!.expenses!) {
        dropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank head: $error');
      // Set loading state to false
    });
  }

  clearField() {
    amount.value.clear();
    description.value.clear();
    selectExpenseHead.value = "";
  }

  // @override
  // void onClose() {
  //   description.value.dispose();
  //   amount.value.dispose();
  //   // search.value.dispose();
  //   super.onClose();
  // }
}
