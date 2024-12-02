import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/widget/app_drop_down.dart';

import '../../res/widget/app_button.dart';
import '../../res/widget/textfield/app_text_field.dart';
import '../../viewmodel/auth/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final login = Get.put(AuthenticationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: 300,
                      width: 300,
                    ),
                  ],
                ),
                SizedBox(
                  height: kToolbarHeight,
                ),
                Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          AppDropDown(
                            labelText: "Select Type",
                            items: ["Admin","Manager","Warehouse","Branch"],
                            onChanged: (value){
                              if(value == "Admin"){
                                login.usertype.value = "1";
                              }else if(value == "Warehouse"){
                                login.usertype.value = "2";
                              }else if(value == "Branch"){
                                login.usertype.value = "3";
                              }else if(value == "Manager"){
                                login.usertype.value = "4";
                              }
                              print(login.usertype.value.runtimeType);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AppTextField(
                            labelText: "Email",
                            controller: login.loginEmail.value,
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            return AppTextField(
                              labelText: "Password",
                              controller: login.loginPassword.value,
                              obscureText: login.visibility.value,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 20,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  login.visibility.value =
                                      !login.visibility.value;
                                },
                                child: Icon(
                                  login.visibility.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(() {
                      return AppButton(
                        title: "Login",
                        loading: login.loading.value,
                        onTap: () {
                          login.loginApi();
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
