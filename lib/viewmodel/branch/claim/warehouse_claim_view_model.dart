import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/repository/admin/warehouse/warehouse_rep.dart';
import 'package:sofi_shoes/date/repository/branch/stockposition/b_only_my_branch_stock_repository.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/branch/claim/b_warehouse_claims_model.dart';

import '../../../date/repository/branch/claim/warehouse_claim_repository.dart';
import '../../../date/repository/branch/searchdynamic/branch_search_dynamic_product_repository.dart';
import '../../../res/utils/utils.dart';

class BWarehouseClaimViewModel extends GetxController {
  final searchValue = ''.obs;
  RxBool loading = false.obs;
  final search = TextEditingController().obs;
  final totalStock = TextEditingController().obs;
  final assignStock = TextEditingController().obs;
  final customerName = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final invoiceNumber = TextEditingController().obs;
  final claimDescription = TextEditingController().obs;

  RxList dropdownItemsWarehouse = [].obs;
  RxList dropdownItemsProduct = [].obs;
  RxList dropdownItemsCompany = [].obs;
  RxList dropdownItemsBrand = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownItemsType = [].obs;

  final RxString selectWarehouse = ''.obs;
  final RxString selectProduct = ''.obs;
  final RxString selectCompany = ''.obs;
  final RxString selectBrand = ''.obs;
  final RxString selectColor = ''.obs;
  final RxString selectSize = ''.obs;
  final RxString selectType = ''.obs;

  final _api = BWarehouseClaimRepository();
  final _warehouseApi = WarehouseRepository();
  final _productApi = BOnlyMyBranchStockRepository();
  final _searchApi = BranchSearchDynamicProductRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final warehouseClaimList = BWarehouseClaimModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setWarehouseClaimList(BWarehouseClaimModel value) =>
      warehouseClaimList.value = value;
  void setError(String value) => error.value = value;

  void getAll() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseClaimList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setWarehouseClaimList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// add branch expense function
  void addWarehouseClaim() {
    try {
      loading.value = true;
      Map data = {
        'claim_to_id': selectWarehouse.value,
        'product_id': selectProduct.value,
        'company_id': selectCompany.value,
        'brand_id': selectBrand.value,
        'type_id': selectType.value,
        'color_id': selectColor.value,
        'size_id': selectSize.value,
        'quantity': assignStock.value.text,
        'description': "Customer : ${customerName.value.text}\n Phone No : ${phoneNumber.value.text} \n Invoice No : ${invoiceNumber.value.text}\n Description : ${claimDescription.value.text}",
        "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAll();
          Get.back();
          Utils.SuccessToastMessage(
            'Successfully Add Warehouse Claim',
          );
        } else {
          Utils.ErrorToastMessage(value['error']);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  warehouseDropDown() {
    _warehouseApi.getAll().then((value) {
      for (var entry in value.body!.warehouses!) {
        dropdownItemsWarehouse.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Wearhouse Name: $error');
      // Set loading state to false
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

  filterBrand() async {
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

  filterType() async {
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
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  filterSize() async {
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
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  filterColor() async {
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
      print('Error Fetching Brand Name: $error');
      // Set loading state to false
    });
  }

  totalStocks() async {
    await _searchApi.getSpecific({
      "productId": selectProduct.value,
      "companyId": selectCompany.value,
      "brandId": selectBrand.value,
      "typeId": selectType.value,
      "sizeId": selectSize.value,
      "colorId": selectColor.value,
    }).then((value) {
      totalStock.value.text = value.body!.totalQuantity.toString();
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
    selectWarehouse.value = '';
    selectProduct.value = '';
    selectCompany.value = '';
    selectBrand.value = '';
    selectColor.value = '';
    selectSize.value = '';
    selectType.value = '';
    assignStock.value.clear();
    claimDescription.value.clear();
    customerName.value.clear();
    invoiceNumber.value.clear();
    phoneNumber.value.clear();
    totalStock.value.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    warehouseDropDown();
    productDropDown();
    getAll();
  }
}
