import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/warehouse/my_warehouse_stock_model.dart';

import '../../../date/repository/admin/warehouse/warehouse_rep.dart';
import '../../../date/repository/warehouse/Stock Position/my_stock_repo.dart';
import '../../../date/response/status.dart';
import '../../user_preference/session_controller.dart';

class MyWarehouseStockViewModel extends GetxController {
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  RxList dropdownItemsWarehouse = [].obs;
  final RxString selectWarehouse = ''.obs;

  final RxString selectedType = 'Select Type'.obs;

  final _api = MyStockRepository();
  var status = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final myWarehouseStockList = MyWarehouseStockModel().obs;
  SessionController sessionController = SessionController();

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setWarehouseStockList(MyWarehouseStockModel value) => myWarehouseStockList.value = value;

  void setError(String value) => error.value = value;


  void getAllWarehouseStock()async{
    setRxRequestStatus(Status.LOADING);
    _api.myWarehouseStock("data").then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.myWarehouseStock("data").then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getSpecificWarehouseStock() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "warehouse_id" : selectWarehouse.value,
    };
    _api.myWarehouseStock(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getMyWarehouseStock() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "warehouse_id" : SessionController.user.id,
    };
    _api.myWarehouseStock(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseStockList(value);
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
    });
  }

}
