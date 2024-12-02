import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/repository/admin/branch/branch_repository.dart';
import 'package:sofi_shoes/date/repository/branch/product/return_product_to_branch_repository.dart';
import 'package:sofi_shoes/date/repository/branch/searchdynamic/branch_search_dynamic_product_repository.dart';
import 'package:sofi_shoes/date/repository/branch/stockposition/b_only_my_branch_stock_repository.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/branch/product/return_product_to_branch_model.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:sofi_shoes/viewmodel/user_preference/session_controller.dart';

class BReturnProductToBranchViewModel extends GetxController {
  final searchValue = ''.obs;
  RxBool loading = false.obs;
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
  final description = TextEditingController().obs;
  final totalStocks = TextEditingController().obs;
  final assignStock = TextEditingController().obs;

  final _productApi = BOnlyMyBranchStockRepository();
  final searchApi = BranchSearchDynamicProductRepository();
  final _api = BReturnProductToBranchRepository();
  final branchApi = BranchRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final returnProductToBranchList = BReturnProductToBranchModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setReturnProductToBranchList(BReturnProductToBranchModel value) =>
      returnProductToBranchList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setReturnProductToBranchList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);

    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setReturnProductToBranchList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void add() {
    try {
      loading.value = true;
      Map data = {
        "return_to_id": selectBranch.value,
        'product_id': selectProduct.value,
        'company_id': selectCompany.value,
        'brand_id': selectBrand.value,
        'type_id': selectType.value,
        'color_id': selectColor.value,
        'size_id': selectSize.value,
        'quantity': assignStock.value.text,
        "description": description.value.text,
        "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAll();
          Get.back();
          Utils.SuccessToastMessage('Successfully Return Product To Branch');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  void branchDropDown() {
    branchApi.getAll().then((value) {
      dropdownItemsBranch.clear(); // Clear existing items to avoid duplication
      for (var entry in value.body!.branches!) {
        if (entry.id != SessionController.user.id) {
          // Filter out your own branch
          dropdownItemsBranch.add(entry.toJson());
        }
      }
    }).catchError((error) {
      print('Error Fetching Branches: $error');
    });
  }

  productDropDown() {
    _productApi.getAll().then((value) {
      for (var entry in value.body!.branchStocks!) {
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
      print(value.body!.totalQuantity.toString());
    }).catchError((error) {
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  clearDropdown() {
    dropdownItemsCompany.clear();
    dropdownItemsBrand.clear();
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    dropdownItemsType.clear();
    selectBranch.value = '';
    selectProduct.value = '';
    selectCompany.value = '';
    selectBrand.value = '';
    selectColor.value = '';
    selectSize.value = '';
    selectType.value = '';
    description.value.clear();
    assignStock.value.clear();
    totalStocks.value.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAll();
    refreshApi();
    branchDropDown();
    productDropDown();
  }
}
