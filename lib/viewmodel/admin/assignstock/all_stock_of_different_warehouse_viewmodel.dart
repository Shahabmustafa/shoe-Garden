import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/assingStock/all_stock_of_different_warehouse_repository.dart';
import 'package:sofi_shoes/model/admin/all_stock_of_different_warehouse_model.dart';

import '../../../date/repository/admin/status/status_rep.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class AllStockOfWarehouseViewModel extends GetxController {
  /// repository
  final _api = AllStockOfDifferentWarehouseRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final search = TextEditingController().obs;

  final rxRequestStatus = Status.LOADING.obs;
  final assignStockWarehouseList = AllStockOfDifferentWarehouseModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void allStockWarehouseList(AllStockOfDifferentWarehouseModel value) =>
      assignStockWarehouseList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to warehouse
  void getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      allStockWarehouseList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      allStockWarehouseList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// update status
  ///
  final _statusApi = StatusRepository();
  void updateStatus(String status, String userId) async {
    try {
      loading.value = true;

      Map data = {
        'status': status,
      };

      await _statusApi.updateWarehouse(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          refreshApi();
          Utils.SuccessToastMessage(value['body']);
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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAll();
  }
}
