import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/admin/brand_model.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

import '../../../date/repository/admin/product/brand_repository.dart';

class BrandViewModel extends GetxController {
  /// textFormField controller
  final name = TextEditingController().obs;
  final search = TextEditingController().obs;

  /// search brand text
  final searchValue = ''.obs;

  /// overload ui
  RxBool loading = false.obs;

  /// brand repository crud api
  final _api = BrandRepository();

  /// brand model
  final brandList = ABrandModel().obs;

  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setBrandList(ABrandModel value) => brandList.value = value;
  void setError(String value) => error.value = value;

  /// all textFormField clear
  void clear() {
    name.value.clear();
  }

  /// this function use for all brand show on ui
  getAllBrand() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);

      setBrandList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// this function use for refresh your ui
  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setBrandList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// this function use for add brand
  void addBrand() {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllBrand();
          clear();
          Get.back();
          Utils.SuccessToastMessage("Successfully Add Brand");
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  /// this function use for delete brand
  void deleteBrand(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage("Successfully Delete Brand");
        getAllBrand();

        Get.back();
      } else {
        Utils.ErrorToastMessage('Error ${value['error']}');
      }
    });
  }

  /// this function use for update brand
  void updateBrand(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          Get.back();
          Utils.SuccessToastMessage("Successfully Update Brand");
          getAllBrand();
          clear();
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage('Error ${e.toString()}');
    }
  }
}
