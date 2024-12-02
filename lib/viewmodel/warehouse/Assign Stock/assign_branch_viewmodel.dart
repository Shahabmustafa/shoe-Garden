import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/warehouse/Assign%20Stock/assign_stock_branch_rep.dart';

import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/repository/warehouse/Assign Stock/search_dynamic_assign_rep.dart';
import '../../../date/response/status.dart';
import '../../../model/admin/search_dynamic_product_stock_model.dart';
import '../../../model/warehouse/warehouse_assign_stock_branch_model.dart';
import '../../../res/utils/utils.dart';

class WAssignStockBranchViewModel extends GetxController {
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

  /// repository
  final _api = WAssignStockToBranchRepository();
  final _branchApi = BranchRepository();
  final _productApi = ProductRepository();
  final searchDynamicApi = WSearchDynamicRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final assignStockBranchList = WAssignToBranchModel().obs;
  final productInventoryList = ASearchDynamicProductStockModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAssignStockList(WAssignToBranchModel value) =>
      assignStockBranchList.value = value;
  void setProductInventory(ASearchDynamicProductStockModel value) =>
      productInventoryList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to warehouse
  void getAllBranch() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setAssignStockList(value);
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
          getAllBranch();
          Get.back();
          clearDropdown();
          Utils.SuccessToastMessage('Assign Stock to Branch');
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

  updateAssignStockBranch(String id) async {
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
    await _api
        .update(
      data,
      id,
    )
        .then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllBranch();
        Get.back();
        clearDropdown();
        Utils.SuccessToastMessage(
            'Assign Stock to Branch is Successfully Update');
        barcodeController.value.removeListener(() {});
      } else {
        Utils.ErrorToastMessage(value['error']);
        print(value['error']);
      }
    }).onError((error, stackTrace) {
      Utils.ErrorToastMessage(error.toString());
    });
  }

  deleteBranch(String id) {
    _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllBranch();
        Get.back();
        Utils.SuccessToastMessage("Delete Successfully Assign Stock to Branch");
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    }).onError((error, stackTrace) {
      Utils.ErrorToastMessage(error.toString());
    });
  }

  branchDropDown() {
    _branchApi.getAll().then((value) {
      for (var entry in value.body!.branches!) {
        dropdownItemsBranch.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching WareHouse Name: $error');
      // Set loading state to false
    });
  }

  productDropDown() {
    clearDropdown();
    _productApi.getAllProduct().then((value) {
      for (var entry in value.body!.products!) {
        dropdownItemsProduct.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Product Name: $error');
      // Set loading state to false
    });
  }

  filterCompany() async {
    await searchDynamicApi.getSpecific({
      "productId": selectProduct.value,
    }).then((value) {
      for (var entry in value.body!.companies!) {
        dropdownItemsCompany.add(entry.toJson());
        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Company xxx: $error');
      // Set loading state to false
    });
  }

  filterBrand() async {
    dropdownItemsBrand.clear();
    await searchDynamicApi.getSpecific({
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

  filterType() async {
    dropdownItemsType.clear();
    await searchDynamicApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
    }).then((value) {
      for (var entry in value.body!.types!) {
        dropdownItemsType.add(entry.toJson());
        print(entry.name);
      }
    }).catchError((error) {
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  filterSize() async {
    dropdownItemsSize.clear();
    await searchDynamicApi.getSpecific({
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
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  filterColor() async {
    dropdownItemsColor.clear();
    await searchDynamicApi.getSpecific({
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
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  totalStock() async {
    await searchDynamicApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
      "typeId": selectType.value,
      "sizeId": selectSize.value,
      "colorId": selectColor.value,
    }).then((value) {
      totalStocks.value.text = value.body!.totalQuantity.toString();
      print(value.body!.totalQuantity.toString());
    }).catchError((error) {
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  Future<void> barcodeMethod(var barcode) async {
    clearDropdown();
    await searchDynamicApi.getBarcode({
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

  clearDropdown() {
    dropdownItemsCompany.clear();
    dropdownItemsBrand.clear();
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    dropdownItemsType.clear();
    selectCompany.value = '';
    selectBrand.value = '';
    selectColor.value = '';
    selectSize.value = '';
    selectType.value = '';
    assignStock.value.clear();
    totalStocks.value.clear();
    barcodeController.value.clear();
    productN.value = '';
    companyN.value = '';
    colorN.value = '';
    sizeN.value = '';
    brandN.value = '';
    typeN.value = '';
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBranch();
    branchDropDown();
    productDropDown();
  }
}
