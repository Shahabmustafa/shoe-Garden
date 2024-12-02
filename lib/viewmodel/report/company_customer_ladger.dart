import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/model/admin/company_ladger_model.dart';

import '../../../date/response/status.dart';
import '../../date/repository/admin/company/company_repository.dart';
import '../../date/repository/admin/customer/customer_repository.dart';
import '../../date/repository/admin/report/company_customer_ladger_repo.dart';
import '../../model/admin/customer_leger_model.dart';

class LedgerViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final search = TextEditingController().obs;
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  RxList dropdownCompanyItems = [].obs;
  RxList dropdownCustomerItems = [].obs;
  RxString selectCustomer = ''.obs;
  RxString selectCompany = ''.obs;


  final _api = LedgerRepository();
  var status = ''.obs;

  final rxCustomerRequestStatus = Status.LOADING.obs;
  final rxCompanyRequestStatus = Status.LOADING.obs;
  final ledgerCompanyList = ACompanyLedgerReportModel().obs;

  final ledgerCustomerList = ACustomerLedgerReportModel().obs;
  RxString error = ''.obs;

  void setCustomerRxRequestStatus(Status value) => rxCustomerRequestStatus.value = value;
  void setCompanyRxRequestStatus(Status value) => rxCompanyRequestStatus.value = value;
  void setLedgerCompanyList(ACompanyLedgerReportModel value) => ledgerCompanyList.value = value;

  void setLedgerCustomerList(ACustomerLedgerReportModel value) => ledgerCustomerList.value = value;
  void setError(String value) => error.value = value;

  void getCustomerLedger() {
    rxCustomerRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "customer_id" : selectCustomer.value,
    };
    _api.getCustomerLedger(data).then((value) {
      rxCustomerRequestStatus(Status.COMPLETE);
      setLedgerCustomerList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      rxCustomerRequestStatus(Status.ERROR);
    });
  }

  void refreshCustomerApi() {
    rxCustomerRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "customer_id" : selectCustomer.value,
    };
    _api.getCustomerLedger(data).then((value) {
      rxCustomerRequestStatus(Status.COMPLETE);
      setLedgerCustomerList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      rxCustomerRequestStatus(Status.ERROR);
    });
  }

  ///customer ledger
  void getCompanyLedger() {
    rxCompanyRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "company_id" : selectCompany.value,
    };
    _api.getCompanyLedger(data).then((value) {
      rxCompanyRequestStatus(Status.COMPLETE);
      setLedgerCompanyList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      rxCompanyRequestStatus(Status.ERROR);
    });
  }

  void refreshCompanyApi() {
    rxCompanyRequestStatus(Status.LOADING);
    Map data = {
      'start_date': startDate.value.text,
      'end_date': endDate.value.text,
      "company_id" : selectCompany.value,
    };
    _api.getCompanyLedger(data).then((value) {
      rxCompanyRequestStatus(Status.COMPLETE);
      setLedgerCompanyList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      rxCompanyRequestStatus(Status.ERROR);
    });
  }

  final _customerApi = CustomerRepository();
  void fetchCustomerName() {
    dropdownCustomerItems.clear();
    _customerApi.getAllCustomer().then((value) {
      for (var entry in value.body!.customers!) {
        dropdownCustomerItems.add(entry.toJson());
        print(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }


  final _companyApi = CompanyRespository();
  void fetchCompanyName() {
    dropdownCompanyItems.clear();
    _companyApi.getAll().then((value) {
      for (var entry in value.body!.companies!) {
        dropdownCompanyItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching bank names: $error');
      // Set loading state to false
    });
  }

  Future<void> selectDateCompany(BuildContext context, bool isStartDate) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        if (isStartDate) {
          startDate.value.text = DateFormat('yyyy-MM-dd').format(value);
        } else {
          endDate.value.text = DateFormat('yyyy-MM-dd').format(value);
          getCompanyLedger();
        }
      }
    });
  }


  Future<void> selectDateCustomer(BuildContext context, bool isStartDate) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        if (isStartDate) {
          startDate.value.text = DateFormat('yyyy-MM-dd').format(value);
        } else {
          endDate.value.text = DateFormat('yyyy-MM-dd').format(value);
          getCustomerLedger();
        }
      }
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCustomerName();
    fetchCompanyName();
  }

}
