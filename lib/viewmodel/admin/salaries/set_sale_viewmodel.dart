import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/set_sale_model.dart';

import '../../../date/repository/admin/salaries/set_sale_rep.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class SetSaleViewModel extends GetxController {
  final percentage = TextEditingController().obs;
  RxBool loading = false.obs;

  final _api = SetSaleRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final setSaleList = ASetSaleModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSalemenList(ASetSaleModel value) => setSaleList.value = value;
  void setError(String value) => error.value = value;

  void getAllSetSale() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setSalemenList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSalemenList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    percentage.value.clear();
  }

  //update user
  void updateSetSale(String userId) async {
    try {
      loading.value = true;

      Map data = {
        'commission_percentage': percentage.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now())
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllSetSale();
          Get.back();
          Utils.SuccessToastMessage('Update Commission');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  @override
  void onClose() {
    percentage.value.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    getAllSetSale();
    super.onInit();
  }
}
