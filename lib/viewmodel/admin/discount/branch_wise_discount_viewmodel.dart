import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/discounts/branch_wise_discount_repository.dart';
import '../../../date/response/status.dart';
import '../../../model/admin/branch_wise_discount_model.dart';
import '../../../res/utils/utils.dart';

class BranchWiseDiscountViewModel extends GetxController {
  final searchValue = ''.obs;
  final RxString selectBranch = ''.obs;
  final discount = TextEditingController().obs;
  RxBool status = false.obs;

  RxBool loading = false.obs;
  RxList branchDropDownItems = [].obs;
  RxList discountDropDownItems = [].obs;

  final _api = BranchWiseDiscountRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final branchWiseDiscountList = ABranchWiseDiscountModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBranchWiseDiscountList(ABranchWiseDiscountModel value) =>
      branchWiseDiscountList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchWiseDiscountList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBranchWiseDiscountList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    searchValue.value = '';
    discount.value.clear();
    selectBranch.value = '';
    status.value = false;
  }

  /// new add customer
  void add() {
    try {
      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'discount': discount.value.text,
        'status': status == true ? "1" : "0",
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Success Add Branch Wise Discount');
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage('Error ${e.toString()}');
    }
  }

  /// delete user
  void delete(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAll();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  /// update user
  void updates(String userId) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'discount': discount.value.text,
        'status': status == true ? "1" : "0",
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Update Branch Wise Discount');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  /// fetch product api to fetch name and id

  final _branchApi = BranchRepository();

  fetchBranch() async {
    await _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        branchDropDownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Product Name: $error');
      // Set loading state to false
    });
  }

  @override
  void onInit() {
    getAll();
    fetchBranch();
    super.onInit();
  }
}
