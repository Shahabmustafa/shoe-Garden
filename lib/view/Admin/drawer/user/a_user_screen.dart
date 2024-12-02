import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/dialog/edit_dialog.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/res/widget/not_found/not_found_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/user/export/user_export.dart';
import 'package:sofi_shoes/viewmodel/admin/user/user_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/circularindictor/circularindicator.dart';
import '../../../../res/responsive.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/app_drop_down.dart';
import '../../../../res/widget/app_import_button.dart';
import '../../../../res/widget/textfield/app_text_field.dart';
import 'widget/user_table.dart';

class AUserScreen extends StatefulWidget {
  const AUserScreen({super.key});

  @override
  State<AUserScreen> createState() => _AUserScreenState();
}

class _AUserScreenState extends State<AUserScreen> {
  late final UserViewModel controller;

  Future<void> refreshUserList() async {
    controller.refreshApi();
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(UserViewModel());
    controller.getAllUser();
  }

  String? selectUser;

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      drawer: !isDesktop ? const SizedBox(width: 250, child: SideMenuWidgetAdmin(),) : null,
      body: Row(
        children: [
          isDesktop ? const Expanded(flex: 2, child: SideMenuWidgetAdmin()) : Container(),
          Expanded(
            flex: 8,
            child: Obx(() {
              switch (controller.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularIndicator.waveSpinkit);
                case Status.ERROR:
                  return GeneralExceptionWidget(
                      errorMessage: controller.error.value.toString(),
                      onPress: () {
                        controller.refreshApi();
                      });
                case Status.COMPLETE:
                  var filteredStocks = controller.userList.value.body!.users!.where((data) {
                    return controller.search.value.text.isEmpty ||
                        (data.name != null && data.name!.toLowerCase().contains(controller.search.value.text.trim().toLowerCase()));
                  }).toList();
                  return RefreshIndicator(
                    onRefresh: refreshUserList,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search User",
                                  prefixIcon: const Icon(Icons.search),
                                  search: true,
                                  onChanged: (value) {
                                    setState(() {});
                                    controller.searchValue.value = value;
                                  },
                                ),
                              ),
                              Flexible(
                                child: AppExportButton(
                                  icons: Icons.add,
                                  onTap: () => UserExport().printPdf(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        UserTable(
                          number: "#",
                          name: "Name",
                          email: "Email",
                          role: "Role",
                          phoneNumber: "Phone Number",
                          address: "Address",
                          heading: true,
                        ),
                        Expanded(
                          child: filteredStocks.isEmpty ?
                          NotFoundWidget(title: "User Not Found") :
                          ListView.builder(
                            itemCount: controller.userList.value.body!.users!.length,
                            itemBuilder: (context, index) {
                              var user = controller.userList.value.body!.users![index];
                              var name = user.name.toString();
                              var role = user.roleId.toString();
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return UserTable(
                                  number: "${index + 1}",
                                  name: user.name.toString(),
                                  email: user.email.toString(),
                                  role: role == '1' ? 'Admin' : role == '2' ? 'Warehouse' : role == '3' ? 'Branch' : role == "4" ? 'Manager' : "",
                                  phoneNumber: user.phoneNumber != null ? user.phoneNumber.toString() : "Null",
                                  address: user.address != null ? user.address.toString() : "Null",
                                  heading: false,
                                  editOnpress: () {
                                    controller.name.value = TextEditingController(text: user.name);
                                    controller.phoneNumber.value = TextEditingController(text: user.phoneNumber);
                                    controller.address.value = TextEditingController(text: user.address);
                                    selectUser = role == '1' ? 'Admin' : role == '2' ? 'Warehouse' : role == '3' ? 'Branch' : role == "4" ? 'Manager' : "";
                                    controller.usertype.value = user.roleId != null ? user.roleId.toString() : "Null";
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Edit User"),
                                          content: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Form(
                                                    child: Column(
                                                      children: [
                                                        AppTextField(
                                                          controller: controller
                                                              .name.value,
                                                          labelText:
                                                              "User Name",
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        AppTextField(
                                                          controller: controller.phoneNumber.value,
                                                          labelText: "Phone Number",
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        AppTextField(
                                                          controller: controller.address.value,
                                                          labelText: "Address",
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        AppDropDown(
                                                          labelText:
                                                              "Select Category",
                                                          items: const [
                                                            "Admin",
                                                            "Manager",
                                                            "WareHouse",
                                                            "Branch"
                                                          ],
                                                          selectedItem:
                                                              selectUser,
                                                          onChanged: (value) {
                                                            if (value ==
                                                                'Admin') {
                                                              controller
                                                                  .usertype
                                                                  .value = '1';
                                                            } else if (value ==
                                                                'WareHouse') {
                                                              controller
                                                                  .usertype
                                                                  .value = '2';
                                                            } else if (value ==
                                                                'Branch') {
                                                              controller
                                                                  .usertype
                                                                  .value = '3';
                                                            } else if (value ==
                                                                'Manager') {
                                                              controller
                                                                  .usertype
                                                                  .value = '4';
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Obx(
                                                              () => AppTextField(
                                                            controller: controller.password.value,
                                                            labelText: "Password",
                                                            obscureText: controller.visibility.value,
                                                            suffixIcon: GestureDetector(
                                                              onTap: () {
                                                                controller.visibility.value =
                                                                !controller.visibility.value;
                                                              },
                                                              child: Icon(
                                                                controller.visibility.value
                                                                    ? Icons.visibility_off
                                                                    : Icons.visibility,
                                                                size: 20,
                                                              ),
                                                            ),
                                                            validator: (value) {
                                                              return value!.isEmpty
                                                                  ? "Please Enter Your Password"
                                                                  : value.length < 8
                                                                  ? "Please Add 8 Digits"
                                                                  : "";
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.updateUser(
                                                        user.id.toString());
                                                  },
                                                  child: const Text("Update"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  deleteOnpress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditDialog(
                                          reject: () {
                                            Navigator.pop(context);
                                          },
                                          accept: () {
                                            controller
                                                .deleteUser(user.id.toString());
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.clear();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add User"),
                content: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: _key,
                          child: Column(
                            children: [
                              AppTextField(
                                controller: controller.name.value,
                                labelText: "User Name",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppTextField(
                                controller: controller.email.value,
                                labelText: "Email",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppTextField(
                                controller: controller.phoneNumber.value,
                                labelText: "Phone Number",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppTextField(
                                controller: controller.address.value,
                                labelText: "Address",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => AppTextField(
                                  controller: controller.password.value,
                                  labelText: "Password",
                                  obscureText: controller.visibility.value,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      controller.visibility.value =
                                          !controller.visibility.value;
                                    },
                                    child: Icon(
                                      controller.visibility.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20,
                                    ),
                                  ),
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? "Please Enter Your Password"
                                        : value.length < 8
                                            ? "Please Add 8 Digits"
                                            : "";
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppDropDown(
                                labelText: "Select Category",
                                items: const [
                                  "Admin",
                                  "Manager",
                                  "WareHouse",
                                  "Branch"
                                ],
                                onChanged: (value) {
                                  if (value == 'Admin') {
                                    controller.usertype.value = '1';
                                  } else if (value == 'WareHouse') {
                                    controller.usertype.value = '2';
                                  } else if (value == 'Branch') {
                                    controller.usertype.value = '3';
                                  } else if (value == 'Manager') {
                                    controller.usertype.value = '4';
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.password.value.text.length < 8) {
                            Utils.SuccessToastMessage("Password Required 8 Digits");
                          } else {
                            controller.addUser();
                          }
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        label: const Text("Add User"),
      ),
    );
  }
}
