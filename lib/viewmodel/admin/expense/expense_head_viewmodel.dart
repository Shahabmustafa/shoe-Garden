import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/expense_head_model.dart';

import '../../../date/repository/admin/expense/expense_head.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class ExpenseHeadViewModel extends GetxController {
  final name = TextEditingController().obs;

  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString usertype = ''.obs;

  RxBool loading = false.obs;

  final _api = ExpenseHeadRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final expenseList = AExpenseHeadModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setUserList(AExpenseHeadModel value) => expenseList.value = value;
  void setError(String value) => error.value = value;

  void getAllExpenceHead() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllExpenseHead().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllExpenseHead().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add user
  void addExpenseHead() {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
      };
      _api.addExpenseHead(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllExpenceHead();

          Get.back();
          Utils.SuccessToastMessage('Add Expanse');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // delete user
  void deleteExpenceHead(String id) async {
    await _api.deleteExpenseHead(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllExpenceHead();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateExpenseHead(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
      };
      await _api.updateExpenseHead(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllExpenceHead();
          Get.back();
          Utils.SuccessToastMessage('Update Expanse');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }
}
