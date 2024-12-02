import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/payment_voucher_model.dart';

import '../../../date/repository/admin/company/company_repository.dart';
import '../../../date/repository/admin/voucher/payment_voucher.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class PaymentVoucherViewModel extends GetxController {
  final openingBalance = TextEditingController().obs;
  final amount = TextEditingController().obs;
  final description = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString selectCompany = ''.obs;
  RxList dropdownItems = [].obs;

  RxBool loading = false.obs;

  final _api = PaymentVoucherRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final paymentVoList = APaymentVoucherModel().obs;
  RxString error = ''.obs;

  void clear() {
    search.value.clear();
    searchValue.value.isEmpty;
    openingBalance.value.clear();
    amount.value.clear();
    description.value.clear();
    search.value.clear();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setPaymentList(APaymentVoucherModel value) => paymentVoList.value = value;
  void setError(String value) => error.value = value;

  void getAllPayment() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((APaymentVoucherModel value) {
      setRxRequestStatus(Status.COMPLETE);
      setPaymentList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((APaymentVoucherModel value) {
      setRxRequestStatus(Status.COMPLETE);
      setPaymentList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add user
  void addPaymentVoucher() {
    try {
      loading.value = true;
      Map data = {
        'company_id': selectCompany.value,
        'amount': amount.value.text,
        'description': description.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          //clear controller
          clear();
          getAllPayment();
          Get.back();
          fetchCompanyName();
          Utils.SuccessToastMessage('Add Payment Voucher');
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
  void deletePayment(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        clear();
        getAllPayment();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updatePayment(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'company_id': selectCompany.value,
        'amount': amount.value.text,
        'description': description.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      print(data);
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllPayment();
          Get.back();
          fetchCompanyName();
          Utils.SuccessToastMessage('Update Payment Voucher');
        } else {
          Utils.ErrorToastMessage(value['error']);
          print(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
      print(e.toString());
    }
  }

  final _companyApi = CompanyRespository();
  void fetchCompanyName() {
    dropdownItems.clear();
    _companyApi.getAll().then((value) {
      for (var entry in value.body!.companies!) {
        dropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }

  // @override
  // void onClose() {
  //   description.value.dispose();
  //   openingBalance.value.dispose();
  //   search.value.dispose();
  //   searchValue.value = '';
  //   super.onClose();
  // }

  @override
  void onInit() {
    getAllPayment();
    fetchCompanyName();
    super.onInit();
  }
}