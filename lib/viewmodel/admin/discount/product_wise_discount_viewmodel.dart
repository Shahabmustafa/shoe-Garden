import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/product_wise_discountmodel.dart';

import '../../../date/repository/admin/discounts/product_wise_discount_repository.dart';
import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class ProductWiseDiscountViewModel extends GetxController {
  final searchValue = ''.obs;
  final RxString selectProduct = ''.obs;
  final discount = TextEditingController().obs;

  final search = TextEditingController().obs;
  RxBool status = false.obs;

  RxBool loading = false.obs;
  RxList productDropDownItems = [].obs;
  RxList discountDropDownItems = [].obs;

  final _api = ProductWiseDiscountRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final productWiseDiscountList = AProductWiseDiscountModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setProductWiseDiscountList(AProductWiseDiscountModel value) =>
      productWiseDiscountList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setProductWiseDiscountList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setProductWiseDiscountList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void clear() {
    searchValue.value = '';
    discount.value.clear();
    selectProduct.value = '';
    status.value = false;
  }

  //new add customer
  void add() {
    try {
      loading.value = true;
      Map data = {
        'product_id': selectProduct.value,
        'discount': discount.value.text,
        'status': status == true ? "1" : "0",
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAll();

          Get.back();
          Utils.SuccessToastMessage('Success Add Product Wise Discount');
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage('Error ${e.toString()}');
    }
  }

  // delete user
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

  //update user
  void updates(String userId) async {
    try {
      loading.value = true;

      loading.value = true;
      Map data = {
        'product_id': selectProduct.value,
        'discount': discount.value.text,
        'status': status == true ? "1" : "0",
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Update Product Wise Discount');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

// //fetch product api to fetch name and id

  final _productApi = ProductRepository();
  void fetchProductName() {
    _productApi.getAllProduct().then((value) {
      for (var entry in value.body!.products!) {
        productDropDownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Product names: $error');
      // Set loading state to false
    });
  }

  String findProductName(String branchId) {
    for (var branch in productDropDownItems) {
      if (branch['id'].toString() == branchId) {
        return branch['name'];
      }
    }
    return 'Branch not found'; // Default message if branch not found
  }
  //
  // @override
  // void onClose() {
  //   description.value.dispose();
  //   searchValue.value = '';
  //   desposit.value.dispose();
  //   withdraw.value.dispose();
  //   search.value.dispose();
  //
  //   super.onClose();
  // }
}
