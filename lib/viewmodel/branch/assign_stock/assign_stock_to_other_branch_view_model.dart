import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/branch/branch_repository.dart';
import 'package:sofi_shoes/date/repository/admin/product/product_repository.dart';
import 'package:sofi_shoes/date/repository/branch/assigin_stock/assign_stock_to_other_branch_repository.dart';
import 'package:sofi_shoes/date/repository/branch/searchdynamic/branch_search_dynamic_product_repository.dart';
import 'package:sofi_shoes/model/branch/assignstock/b_assign_stock_to_another_branch_model.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

import '../../../date/response/status.dart';

class AssignStockToOtherBranchViewModel extends GetxController {
  RxList dropdownItemsBranch = [].obs;
  RxList dropdownItemsProduct = [].obs;
  RxList dropdownItemsCompany = [].obs;
  RxList dropdownItemsBrand = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownItemsType = [].obs;

  final RxString selectBranch = ''.obs;
  final RxString selectProduct = ''.obs;
  final RxString selectCompany = ''.obs;
  final RxString selectBrand = ''.obs;
  final RxString selectColor = ''.obs;
  final RxString selectSize = ''.obs;
  final RxString selectType = ''.obs;
  final search = TextEditingController().obs;
  final totalStocks = TextEditingController().obs;
  final assignStock = TextEditingController().obs;
  final barcodeController = TextEditingController().obs;

  // name
  final RxString productN = ''.obs;
  final RxString companyN = ''.obs;
  final RxString brandN = ''.obs;
  final RxString colorN = ''.obs;
  final RxString sizeN = ''.obs;
  final RxString typeN = ''.obs;

  clearDropdown() {
    dropdownItemsSize.clear();
    dropdownItemsColor.clear();
    dropdownItemsCompany.clear();
    dropdownItemsType.clear();
    dropdownItemsBrand.clear();
    totalStocks.value.clear();
  }

  clearValue() {
    selectBranch.value = '';
    selectProduct.value = '';
    selectCompany.value = '';
    selectBrand.value = '';
    selectColor.value = '';
    selectSize.value = '';
    selectType.value = '';
    productN.value = '';
    brandN.value = '';
    companyN.value = '';
    colorN.value = '';
    typeN.value = '';
    sizeN.value = '';
    barcodeController.value.clear();
  }

  /// repository
  final _api = BAssignStockToOtherBranchRepository();
  // final _statusApi = StatusRepository();
  final _branchApi = BranchRepository();
  final _productApi = ProductRepository();
  final _searchApi = BranchSearchDynamicProductRepository();

  RxString searchValue = ''.obs;
  // RxString usertype = ''.obs;

