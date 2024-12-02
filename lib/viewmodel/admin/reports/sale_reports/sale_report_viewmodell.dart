import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/repository/admin/report/all_branches_sale_report_repository.dart';
import 'package:sofi_shoes/date/repository/admin/warehouse/warehouse_rep.dart';
import 'package:sofi_shoes/model/admin/all_branch_sale_reports_model.dart';

import '../../../../date/repository/admin/branch/branch_repository.dart';
import '../../../../date/response/status.dart';

class SaleReportViewModel extends GetxController {
  final startDate = TextEditingController().obs;

  final endDate = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final RxString selectBranchName = ''.obs;
  final RxString selectWarehouseName = ''.obs;

  RxList dropdownItemsBranch = [].obs;
  final RxString selectSpecific = ''.obs;

  RxList dropdownItemsWarehouse = [].obs;

  final _api = AllBranchesSaleReportRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final allBranchesSaleReport = AllBranchesSaleReportModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAllBranchSaleList(AllBranchesSaleReportModel value) =>
      allBranchesSaleReport.value = value;
  void setError(String value) => error.value = value;

  void BranchSaleReport() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "warehouse_or_branch_id" : selectSpecific.value,
    };
    _api.getBranchSaleReport(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAllBranchSaleList(value);
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
      "warehouse_or_branch_id" : selectSpecific.value,
    };
    _api.getBranchSaleReport(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAllBranchSaleList(value);
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
          BranchSaleReport();
        }
      }
    });
  }

  final _branchApi = BranchRepository();
  branchDropDown() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Branch Name: $error');
      // Set loading state to false
    });
  }

  final _warehouseApi = WarehouseRepository();
  warehouseDropDown() {
    _warehouseApi.getAll().then((value) {
      for (var entry in value.body!.warehouses!) {
        dropdownItemsWarehouse.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching WareHouse Name: $error');
      // Set loading state to false
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    BranchSaleReport();
    branchDropDown();
    warehouseDropDown();
  }
}
