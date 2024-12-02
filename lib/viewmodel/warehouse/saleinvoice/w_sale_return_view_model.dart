import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/response/status.dart';

import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/repository/branch/sale invoice/sale_return_invoice_repository.dart';
import '../../../model/branch/sale_invoice/sale_return_invoice.dart';
import '../../../res/utils/utils.dart';
import '../../branch/saleinvoice/get_data_sale_invoice_viewmodel.dart';
import '../../branch/saleinvoice/sale_invoice_product_model.dart';

class WarehouseSaleReturnViewModel extends GetxController {
  final search = TextEditingController().obs;
  RxList dropdownSalesman = [].obs;
  RxList dropdownCustomer = [].obs;
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

  final quantity = TextEditingController().obs;

  final saleController = TextEditingController().obs;
  final discountController = TextEditingController().obs;
  final _api = SaleReturnInvoiceRespository();

  final _productApi = ProductRepository();

  RxBool loading = false.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final saleReturnInvoiceList = SaleReturnModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleReturnInvoiceList(SaleReturnModel value) =>
      saleReturnInvoiceList.value = value;
  void setError(String value) => error.value = value;

  List<SaleInvoiceProductModel> products =
      List.generate(1, (index) => SaleInvoiceProductModel());

  Future<void> addReturnSaleInvoice(BuildContext context, dynamic data) async {
    loading.value = true;
    try {
      final value = await _api.addSaleReturnInvoice(data);
      loading.value = false;

      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage("Successfully Returned Your Sale Invoice");
        Get.find<GetDataSaleInvoiceViewmodel>().getSaleInvoice();
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
    _api.getSaleReturnInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleReturnInvoiceList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getSaleReturnInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleReturnInvoiceList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

// get customer
  Future<void> getCustomer() async {
    await _api.getAllCustomer().then((value) {
      for (var entry in value.body!.customers!) {
        dropdownCustomer.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Customer Name: $error');
      // Set loading state to false
    });
  }

// get saleman
  Future<void> getSaleman() async {
    await _api.getAllSaleman().then((value) {
      for (var entry in value.body!.saleMen!) {
        dropdownSalesman.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Saleman Name: $error');
      // Set loading state to false
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

// get Color
  getColor() async {
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    await _api.getSpecific({
      "productId": selectProduct.value,
    }).then((value) {
      totalQuantity.value = value.body!.totalQuantity.toString() ?? '0';

      discount.value = value.body!.product!.discount.toString() ?? "0";
      for (var entry in value.body!.colors!) {
        dropdownItemsColor.add(entry.toJson());

        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Color Name: $error');
      // Set loading state to false
    });
  }

// get size
  getSize() async {
    dropdownItemsSize.clear();
    await _api.getSpecific({
      "productId": selectProduct.value,
      "colorId": selectColor.value,
    }).then((value) {
      // setSearchList(value);

      totalQuantity.value = value.body!.totalQuantity.toString() ?? '0';
      for (var entry in value.body!.sizes!) {
        dropdownItemsSize.add(entry.toJson());
        print(entry.number);
      }
    }).catchError((error) {
      print('Error Fetching Color Name: $error');
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
    getCustomer();
    getSaleman();
    getProduct();
    getSaleReturnInvoice();
    Get.find<GetDataSaleInvoiceViewmodel>().getSaleInvoice();
    refreshApi();
    super.onInit();
  }
}
