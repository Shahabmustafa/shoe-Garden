import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/branch/report/sale_expense_gross_model.dart';
import '../../../../date/repository/admin/branch/branch_repository.dart';
import '../../../../date/repository/branch/reports/sale_expense_gross_repository.dart';
import '../../../../date/response/status.dart';


class AdminCounterCashViewmodel extends GetxController {
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;
  final cashAmount = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final search = TextEditingController().obs;
  final _api = SaleExpenseGrossRepository();
  var status = ''.obs;

  RxList dropdownItemsBranch = [].obs;
  final RxString selectBranch = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final BSaleExpenseGrossList = SaleExpenseGrossModel().obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleExpenseGross(SaleExpenseGrossModel value) => BSaleExpenseGrossList.value = value;
  void setError(String value) => error.value = value;

  void getSaleExpense() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      'branch_id' : selectBranch.value,
    };
    _api.getCashCounter(data).then((value) {
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
      'branch_id': "",
    };
    _api.getCashCounter(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleExpenseGross(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
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

  final _branchApi = BranchRepository();
  void fetchBranch() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Branch names: $error');
      // Set loading state to false
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSaleExpense();
    fetchBranch();
  }
}
