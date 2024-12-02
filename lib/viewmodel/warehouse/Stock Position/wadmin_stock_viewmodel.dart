import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/warehouse/my_stock_model.dart';

import '../../../date/repository/warehouse/Stock Position/my_stock_repo.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class WAdminStockViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  final _api = MyStockRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final stockList = WMyStockModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setMyStockList(WMyStockModel value) => stockList.value = value;

  void setError(String value) => error.value = value;

  void getAllStock() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setMyStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setMyStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void updateStatus(String status, String userId) async {
    try {
      loading.value = true;

      Map data = {
        'status': status,
      };
      await _api.updateWarehouseStatus(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllStock();
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
  void onClose() {
    quantity.value.dispose();
    searchValue.value = '';
    search.value.dispose();

    super.onClose();
  }

  @override
  void onInit() {
    getAllStock();
    super.onInit();
  }
}
