import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../date/repository/branch/reports/sale_expense_gross_repository.dart';
import '../../../date/repository/branch/salaries/saleman_salaries_repository.dart';
import '../../../date/response/status.dart';
import '../../../model/branch/report/saleman_model.dart';
import '../../../model/branch/report/salesman_salary_rreport_model.dart';

class SalesmanReportViewmodel extends GetxController {
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;
  final cashAmount = TextEditingController().obs;
  final search = TextEditingController().obs;
  final salesmanDropdown = [].obs;
  final selectSalesman = ''.obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final _api = SaleExpenseGrossRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final salesmanReportList = SalesmanReportModel().obs;
  final salesmanSalaryReportList = SalmanSalaryReportModel().obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setError(String value) => error.value = value;
  void setSalesmanReport(SalesmanReportModel value) => salesmanReportList.value = value;
  void setSalesmanSalaryReport(SalmanSalaryReportModel value) => salesmanSalaryReportList.value = value;

  void getSalesmanSaleReport() {
    rxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "sale_man_id" : selectSalesman.value.toString(),
    };
    _api.salesmanReportGetData(data).then((value) {
      print("Raw API Response: $value");
      rxRequestStatus(Status.COMPLETE);
      setSalesmanReport(value);
      print(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      rxRequestStatus(Status.ERROR);
    });
  }

  void salesmanSaleReportRefresh() {
    rxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "sale_man_id" : selectSalesman.value,
    };
    _api.salesmanReportGetData(data).then((value) {
      print("Raw API Response >>>>> : ${value.body!.totalSale}");
      rxRequestStatus(Status.COMPLETE);
      setSalesmanReport(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      rxRequestStatus(Status.ERROR);
    });
  }

  Future<void> salesmanSaleReportSelectDate(BuildContext context, bool isStartDate) async {
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
          getSalesmanSaleReport();
        }
      }
    });
  }

  final branchSalesman = SalemanSalariesRepository();

  dropDownSalesman() {
    branchSalesman.getAll().then((value) {
      for (var entry in value.body!.saleMenSalaries!) {
        salesmanDropdown.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Salesman Name: $error');
      // Set loading state to false
    });
  }


  /// salesman salary report

  void getSalesmanSalaryReport() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "sale_man_id" : selectSalesman.value,
    };
    _api.salesmanSalaryReportGetData(data).then((value) {
      print("Raw API Response: $value"); // Add this to inspect the response
      setRxRequestStatus(Status.COMPLETE);
      setSalesmanSalaryReport(value);
      print(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void salesmanSalaryReportRefresh() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "sale_man_id" : selectSalesman.value,
    };
    _api.salesmanSalaryReportGetData(data).then((value) {
      print("Raw API Response: $value");
      setRxRequestStatus(Status.COMPLETE);
      setSalesmanSalaryReport(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }


  Future<void> salesmanSalaryReportSelectDate(BuildContext context, bool isStartDate) async {
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
          getSalesmanSalaryReport();
        }
      }
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSalesmanSaleReport();
    dropDownSalesman();
    getSalesmanSalaryReport();
  }
}
