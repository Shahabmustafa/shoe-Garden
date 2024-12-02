import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/res/circularindictor/circularindicator.dart';
import 'package:sofi_shoes/res/responsive.dart';
import 'package:sofi_shoes/res/widget/app_import_button.dart';
import 'package:sofi_shoes/res/widget/general_execption_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/reports/widget/user_report_widget.dart';
import 'package:sofi_shoes/view/Admin/drawer/user/export/user_export.dart';
import 'package:sofi_shoes/viewmodel/admin/user/user_viewmodel.dart';

import '../../../../date/response/status.dart';
import '../../../../res/slidebar/side_menu_admin.dart';
import '../../../../res/widget/textfield/app_text_field.dart';

class UserReport extends StatefulWidget {
  const UserReport({super.key});

  @override
  State<UserReport> createState() => _UserReportState();
}

class _UserReportState extends State<UserReport> {
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

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Report"),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidgetAdmin(),
            )
          : null,
      body: Row(
        children: [
          isDesktop
              ? const Expanded(flex: 2, child: SideMenuWidgetAdmin())
              : Container(),
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
                  return RefreshIndicator(
                    onRefresh: refreshUserList,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AppTextField(
                                  controller: controller.search.value,
                                  labelText: "Search Name",
                                  prefixIcon: Icon(Icons.search),
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
                              )),
                            ],
                          ),
                        ),
                        UserReportTable(
                          number: "#",
                          name: "Name",
                          email: "Email",
                          role: "Role",
                          phoneNumber: "Phone Number",
                          address: "Address",
                          heading: true,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                controller.userList.value.body!.users!.length,
                            itemBuilder: (context, index) {
                              var user =
                                  controller.userList.value.body!.users![index];
                              var name = user.name.toString();
                              var role = user.roleId.toString();
                              if (controller.search.value.text.isEmpty || name.toLowerCase().contains(controller.searchValue.value.trim().toLowerCase())) {
                                return UserReportTable(
                                  number: "${index + 1}",
                                  name: user.name.toString(),
                                  email: user.email.toString(),
                                  phoneNumber: user.phoneNumber != null ? user.phoneNumber.toString() : "Null",
                                  address: user.address != null ? user.address.toString() : "Null",
                                  role: role == '1'
                                      ? 'Admin'
                                      : role == '2'
                                          ? 'Warehouse'
                                          : role == '3'
                                              ? 'Branch'
                                              : 'Manager',
                                  heading: false,
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
    );
  }
}
