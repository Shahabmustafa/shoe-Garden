import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/customer_model.dart';

import '../../../date/repository/admin/customer/customer_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class CustomerViewModel extends GetxController {
  final name = TextEditingController().obs;
  final email = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final address = TextEditingController().obs;
  final openBalance = TextEditingController().obs;
  final currentDate = ''.obs;

  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString usertype = ''.obs;

  RxBool loading = false.obs;

  final _api = CustomerRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final customerList = ACustomerModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setCustomerList(ACustomerModel value) => customerList.value = value;
  void setError(String value) => error.value = value;

  void clear() {
    name.value.clear();

    search.value.clear();
    searchValue.value = '';
    email.value.clear();
    phoneNumber.value.clear();
    address.value.clear();
    openBalance.value.clear();
  }

  void getAllCustomer() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllCustomer().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      clear();
      setCustomerList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAllCustomer().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setCustomerList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add customer
  void addCustomer() {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
        'email': email.value.text,
        'phone_number': phoneNumber.value.text,
        'address': address.value.text,
        'opening_balance': openBalance.value.text,
        'current_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.addCustomer(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllCustomer();
          Get.back();
          Utils.SuccessToastMessage('Successfully Add Customer');
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.SuccessToastMessage('Error ${e.toString()}');
    }
  }

  // delete user
  void deleteCustomer(String id) async {
    await _api.deleteCustomer(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllCustomer();

        Get.back();
        Utils.SuccessToastMessage('Successfully Delete Customer');
      } else {
        Utils.ErrorToastMessage('Error ${value['error']}');
      }
    });
  }

  //update user
  void updateCustomer(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
        'email': email.value.text,
        'phone_number': phoneNumber.value.text,
        'address': address.value.text,
        'opening_balance': openBalance.value.text,
        'current_date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllCustomer();
          Get.back();
          Utils.SuccessToastMessage('Successfully Update Customer');
          getAllCustomer();
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage('Error ${e.toString()}');
    }
  }

  clearField() {
    name.value.clear();
    email.value.clear();
    phoneNumber.value.clear();
    openBalance.value.clear();
    address.value.clear();
  }

  // @override
  // void onClose() {
  //   name.value.dispose();
  //   search.value.dispose();
  //   searchValue.value = '';
  //   email.value.dispose();
  //   address.value.dispose();
  //   phoneNumber.value.dispose();
  //   openBalance.value.dispose();
  //   super.onClose();
  // }
}
