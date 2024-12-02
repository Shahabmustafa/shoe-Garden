import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/auth/auth_repository.dart';
import 'package:sofi_shoes/res/routes/routes_name.dart';

import '../../model/auth/login_model.dart';
import '../../res/utils/utils.dart';
import '../user_preference/session_controller.dart';

class AuthenticationController extends GetxController {
  final Rx<TextEditingController> loginEmail = TextEditingController().obs;
  final Rx<TextEditingController> loginPassword = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;
  final _api = LoginRepository();
  RxString usertype = "".obs;

  RxBool visibility = true.obs;

  void loginApi() async {
    loading.value = true;
    Map data = {
      'email': loginEmail.value.text,
      'password': loginPassword.value.text,
      'role_id': usertype.value,
    };
    await _api.login(data).then((value) async {
      loading.value = false;
      if (value['success'] == true && value['error'] == null) {
        // AdminApiUrl.accessToken = value['body']['token'];

        UserModel userModel = UserModel(
          id: value['body']['user']['id'].toString(),
          
          name: value['body']['user']['name'].toString(),
          token: value['body']['token'],
          address: value['body']['user']['address'].toString(),
          phoneNumber: value['body']['user']['phone_number'].toString(),
          isLogin: true,
        );
        await SessionController().saveUserInPreference(userModel).then((value) {
          print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
          print(userModel.toJson());
          if (usertype == "1") {
            Get.offNamed(RoutesName.aDashboardScreen);
          } else if (usertype == "2") {
            Get.offNamed(RoutesName.wdashboardScreenWareHouse);
          } else if (usertype == "3") {
            Get.offNamed(RoutesName.bDashboard);
          } else if (usertype == "4") {
            Get.offNamed(RoutesName.mDashboardScreen);
          }
        });

        print('xxxxxxxxxxxxxxxxxxx');
        print(value['body']['user']['phone_number'].toString());
        await SessionController().getUserFromPreference();
        print('ccccccccccccccccccccccccccccccccccccccccc');
        print(SessionController.user.toJson());
        Utils.SuccessToastMessage('successful login');
        loginEmail.value.clear();
        loginPassword.value.clear();
      } else {
        Utils.ErrorToastMessage(value['error']);
        print(value['error']);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Utils.ErrorToastMessage(error.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginEmail.value.dispose();
    loginPassword.value.dispose();
  }
}
