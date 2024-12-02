import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofi_shoes/date/repository/admin/product/product_repository.dart';

import '../../../date/repository/admin/assingStock/assign_stock_branch_rep.dart';
import '../../../date/repository/admin/assingStock/search_dynamic_product_stock_rep.dart';
import '../../../date/repository/admin/branch/branch_repository.dart';
import '../../../date/repository/admin/status/status_rep.dart';
import '../../../date/response/status.dart';
import '../../../model/admin/assign_stock_branch_model.dart';
import '../../../model/admin/search_dynamic_product_stock_model.dart';
import '../../../res/utils/utils.dart';

class AssignStockBranchViewModel extends GetxController {
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

  // name
  final RxString productN = ''.obs;
  final RxString companyN = ''.obs;
  final RxString brandN = ''.obs;
  final RxString colorN = ''.obs;
  final RxString sizeN = ''.obs;
  final RxString typeN = ''.obs;
  final search = TextEditingController().obs;
  final totalStocks = TextEditingController().obs;
  final assignStock = TextEditingController().obs;
  final barcodeController = TextEditingController().obs;

  void clear() {
    search.value.clear();
    totalStocks.value.clear();
    assignStock.value.clear();
    barcodeController.value.clear();
    dropdownItemsCompany.clear();
    dropdownItemsBrand.clear();
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    dropdownItemsType.clear();
    productN.value = "";
    companyN.value = "";
    brandN.value = "";
    colorN.value = "";
    sizeN.value = "";
    typeN.value = "";
  }

  /// repository
  final _api = AssignStockBranchRepository();
  final _statusApi = StatusRepository();
  final _branchApi = BranchRepository();
  final _productApi = ProductRepository();
  final searchApi = SearchDynamicRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final assignStockBranchList = AAssignStockToBranchModel().obs;
  final productInventoryList = ASearchDynamicProductStockModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setAssignStockList(AAssignStockToBranchModel value) => assignStockBranchList.value = value;
  void setProductInventory(ASearchDynamicProductStockModel value) => productInventoryList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to branch
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
          Utils.SuccessToastMessage('Add Assign Stock');
          clear();
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

  /// update status
  void updateStatus(String status, String userId) async {
    try {
      loading.value = true;

      Map data = {
        'status': status,
      };

      await _statusApi.updateBranch(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllBranch();
          clear();
          Utils.SuccessToastMessage(value['body']);
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  updateBranch(String id) async {
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
        Utils.SuccessToastMessage(
            'Assign Stock to Branch is Successfully Update');
        getAllBranch();
        Get.back();
        barcodeController.value.removeListener(() {});
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    }).onError((error, stackTrace) {
      Utils.ErrorToastMessage(error.toString());
    });
  }

  deleteBranch(String id) {
    _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Utils.SuccessToastMessage("Sucessfully Delete Assign Stock to Branch");
        getAllBranch();
        Navigator.pop(Get.context!);
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
    dropdownItemsCompany.clear();
    await searchApi.getSpecific({
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

  filterBrand() async {
    dropdownItemsBrand.clear();
    await searchApi.getSpecific({
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
    await searchApi.getSpecific({
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
    await searchApi.getSpecific({
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
    await searchApi.getSpecific({
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
    await searchApi.getSpecific({
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
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  Future<void> barcodeMethod(var barcode) async {
    clear();
    await searchApi.getBarcode({
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
      clear();
    });
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
