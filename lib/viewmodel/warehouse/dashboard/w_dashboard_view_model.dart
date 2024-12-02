import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/warehouse/dashboard/dashboard_rep.dart';
import 'package:sofi_shoes/model/warehouse/warehouse_dashboard_model.dart';

import '../../../date/response/status.dart';

class WDashboardViewModel extends GetxController {
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  final _api = WarehouseDashboardRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final dashboardList = WarehouseDashboardModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setDashboardList(WarehouseDashboardModel value) =>
      dashboardList.value = value;

  void setError(String value) => error.value = value;

  void getAllData() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setDashboardList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setDashboardList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  @override
  void onClose() {
    searchValue.value = '';
    search.value.dispose();

    super.onClose();
  }

  @override
  void onInit() async {
    // UserPreference().getUser().then((value){
    //   AdminApiUrl.accessToken = value.token;
    //   AdminApiUrl.name = value.name.toString();
    //   print("???>>?>?>??>${value.name}");
    // });

    getAllData();
    super.onInit();
  }
}
