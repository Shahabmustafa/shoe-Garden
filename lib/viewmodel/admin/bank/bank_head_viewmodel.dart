import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/bank_head_model.dart';

import '../../../date/repository/admin/bank/bank_head_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class BankHeadViewModel extends GetxController {
  final name = TextEditingController().obs;
  final accountNo = TextEditingController().obs;
  final balance = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString usertype = ''.obs;
  RxBool loading = false.obs;

  final _api = BankHeadRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final bankHeadList = ABankHeadModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBankHeadList(ABankHeadModel value) => bankHeadList.value = value;
  void setError(String value) => error.value = value;

  void clear() {
    search.value.clear();
    searchValue.value = '';
    name.value.clear();
    accountNo.value.clear();
    balance.value.clear();
  }

  void getAllBank() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      clear();
      setBankHeadList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBankHeadList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add customer
  void addBankHead() {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
        'account_number': accountNo.value.text,
        'balance': balance.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllBank();

          Get.back();
          Utils.SuccessToastMessage('Add Bank Head');
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
  void deleteBankHead(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllBank();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateBankHead(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
        'account_number': accountNo.value.text,
        'balance': balance.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllBank();
          Get.back();
          Utils.SuccessToastMessage('Update Bank Head');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  clearField() {
    name.value.clear();
    accountNo.value.clear();
    balance.value.clear();
  }
}
