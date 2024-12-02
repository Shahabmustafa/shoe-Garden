import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/company_model.dart';

import '../../../date/repository/admin/company/company_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class CompanyViewModel extends GetxController {
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

  final _api = CompanyRespository();

  final rxRequestStatus = Status.LOADING.obs;
  final companyList = ACompanyModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setCompanyList(ACompanyModel value) => companyList.value = value;
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

  void getAllCompany() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      clear();
      setCompanyList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setCompanyList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add customer
  void addCompany() {
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
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllCompany();
          Get.back();
          Utils.SuccessToastMessage('Successfully Add Company');
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // delete user
  void deleteCompany(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllCompany();

        Get.back();
        Utils.SuccessToastMessage('Successfully Delete Your Company Detail');
      } else {
        Utils.ErrorToastMessage('Error ${value["error"]}');
      }
    });
  }

  //update user
  void updateCompany(String userId) async {
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
          getAllCompany();
          Get.back();
          Utils.SuccessToastMessage('Successfully Update Company');

          getAllCompany();
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  clearField() {
    name.value.clear();
    email.value.clear();
    phoneNumber.value.clear();
    address.value.clear();
    openBalance.value.clear();
  }

  // @override
  // void onClose() {
  //   name.value.dispose();
  //   searchValue.value = '';
  //   search.value.dispose();
  //   email.value.dispose();
  //   address.value.dispose();
  //   phoneNumber.value.dispose();
  //   openBalance.value.dispose();
  //   print('xxxxxxxxxxxxxxxxx dispose');
  //   super.onClose();
  // }
}
