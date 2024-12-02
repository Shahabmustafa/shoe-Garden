import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/specific_warehouse_stock_position_model.dart';

import '../../../date/repository/admin/warehouse/warehouse_rep.dart';
import '../../../date/repository/warehouse/Stock Position/warehouse_stock_repo.dart';
import '../../../date/response/status.dart';
import '../../../model/warehouse/warehouse_warehouse_stock_model.dart';

class WWarehouseStockViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  //dropdown
  RxList dropdownItemsWarehouse = [].obs;

  //selected items
  final RxString selectwarehouse = ''.obs;
  final RxString selectedType = 'Select Type'.obs;

  final _api = WWarehouseStockRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final warehouseStockList = WWarehouseStockModel().obs;
  final warehouseStockSpecific = SpecificWarehouseStockPositionModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setWarehouseStockList(WWarehouseStockModel value) => warehouseStockList.value = value;
  void setWarehouseStockSpecific(SpecificWarehouseStockPositionModel value) => warehouseStockSpecific.value = value;

  void setError(String value) => error.value = value;

  void getAllWareshouse() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getBranchById(String branchId) {
    setRxRequestStatus(Status.LOADING);
    _api.specificBranch(branchId).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockSpecific(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  final _warehouseApi = WarehouseRepository();
  void fetchWarehouse() {
    _warehouseApi.getAll().then((value) {
      for (var entry in value.body!.warehouses!) {
        dropdownItemsWarehouse.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Warehouse names: $error');
      // Set loading state to false
    });
  }

  void clear() {
    quantity.value.clear();
    search.value.clear();
    searchValue.value = '';
    quantity.value.clear();
  }

  @override
  void onClose() {
    quantity.value.dispose();
    searchValue.value = '';
    search.value.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    getAllWareshouse();
    fetchWarehouse();
    super.onInit();
  }
}
