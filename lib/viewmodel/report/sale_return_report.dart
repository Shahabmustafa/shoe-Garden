import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/sale_report_model.dart';

import '../../../date/response/status.dart';
import '../../date/repository/admin/branch/branch_repository.dart';
import '../../date/repository/admin/report/sale_return_report_rep.dart';
import '../../date/repository/admin/warehouse/warehouse_rep.dart';

class SaleReturnReportViewModel extends GetxController {
  final startDate = TextEditingController().obs;

  final endDate = TextEditingController().obs;

  RxBool loading = false.obs;

  final _api = SaleReturnReportRepository();
  var status = ''.obs;
  RxList dropdownItemsBranch = [].obs;
  RxList dropdownItemsWarehouse = [].obs;
  final RxString selectSpecific = ''.obs;

  final RxString selectBranchName = ''.obs;
  final RxString selectWarehouseName = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final saleList = ASaleReportModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSale(ASaleReportModel value) => saleList.value = value;
  void setError(String value) => error.value = value;

  void getSaleReturnReport() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "warehouse_or_branch_id" : selectSpecific.value,
    };
    _api.getSaleReport(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSale(value);
      print(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "warehouse_or_branch_id" : selectSpecific.value,
    };
    _api.getSaleReport(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSale(value);
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
          getSaleReturnReport();
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
      print('Error Fetching WareHouse Name: $error');
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
    getSaleReturnReport();
    branchDropDown();
    warehouseDropDown();
  }
}
