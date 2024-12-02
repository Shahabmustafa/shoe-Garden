import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/admin/color_model.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

import '../../../date/repository/admin/product/color_repository.dart';

class ColorViewModel extends GetxController {
  final name = TextEditingController().obs;
  final search = TextEditingController().obs;

  final searchValue = ''.obs;
  RxBool loading = false.obs;

  final _api = ColorRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final colorList = AColorModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setColorList(AColorModel value) => colorList.value = value;
  void setError(String value) => error.value = value;

  /// get all color
  void getAllColor() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setColorList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setColorList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// new add color
  void addColor() {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllColor();
          clear();
          Get.back();
          Utils.SuccessToastMessage('Successfully Add Color');
        } else {
          Utils.ErrorToastMessage('Error ${value['error']}');
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage('Error ${e.toString()}');
    }
  }

  /// delete color
  void deleteColor(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage('Successfully Delete Color');
        getAllColor();

        Get.back();
      } else {
        Utils.ErrorToastMessage('Error ${value['error']}');
      }
    });
  }

  /// update color
  void updateColor(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          Get.back();
          Utils.SuccessToastMessage('Successfully Update Color');
          getAllColor();
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

  void clear() {
    name.value.clear();
    search.value.clear();
  }

  @override
  void onClose() {
    name.value.dispose();
    search.value.dispose();
    super.onClose();
  }
}
