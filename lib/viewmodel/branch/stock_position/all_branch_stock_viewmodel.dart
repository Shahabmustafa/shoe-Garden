import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/branch/branch_repository.dart';
import 'package:sofi_shoes/date/repository/branch/stockposition/branch_stock_repository.dart';
import 'package:sofi_shoes/model/admin/specific_branch_stock_position_model.dart';
import 'package:sofi_shoes/model/branch/branch_stock_position_model.dart';
import 'package:sofi_shoes/model/branch/stockposition/my_branch_stock_model.dart';

import '../../../date/response/status.dart';
import '../../user_preference/session_controller.dart';

class AllBranchStockViewModel extends GetxController {
  final _api = BBranchStockRepository();
  final branchApi = BranchRepository();

  RxBool loading = false.obs;
  RxList dropdownItemsBranch = [].obs;


  RxString selectBranch = "".obs;
  final rxRequestStatus = Status.LOADING.obs;
  final branchStockList = BBranchStockModel().obs;
  final specificBranchStock = SpecificBranchStockPositionModel().obs;
  final myBranchStockList = MyBranchStockModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setTargetList(BBranchStockModel value) => branchStockList.value = value;
  void setTargetSpecific(SpecificBranchStockPositionModel value) => specificBranchStock.value = value;
  void setMyBranch(MyBranchStockModel value) => myBranchStockList.value = value;
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

  void getMyBranchStock() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "branch_id" : SessionController.user.id,
    };
    _api.myBranchStock(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setMyBranch(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getSpecificBranchStock() {
    setRxRequestStatus(Status.LOADING);
    // Map data = {
    //   "branch_id" : ,
    // };
    _api.specificBranch(selectBranch.value).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetSpecific(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void getAllBranchStock() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshMyBranchStockApi() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "branch_id" : selectBranch.value,
    };
    _api.myBranchStock(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setMyBranch(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }



  /// specific warehouse
  void getBranchById(String branchId) {
    setRxRequestStatus(Status.LOADING);
    _api.specificBranch(branchId).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setTargetSpecific(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  branchDropDown() {
    branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching branch Name: $error');
    });
  }
}
