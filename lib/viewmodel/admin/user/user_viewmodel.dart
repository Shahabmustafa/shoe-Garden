import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/model/admin/user_model.dart';

import '../../../date/repository/admin/user/user_repository.dart';
import '../../../date/response/status.dart';
import '../../../res/utils/utils.dart';

class UserViewModel extends GetxController {
  final name = TextEditingController().obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final address = TextEditingController().obs;
  RxBool visibility = true.obs;

  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxString usertype = ''.obs;

  RxBool loading = false.obs;

  final _api = UserRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final userList = AUserModel().obs;
  RxString error = ''.obs;

  void clear() {
    name.value.clear();
    search.value.clear();
    searchValue.value = '';
    email.value.clear();
    password.value.clear();
    phoneNumber.value.clear();
    address.value.clear();
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setUserList(AUserModel value) => userList.value = value;
  void setError(String value) => error.value = value;

  void getAllUser() {
    setRxRequestStatus(Status.LOADING);
    _api.getAllUser().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAllUser().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setUserList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  //new add user
  void addUser() {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
        'email': email.value.text,
        'password': password.value.text,
        'role_id': usertype.value,
        'phone_number': phoneNumber.value.text,
        'address': address.value.text,
      };
      _api.addUser(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          clear();
          getAllUser();
          Get.back();
          Utils.SuccessToastMessage("Successfully Add User");
        } else {
          Utils.ErrorToastMessage("Error ${value["error"]}");
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // delete user
  void deleteUser(String id) async {
    await _api.deleteUser(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        clear();
        getAllUser();
        Utils.SuccessToastMessage('Delete ${value['body']}');
        Navigator.pop(Get.context!);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  //update user
  void updateUser(String userId) async {
    try {
      loading.value = true;
      Map data = {
        'name': name.value.text,
        'role_id': usertype.value,
        'phone_number': phoneNumber.value.text,
        'address': address.value.text,
        "password" : password.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllUser();
          Get.back();
          Utils.SuccessToastMessage('Update User');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  // clearField() {
  //   usertype.value = "";
  //   name.value.clear();
  //   email.value.clear();
  //   password.value.clear();
  // }
  //
  // @override
  // void onClose() {
  //   name.value.dispose();
  //   email.value.dispose();
  //   password.value.dispose();
  //   search.value.dispose();
  //   searchValue.value = '';
  //   super.onClose();
  // }
}
