import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/repository/warehouse/claims/w_claim_to_admin_repo.dart';

import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/repository/warehouse/Assign Stock/search_dynamic_assign_rep.dart';
import '../../../date/response/status.dart';
import '../../../model/warehouse/warehouse_claim_model.dart';
import '../../../res/utils/utils.dart';

class WClaimToAdminViewModel extends GetxController {
  RxList dropdownItemsProduct = [].obs;
  RxList dropdownItemsBrand = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownItemsType = [].obs;

  RxList dropdownItemsCompany = [].obs;

  final RxString selectBranch = ''.obs;
  final RxString selectProduct = ''.obs;
  final RxString selectCompany = ''.obs;
  final RxString selectBrand = ''.obs;
  final RxString selectColor = ''.obs;
  final RxString selectSize = ''.obs;
  final RxString selectType = ''.obs;

  final search = TextEditingController().obs;
  final quantiy = TextEditingController().obs;
  final totalStocks = TextEditingController().obs;
  final description = TextEditingController().obs;

  /// repository
  final _api = WClaimToAdminRepository();
  final _productApi = ProductRepository();
  final searchDynamicApi = WSearchDynamicRepository();

  RxBool loading = false.obs;
  RxString searchValue = ''.obs;

  final rxRequestStatus = Status.LOADING.obs;
  final claimList = WClaimModel().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setClaimStockList(WClaimModel value) => claimList.value = value;

  void setError(String value) => error.value = value;

  /// get all data assign stock to warehouse
  void getAllClaim() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setClaimStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setClaimStockList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void addClaim() async {
    try {
      loading.value = true;
      Map data = {
        'product_id': selectProduct.value,
        'company_id': selectCompany.value,
        'brand_id': selectBrand.value,
        'type_id': selectType.value,
        'color_id': selectColor.value,
        'size_id': selectSize.value,
        'quantity': quantiy.value.text,
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'description': description.value.text,
      };
      await _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllClaim();
          Get.back();
          Utils.SuccessToastMessage('Add Claim For Admin');
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
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
    quantiy.value.clear();
    description.value.clear();
    totalStocks.value.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllClaim();
    productDropDown();
  }
}