import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/branch/target/branch_target_repository.dart';
import 'package:sofi_shoes/model/branch/target/b_branch_target_model.dart';

import '../../../date/response/status.dart';

class BranchTargetViewModel extends GetxController {
  final _api = BTargetRepository();
  RxBool loading = false.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final branchTargetList = BBranchTargetModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setTargetList(BBranchTargetModel value) =>
      branchTargetList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAll();
    refreshApi();
  }
}
