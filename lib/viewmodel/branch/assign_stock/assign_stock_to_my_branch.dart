import 'package:get/get.dart';

import '../../../date/repository/branch/assigin_stock/assign_stock_to_other_branch_repository.dart';
import '../../../date/response/status.dart';
import '../../../model/branch/assignstock/assign_stock_to_my_branch.dart';
import '../../../res/utils/utils.dart';

class AssignStockToMyBranchViewModel extends GetxController {
  final _api = BAssignStockToOtherBranchRepository();
  RxBool loading = false.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final AssignStockToMyBranchList = AssignStockToMyBranchModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setTargetList(AssignStockToMyBranchModel value) => AssignStockToMyBranchList.value = value;
  void setError(String value) => error.value = value;

  getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.assignStockToMyBranch().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.assignStockToMyBranch().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetList(value);
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
      await _api.updateBranchStatus(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAll();
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
    refreshApi();
  }
}
