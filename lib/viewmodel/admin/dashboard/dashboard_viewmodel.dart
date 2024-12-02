import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/dashboard_model.dart';

import '../../../date/repository/admin/dashboard/dashboard_repository.dart';
import '../../../date/response/status.dart';

class DashboardViewModel extends GetxController {
  RxBool loading = false.obs;

  final _api = DashboardRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final dashboardList = ADashboardModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setDashboardList(ADashboardModel value) => dashboardList.value = value;
  void setError(String value) => error.value = value;

  void getDashboard() {
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
}
