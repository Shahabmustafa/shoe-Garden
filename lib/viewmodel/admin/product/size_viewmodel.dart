import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/size_model.dart';

import '../../../date/repository/admin/product/size_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class SizeViewModel extends GetxController {
  final name = TextEditingController().obs;
  final search = TextEditingController().obs;
  RxString type = "".obs;
  RxBool loading = false.obs;
  final searchValue = ''.obs;

  void searchValueController(String value) {
    searchValue.value = value;
  }

  final _api = SizeRespository();

  final rxRequestStatus = Status.LOADING.obs;
  final sizeList = ASizeModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSizeList(ASizeModel value) => sizeList.value = value;
  void setError(String value) => error.value = value;

  void getAllSize() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSizeList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSizeList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add Size
  void addSize() {
    try {
      loading.value = true;
      Map data = {
        'number': name.value.text,
        'type_id': type.value,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllSize();
          Get.back();
          Utils.SuccessToastMessage('Add Size');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
        print(value);
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // delete Size
  void deleteSize(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage(value['body']);
        getAllSize();
        Get.back();
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update size
  void updateSize(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'number': name.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          Get.back();
          Utils.SuccessToastMessage('Update Sized');
          getAllSize();
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }
}
