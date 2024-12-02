import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/assign_stock_wareshouse_model.dart';
import 'package:sofi_shoes/model/admin/specific_warehouse_stock_position_model.dart';

import '../../../date/repository/admin/stockposition/warehouse_stock_rep.dart';
import '../../../date/repository/admin/warehouse/warehouse_rep.dart';
import '../../../date/response/status.dart';

class WarehouseStockViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  //dropdown
  RxList dropdownItemsWarehouse = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownItemsProduct = [].obs;
  RxList dropdownItemsCompany = [].obs;
  RxList dropdownItemsBrand = [].obs;

  //selected items
  final RxString selectColor = ''.obs;
  final RxString selectBrand = ''.obs;
  final RxString selectCompany = ''.obs;
  final RxString selectSize = ''.obs;
  final RxString selectProduct = ''.obs;
  final RxString selectwarehouse = ''.obs;
  final RxString selectedType = 'Select Type'.obs;

  final _api = WarehouseStockRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final warehouseStockList = AAssignStockTwoWarehouseModel().obs;
  final warehouseStockSpecific = SpecificWarehouseStockPositionModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAssignStockList(AAssignStockTwoWarehouseModel value) => warehouseStockList.value = value;
  void setAssignStockSpecific(SpecificWarehouseStockPositionModel value) => warehouseStockSpecific.value = value;

  void setError(String value) => error.value = value;

  void getAllWareshouse() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  final _warehouseApi = WarehouseRepository();
  void fetchBranch() {
    _warehouseApi.getAll().then((value) {
      for (var entry in value.body!.warehouses!) {
        dropdownItemsWarehouse.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Warehouse names: $error');
      // Set loading state to false
    });
  }

  /// specific warehouse
  void getWarehouseById(String warehouseId) {
    setRxRequestStatus(Status.LOADING);
    _api.getSpecificWarehouse(warehouseId).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockSpecific(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    quantity.value.clear();
    search.value.clear();
    searchValue.value = '';
    quantity.value.clear();
    selectColor.value = '';
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
    fetchBranch();
    getAllWareshouse();
    super.onInit();
  }
}