  RxBool loading = false.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final assignStockToOtherBranchList = BAssignStockToOtherBranchModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setCompanyList(BAssignStockToOtherBranchModel value) => assignStockToOtherBranchList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setCompanyList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setCompanyList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void addBranch() {
    try {
      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'product_id': selectProduct.value,
        'company_id': selectCompany.value,
        'brand_id': selectBrand.value,
        'type_id': selectType.value,
        'color_id': selectColor.value,
        'size_id': selectSize.value,
        'quantity': assignStock.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Add Assign Stock To Other Branch');
          clearDropdown();
          clearValue();
          barcodeController.value.removeListener(() {});
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  void delete(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAll();
        Utils.SuccessToastMessage(
            'Successfully Delete Your Assign Stock to Other Branch Detail');
      } else {
        Utils.ErrorToastMessage('Error ${value["error"]}');
      }
    });
  }

  void isUpdate(String id) async {
    try {
      loading.value = true;
      Map data = {
        'branch_id': selectBranch.value,
        'product_id': selectProduct.value,
        'company_id': selectCompany.value,
        'brand_id': selectBrand.value,
        'type_id': selectType.value,
        'color_id': selectColor.value,
        'size_id': selectSize.value,
        'quantity': assignStock.value.text,
      };
      _api.update(data, id).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Update Assign Stock To Other Branch');
          clearDropdown();
          clearValue();
          barcodeController.value.removeListener(() {});
        } else {
          Utils.ErrorToastMessage(value['error']);
          print(data.toString());
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  Future<void> branchDropDown() async {
    await _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Branch Name: $error');
      // Set loading state to false
    });
  }

  Future<void> productDropDown() async {
    await _productApi.getAllProduct().then((value) {
      for (var entry in value.body!.products!) {
        dropdownItemsProduct.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Product Name: $error');
      // Set loading state to false
    });
  }

  Future<void> filterCompany() async {
    dropdownItemsCompany.clear();
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
    }).then((value) {
      for (var entry in value.body!.companies!) {
        dropdownItemsCompany.add(entry.toJson());
        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Company Name: $error');
      // Set loading state to false
    });
  }

  Future<void> filterBrand() async {
    dropdownItemsBrand.clear();
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
    }).then((value) {
      for (var entry in value.body!.brands!) {
        dropdownItemsBrand.add(entry.toJson());
        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  Future<void> filterType() async {
    dropdownItemsType.clear();
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
    }).then((value) {
      for (var entry in value.body!.types!) {
        dropdownItemsType.add(entry.toJson());
        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Type Name: $error');
      // Set loading state to false
    });
  }

  Future<void> filterSize() async {
    dropdownItemsSize.clear();
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
      "typeId": selectType.value,
    }).then((value) {
      for (var entry in value.body!.sizes!) {
        dropdownItemsSize.add(entry.toJson());
        print(entry.number);
      }
    }).catchError((error) {
      print('Error Fetching Size Name: $error');
      // Set loading state to false
    });
  }

  Future<void> filterColor() async {
    dropdownItemsColor.clear();
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
      "typeId": selectType.value,
      "sizeId": selectSize.value,
    }).then((value) {
      for (var entry in value.body!.colors!) {
        dropdownItemsColor.add(entry.toJson());
        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Color Name: $error');
      // Set loading state to false
    });
  }

  Future<void> totalStock() async {
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
      "typeId": selectType.value,
      "sizeId": selectSize.value,
      "colorId": selectColor.value,
    }).then((value) {
      totalStocks.value.text = value.body!.totalQuantity.toString();
      barcodeController.value.text = value.body!.product!.barcode.toString();
      print(value.body!.totalQuantity.toString());
    }).catchError((error) {
      print('Error Fetching Total Stock: $error');
      // Set loading state to false
    });
  }

  Future<void> barcodeMethod(var barcode) async {
    clearDropdown();
    await _searchApi.getBarcode({
      "bar_code": barcode,
    }).then((value) {
      print(value);
      // // setSearchList(value);
      barcodeController.value.text = barcode;
      // saleInvoiceData.value = SaleInvoiceBarcodeModel.fromJson(value.toJson());

      // sa.value = value['body']['product']['sale_price'].toString();
      productN.value = value['body']['product']['name'].toString();
      sizeN.value = value['body']['sizes']['number'].toString();
      colorN.value = value['body']['colors']['name'].toString();
      brandN.value = value['body']['brands']['name'].toString();

      companyN.value = value['body']['companies']['name'].toString();
      typeN.value = value['body']['types']['name'].toString();

      selectBrand.value = value['body']['brands']['id'].toString();
      selectProduct.value = value['body']['product']['id'].toString();
      selectColor.value = value['body']['colors']['id'].toString();
      selectSize.value = value['body']['sizes']['id'].toString();

      selectCompany.value = value['body']['companies']['id'].toString();
      selectType.value = value['body']['types']['id'].toString();

      totalStocks.value.text = value['body']['total_quantity'].toString();

      // print(saleInvoiceData.value.body!.product!.name);
      // totalQuantity.value = value.body!.totalQuantity ?? '0';
    }).catchError((error) {
      print(error.toString());
      Utils.ErrorToastMessage('sorry no record found!');
      clearDropdown();
    });
  }



  void onBarcodeScanned() {
    final barcode = barcodeController.value.text;

    // Check if input is from the scanner gun (ends with Enter or newline)
    if (barcode.isNotEmpty && barcode.endsWith('\n')) {
      // Clean up the barcode (trim newline or extra spaces)
      final cleanedBarcode = barcode.trim();

      // Trigger the method with the scanned barcode
      barcodeMethod(cleanedBarcode);

      // Clear the text field for the next scan
      barcodeController.value.clear();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    branchDropDown();
    productDropDown();
    getAll();
    refreshApi();
  }
}
