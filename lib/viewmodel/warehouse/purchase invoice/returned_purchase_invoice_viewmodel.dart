import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/product/product_repository.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:sofi_shoes/viewmodel/warehouse/purchase%20invoice/purchase_invoice_viewmodel.dart';

import '../../../date/repository/admin/company/company_repository.dart';
import '../../../date/repository/warehouse/purchase invoice/returned_purchase_invoice_repository.dart';
import '../../../date/response/status.dart';
import '../../../model/returned_item_purchase_invoice_model.dart';
import '../../../model/warehouse/returned_purchase_invoice_model.dart';
import '../../branch/saleinvoice/sale_invoice_product_model.dart';

class ReturnedPurchaseInvoiceViewmodel extends GetxController {
  final search = TextEditingController().obs;

  RxList dropdownSalesman = [].obs;
  RxList dropdownCompany = [].obs;
  RxList dropdownProduct = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList totalQuantityList = [].obs;
  RxList quantityList = [].obs;
  RxList salePriceList = [].obs;
  RxList discountList = [].obs;

  RxString selectedCustomer = ''.obs;
  RxString selectSaleman = ''.obs;
  RxString selectProduct = ''.obs;
  RxString selectColor = ''.obs;
  RxString selectSize = ''.obs;
  RxString selectType = ''.obs;
  RxString selectBrand = ''.obs;
  RxString selectCompany = ''.obs;
  RxString totalQuantity = ''.obs;
  RxString salePrice = ''.obs;
  RxString discount = ''.obs;

  RxString searchValue = ''.obs;

  final quantity = TextEditingController().obs;

  final saleController = TextEditingController().obs;
  final discountController = TextEditingController().obs;
  final _api = ReturnedPurchaseInvoiceRepository();

  final _companyApi = CompanyRespository();

  final _productApi = ProductRepository();

  RxBool loading = false.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final saleReturnInvoiceList = ReturnedPurchaseInvoiceModel().obs;
  final returnSpecific = ReturnedItemPurchaseInvoiceModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleReturnInvoiceList(ReturnedPurchaseInvoiceModel value) =>
      saleReturnInvoiceList.value = value;
  void setError(String value) => error.value = value;

  void setSpecificSaleReturnInvoiceList(
          ReturnedItemPurchaseInvoiceModel value) =>
      returnSpecific.value = value;

  List<SaleInvoiceProductModel> products =
      List.generate(1, (index) => SaleInvoiceProductModel());

  void getSpecificReturnedInvoice(int id) async {
    _api.getSpecificReturnInvoice(id).then((value) {
      setSpecificSaleReturnInvoiceList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> addReturnInvoice(BuildContext context, dynamic data) async {
    loading.value = true;
    try {
      print(data);
      final value = await _api.addReturnedInvoice(data);
      loading.value = false;

      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage("Successfully Returned Your Sale Invoice");
        Get.find<WPurchaseInvoiceViewModel>().getPurchaseInvoice();
        getSaleReturnInvoice();
        Get.back();
      } else {
        Utils.ErrorToastMessage(value['error']);
        print(value['error']);
      }
    } catch (error) {
      loading.value = false;
      Utils.ErrorToastMessage(error.toString());
    }
  }

  void getSaleReturnInvoice() {
    setRxRequestStatus(Status.LOADING);
    _api.getAllReturnedInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleReturnInvoiceList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAllReturnedInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleReturnInvoiceList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> getCompany() async {
    await _companyApi.getAll().then((value) {
      for (var entry in value.body!.companies!) {
        dropdownCompany.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Customer Name: $error');
    });
  }

  // get product
  Future<void> getProduct() async {
    await _productApi.getAllProduct().then((value) {
      for (var entry in value.body!.products!) {
        dropdownProduct.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Product Name: $error');
      // Set loading state to false
    });
  }

  // add quantity, price, dicount

  void addRecordList() {
    totalQuantityList.add(totalQuantity);
    quantityList.add(quantity);
    salePriceList.add(salePrice);
    discountList.add(discount);
  }

  @override
  void onInit() {
    // getProduct();
    getSaleReturnInvoice();
    refreshApi();
    super.onInit();
  }
}
