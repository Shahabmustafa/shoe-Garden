import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/branch/salaries/saleman_salaries_repository.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/branch/saleman/branch_saleman_salaries_model.dart';

class BranchSalmanSalariesViewModel extends GetxController {
  final searchValue = ''.obs;
  final search = TextEditingController().obs;
  RxBool loading = false.obs;

  final _api = SalemanSalariesRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final salesmanSalariesList = SalmanSalariesModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSalesmanSalariesList(SalmanSalariesModel value) => salesmanSalariesList.value = value;
  void setError(String value) => error.value = value;

  void getSalesmanSalaries() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSalesmanSalariesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSalesmanSalariesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}
