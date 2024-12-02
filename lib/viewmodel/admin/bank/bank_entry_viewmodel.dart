import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/bank_entry_model.dart';

import '../../../date/repository/admin/bank/bank_entry.repository.dart';
import '../../../date/repository/admin/bank/bank_head_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class BankEntryViewModel extends GetxController {
  final description = TextEditingController().obs;
  final desposit = TextEditingController().obs;
  final withdraw = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString type = ''.obs;
  // RxString seletBank = ''.obs;
  RxBool loading = false.obs;
  // List? bankNameDropdown = [];
  RxList dropdownItems = [].obs;
  final RxString selectBank = ''.obs;

  final _api = BankEntryRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final bankEntryList = ABankEntryModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBankEntryList(ABankEntryModel value) => bankEntryList.value = value;
  void setError(String value) => error.value = value;

  void getAllBankEntry() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setBankEntryList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBankEntryList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    description.value.clear();
    search.value.clear();
    searchValue.value = '';
    description.value.clear();
    desposit.value.clear();
    withdraw.value.clear();
    selectBank.value = '';
  }

  //new add customer
  void addBankEntry() {
    try {
      loading.value = true;
      Map data = {
        'bank_head_id': selectBank.value,
        'type': type.value,
        'description': description.value.text,
        'deposit': desposit.value.text,
        'withdraw': withdraw.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllBankEntry();

          Get.back();
          Utils.SuccessToastMessage('Add Bank Entry');
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
  void deleteBankEntry(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllBankEntry();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateBankEntry(String userId) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'bank_head_id': selectBank.value,
        'type': type.value,
        'description': description.value.text,
        'deposit': desposit.value.text,
        'withdraw': withdraw.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllBankEntry();
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

// //fetch bankhead api to fetch name and id

  final _bankHeadiApi = BankHeadRepository();
  void fetchBankName() {
    _bankHeadiApi.getAll().then((value) {
      for (var entry in value.body!.bankHeads!) {
        dropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }
}
