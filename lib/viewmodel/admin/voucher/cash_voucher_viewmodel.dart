import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/cash_voucher_model.dart';

import '../../../date/repository/admin/customer/customer_repository.dart';
import '../../../date/repository/admin/voucher/cash_voucher.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class CashVoucherViewModel extends GetxController {
  final balance = TextEditingController().obs;
  final amount = TextEditingController().obs;
  final description = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString selectCustomer = ''.obs;
  RxList dropdownItems = [].obs;

  RxBool loading = false.obs;

  final _api = CashVoucherRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final cashList = ACashVoucherModel().obs;
  RxString error = ''.obs;

  void clear() {
    balance.value.clear();
    search.value.clear();
    searchValue.value.isEmpty;
    amount.value.clear();
    description.value.clear();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setCashList(ACashVoucherModel value) => cashList.value = value;
  void setError(String value) => error.value = value;

  void getAllCash() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((ACashVoucherModel value) {
      setRxRequestStatus(Status.COMPLETE);
      setCashList(value);
      fetchCustomerName();
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((ACashVoucherModel value) {
      setRxRequestStatus(Status.COMPLETE);
      setCashList(value);
      fetchCustomerName();
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add user
  void addCashVoucher() {
    try {
      loading.value = true;
      Map data = {
        'customer_id': selectCustomer.value,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'description': description.value.text
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          //clear controller
          clear();
          getAllCash();
          Get.back();
          fetchCustomerName();
          Utils.SuccessToastMessage('Add Cash Voucher');
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
  void deleteCash(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        clear();
        getAllCash();
        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateCash(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'customer_id': selectCustomer.value,
        'amount': amount.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'description': description.value.text
      };
      print(data);
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllCash();
          Get.back();
          fetchCustomerName();
          Utils.SuccessToastMessage('Update Cash Voucher');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }


  final _customerApi = CustomerRepository();
  void fetchCustomerName() {
    dropdownItems.clear();
    _customerApi.getAllCustomer().then((value) {
      for (var entry in value.body!.customers!) {
        dropdownItems.add(entry.toJson());
        print(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }

  void getCusomerById(String branchId) {
    setRxRequestStatus(Status.LOADING);
    _api.getSpecific(branchId).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setCashList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  @override
  void onInit() {
    getAllCash();
    fetchCustomerName();
    super.onInit();
  }
}
