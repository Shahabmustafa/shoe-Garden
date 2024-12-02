import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/branch/report/sale_expense_gross_model.dart';

import '../../../date/repository/branch/reports/sale_expense_gross_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class SaleExpenseGrossViewmodel extends GetxController {
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;
  final cashAmount = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final search = TextEditingController().obs;

  final _api = SaleExpenseGrossRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final BSaleExpenseGrossList = SaleExpenseGrossModel().obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleExpenseGross(SaleExpenseGrossModel value) =>
      BSaleExpenseGrossList.value = value;
  void setError(String value) => error.value = value;

  void getSaleExpense() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text
    };
    _api.getDat(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleExpenseGross(value);
      print(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refresh() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
    };
    _api.getDat(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleExpenseGross(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void addCashAssignToAdmin() {
    try {
      loading.value = true;
      Map data = {
        "cash_amount": cashAmount.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          Get.back();
          Utils.SuccessToastMessage(
            'Successfully Cash Assign To Admin',
          );
          refresh();
          cashAmount.value.clear();
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        if (isStartDate) {
          startDate.value.text = DateFormat('yyyy-MM-dd').format(value);
        } else {
          endDate.value.text = DateFormat('yyyy-MM-dd').format(value);
          getSaleExpense();
        }
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSaleExpense();
  }
}
