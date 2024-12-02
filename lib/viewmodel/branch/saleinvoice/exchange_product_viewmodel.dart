import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sofi_shoes/date/repository/branch/sale%20invoice/exchange_repository.dart';
import 'package:sofi_shoes/model/branch/sale_invoice/exchange_product_model.dart';
import 'package:sofi_shoes/model/branch/sale_invoice/sale_invoice_barcode_model.dart';

import '../../../date/repository/admin/product/color_repository.dart';
import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/repository/admin/product/size_repository.dart';
import '../../../date/repository/branch/sale invoice/sale_invoice_respository.dart';
import '../../../date/request_header.dart';
import '../../../date/response/status.dart';
import '../../../res/apiurl/branch_api_url.dart';
import '../../../res/utils/utils.dart';
import '../../../view/Branch/drawer/saleinvoice/sale_exchange_product_model.dart';
import '../../user_preference/session_controller.dart';
import 'database/model/sale_invoice_model.dart';
import 'get_data_sale_invoice_viewmodel.dart';

class ExchangeProductViewmodel extends GetxController {
  var invoices = <SaleInvoiceModelLocalStorage>[].obs;
  var invoicesName = <SaleInvoiceModelLocalStorage>[].obs;
  final startDate = TextEditingController().obs;
  final endDate = TextEditingController().obs;

  RxList dropdownSalesman = [].obs;
  RxList dropdownCustomer = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownProduct = [].obs;

  RxString selectedCustomer = ''.obs;
  Rx<String?> warehouseId = ''.obs;

  RxString selectColor = ''.obs;
  RxString selectSize = ''.obs;
  RxString selectProduct = ''.obs;
  RxString selectType = ''.obs;
  RxString selectBrand = ''.obs;
  RxString selectCompany = ''.obs;

  RxInt totalQuantity = 0.obs;

  RxString quantity = ''.obs;
  RxString salePrice = ''.obs;
  RxString discount = ''.obs;

  RxString subTotal = ''.obs;
  RxString totalAmount = ''.obs;
  RxDouble totalAmountlist = 0.0.obs;
  RxDouble subTotallist = 0.0.obs;

  final quantityController = TextEditingController().obs;
  final saleController = TextEditingController().obs;
  final totalQuantityController = TextEditingController().obs;
  final discountController = TextEditingController().obs;
  final barCodeController = TextEditingController().obs;
  final receivedAmountController = TextEditingController().obs;

  final receivedAmount = TextEditingController().obs;
  final returnAmount = TextEditingController().obs;

  // Repositories
  final _saleApi = SaleInvoiceRespository();

  final _productApi = ProductRepository();
  final _colorApi = ColorRepository();
  final _sizeApi = SizeRespository();
  final searchValue = ''.obs;

  final _api = ExchangeProductRepository();

  RxBool loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  RxString productN = ''.obs;
  RxString colorN = ''.obs;
  RxString sizeN = ''.obs;
  RxString invoiceNumber = ''.obs;
  RxList<int> storedPreviousProductIds = <int>[].obs;
  var exchangeProducts = <ExchangProductItemModel>[].obs;

  void _initializeStoredPreviousProductIds() {
    storedPreviousProductIds.value = exchangeProducts
        .where((product) => product.previousProductId != null)
        .map((product) => product.previousProductId!)
        .toList();
  }

  void addOrUpdateProduct(ExchangProductItemModel newProduct) {
    final existingProductIndex = exchangeProducts.indexWhere(
      (product) =>
          product.productId == newProduct.productId &&
          product.sizeId == newProduct.sizeId &&
          product.colorId == newProduct.colorId,
    );

    if (existingProductIndex != -1) {
      // Update existing product
      // Update existing product
      final existingProduct = exchangeProducts[existingProductIndex];
      existingProduct.quantity += newProduct.quantity; // Add quantity

      // Calculate subTotal and totalAmount based on updated quantity
      double calculatedSubTotal =
          double.parse(newProduct.subTotal) + double.parse(newProduct.subTotal);

      double calculatedTotalAmount = double.parse(newProduct.totalAmount) +
          double.parse(newProduct.totalAmount);

      // calculatedSubTotal - double.parse(existingProduct.discount.toString());

      // Convert to String for display or storage
      existingProduct.subTotal = calculatedSubTotal.toStringAsFixed(2);
      existingProduct.totalAmount = calculatedTotalAmount.toStringAsFixed(2);
      exchangeProducts[existingProductIndex] = existingProduct;

      subTotallist.value = exchangeProducts
          .map((product) => double.tryParse(product.subTotal) ?? 0.0)
          .reduce((a, b) => a + b);

      totalAmountlist.value = exchangeProducts
          .map((product) => double.tryParse(product.totalAmount) ?? 0.0)
          .reduce((a, b) => a + b);
    } else {
      // Add new product
      if (storedPreviousProductIds.isNotEmpty) {
        newProduct.previousProductId = storedPreviousProductIds.removeAt(0);
      } else {
        // Generate a new unique previousProductId
        int maxProductId = exchangeProducts.isNotEmpty
            ? exchangeProducts
                .map((e) => e.previousProductId ?? 0)
                .reduce((a, b) => a > b ? a : b)
            : 0;
        newProduct.previousProductId = maxProductId + 1;
      }

      exchangeProducts.add(newProduct);
      // getSubTotal();
      // calculate();
    }
    // Recalculate subtotal and total amounts
    subTotallist.value = exchangeProducts.fold(
        0.0, (sum, item) => sum + (double.tryParse(item.subTotal) ?? 0.0));
    totalAmountlist.value = exchangeProducts.fold(
        0.0, (sum, item) => sum + (double.tryParse(item.totalAmount) ?? 0.0));
    clearFields();
  }

  void deleteProduct(int index) {
    final productToDelete = exchangeProducts[index];
    if (productToDelete.previousProductId != null) {
      storedPreviousProductIds.add(productToDelete.previousProductId!);
    }
    exchangeProducts.removeAt(index);
    // Recalculate subtotal and total amounts
    // Recalculate subtotal and total amounts
    subTotallist.value = exchangeProducts.fold(
        0.0, (sum, item) => sum + (double.tryParse(item.subTotal) ?? 0.0));
    totalAmountlist.value = exchangeProducts.fold(
        0.0, (sum, item) => sum + (double.tryParse(item.totalAmount) ?? 0.0));

    clearFields();
  }

  void getSubTotal() {
    double salePrice = double.tryParse(saleController.value.text) ?? 0.0;
    int quantitya = int.parse(quantity.value);
    double discount = double.tryParse(discountController.value.text) ?? 0.0;

    subTotal.value = (salePrice * quantitya).toString();
    totalAmount.value =
        (double.parse(subTotal.value) * (1 - discount / 100)).toString();
  }

  void calculate() {
    subTotallist.value = exchangeProducts.fold(
        0.0, (sum, item) => sum + (int.parse(item.subTotal)));
    totalAmountlist.value = exchangeProducts.fold(0.0, (sum, item) {
      return sum + (int.parse(item.totalAmount));
    });
  }

  void clearFields() {
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    selectProduct.value = '';
    selectColor.value = '';
    selectSize.value = '';
    productN.value = '';
    sizeN.value = '';
    colorN.value = '';
    barCodeController.value.clear();
    saleController.value.clear();
    totalQuantityController.value.clear();
    quantityController.value.clear();
    quantity.value = '';
    discountController.value.clear();
    subTotal.value = '';
    totalAmount.value = '';
  }

  // Maps to store id to name/number mapping
  Map<String, String> productIdToNameMap = {};
  Map<String, String> colorIdToNameMap = {};
  Map<String, String> sizeIdToNumberMap = {};

  Map<String, String> salemanIdToNameMap = {};

  Map<String, String> customerIdToNameMap = {};

  Future<void> getProduct() async {
    dropdownProduct.clear();
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    await _productApi.getAllProduct().then((value) {
      for (var entry in value.body!.products!) {
        dropdownProduct.add(entry.toJson());
        // Store productId to productName mapping
        productIdToNameMap[entry.id.toString()] = entry.name!;
      }
    }).catchError((error) {
      print('Error Fetching Product Name: $error');
    });
  }

  Future<void> getAllColorName() async {
    await _colorApi.getAll().then((value) {
      for (var entry in value.body!.colors!) {
        // Store productId to productName mapping
        colorIdToNameMap[entry.id.toString()] = entry.name!;
      }
    }).catchError((error) {
      print('Error Fetching Color Name: $error');
    });
  }

  Future<void> getAllSizedNumber() async {
    try {
      await _sizeApi.getAll().then((value) {
        for (var entry in value.body!.sizes!) {
          // Store productId to productName mapping

          sizeIdToNumberMap[entry.id.toString()] = entry.number.toString();

          print(value.body!.sizes!.first.number.toString());
        }
      }).catchError((error) {
        print('Error Fetching Size number: $error');
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getColor() async {
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    await _saleApi.getSpecific({
      "productId": selectProduct.value.toString(),
    }).then((value) {
      totalQuantityController.value.text =
          value.body!.totalQuantity.toString() ?? '0';
      discountController.value.text =
          value.body!.product!.discount.toString() ?? "0";
      for (var entry in value.body!.colors!) {
        dropdownItemsColor.add(entry.toJson());
        print(entry.name.toString());

        // Store productId to productName mapping
        // colorIdToNameMap[entry.id.toString()] = entry.name!;
      }
    }).catchError((error) {
      print('Error Fetching Color Namexxxxx: $error');
    });
  }

  Future<void> getSize() async {
    dropdownItemsSize.clear();
    await _saleApi.getSpecific({
      "productId": selectProduct.value,
      "colorId": selectColor.value,
    }).then((value) {
      totalQuantityController.value.text =
          value.body!.totalQuantity.toString() ?? '0';

      selectCompany.value = value.body!.companies?.first.id.toString() ?? '';

      selectBrand.value = value.body!.brands!.first.id.toString() ?? '';
      selectType.value = value.body!.types!.first.id.toString() ?? '';
      print('xxxxxxxxxxxxxxxxxxxxx');
      print(selectCompany.value);

      for (var entry in value.body!.sizes!) {
        dropdownItemsSize.add(entry.toJson());
        print(entry.number);

        // Store productId to productName mapping
        sizeIdToNumberMap[entry.id.toString()] = entry.number.toString();
      }
    }).catchError((error) {
      print('Error Fetching Size Name: $error');
    });
  }

  Future<void> getCompanyBrandTypeId() async {
    final url = Uri.parse(BranchApiUrl.saleInvoiceDynamicApi);

    final response = await http.post(
      url,
      headers: RequestHeader.postHeader(),
      body: json.encode({
        "productId": selectProduct.value,
        "colorId": selectColor.value,
        "sizeId": selectSize.value,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final data = json.decode(response.body);
      selectCompany.value = data['body']['companies']['id'].toString();

      selectBrand.value = data['body']['brands']['id'].toString();
      selectType.value = data['body']['types']['id'].toString();

      totalQuantityController.value.text =
          data['body']['total_quantity'].toString();

      discountController.value.text =
          data['body']['product']['discount'].toString();

      // return PurchaseInvoice.fromJson(data);
      print('Response data: $data');
    } else {
      // If the server did not return a 200 OK response, throw an exception
      print('Failed to load data: ${response.statusCode}');
    }
  }

  //bar code
  var saleInvoiceData = SaleInvoiceBarcodeModel().obs;
  Future<void> barcodeMethod(var barcode) async {
    clearFields();
    await _saleApi.getBarcode({
      "bar_code": barcode,
    }).then((value) {
      print(value);
      // // setSearchList(value);
      barCodeController.value.text = barcode;
      // saleInvoiceData.value = SaleInvoiceBarcodeModel.fromJson(value.toJson());

      salePrice.value = value['body']['product']['sale_price'].toString();
      productN.value = value['body']['product']['name'].toString();
      sizeN.value = value['body']['sizes']['number'].toString();
      colorN.value = value['body']['colors']['name'].toString();
      selectBrand.value = value['body']['brands']['id'].toString();

      selectProduct.value = value['body']['product']['id'].toString();
      selectColor.value = value['body']['colors']['id'].toString();
      selectSize.value = value['body']['sizes']['id'].toString();
      saleController.value.text =
          value['body']['product']['sale_price'].toString();
      selectCompany.value = value['body']['companies']['id'].toString();
      selectType.value = value['body']['types']['id'].toString();
      totalQuantityController.value.text =
          value['body']['total_quantity'].toString();

      discountController.value.text =
          value['body']['product']['discount'].toString();

      // print(saleInvoiceData.value.body!.product!.name);
      // totalQuantity.value = value.body!.totalQuantity ?? '0';
    }).catchError((error) {
      print(error.toString());
      Utils.ErrorToastMessage('sorry no record found!');
      clearFields();
    });
  }

  // Functions to get names/numbers by id
  String? getProductName(String productId) {
    return productIdToNameMap[productId];
  }

  String? getColorName(String colorId) {
    return colorIdToNameMap[colorId];
  }

  String? getSizeNumber(String sizeId) {
    return sizeIdToNumberMap[sizeId];
  }

  String? getCustomerName(String customerId) {
    return customerIdToNameMap[customerId];
  }

  String? getSalemanName(String salemanId) {
    return salemanIdToNameMap[salemanId];
  }

  Future<void> getCustomer() async {
    await _saleApi.getAllCustomer().then((value) {
      for (var entry in value.body!.customers!) {
        dropdownCustomer.add(entry.toJson());

        customerIdToNameMap[entry.id.toString()] = entry.name.toString();
      }
    }).catchError((error) {
      print('Error Fetching Customer Name: $error');
    });
  }

  // Get salesman
  Future<void> getSalesman() async {
    await _saleApi.getAllSaleman().then((value) {
      for (var entry in value.body!.saleMen!) {
        dropdownSalesman.add(entry.toJson());

        salemanIdToNameMap[entry.id.toString()] = entry.name.toString();
      }
    }).catchError((error) {
      print('Error Fetching Salesman Name: $error');
    });
  }

  // @override
  // void onInit() {
  //   getCustomer();
  //   getSalesman();
  //   getProduct();
  //   getAllColorName();
  //   getAllSizedNumber();

  //   super.onInit();
  // }

  final search = TextEditingController().obs;
  // RxString selectedCustomer = ''.obs;
  RxString selectSalesman = ''.obs;
  Map<String, String> salesmanIdToNumberMap = {};

  String? getSalesmanName(String salesmanId) {
    return salesmanIdToNumberMap[salesmanId];
  }

  void addExchangeProduct(data, String previousInvoiceId) async {
    try {
      await _api.update(data, previousInvoiceId).then((value) {
        if (value['success'] == true && value['error'] == null) {
          Utils.SuccessToastMessage("Successfully Exchange Your Sale Invoice");
          Get.back();
          // Optionally, refresh data after navigating back
          Get.find<GetDataSaleInvoiceViewmodel>().getSaleInvoice();
          clearFields();
        } else {
          Utils.ErrorToastMessage(value['error']);
          print(value['error']);
        }
      });
    } catch (e) {
      Utils.ErrorToastMessage(e.toString());
      print(e.toString());
    }
  }

  final exchangeProductList = ExchangeProductModel().obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setExchangeProductInvoicesList(ExchangeProductModel value) => exchangeProductList.value = value;
  void setError(String value) => error.value = value;

  void getExchangeProduct() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
        "start_date" : startDate.value.text,
        "end_date" : endDate.value.text,
      };
    _api.filterExchangeProduct(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setExchangeProductInvoicesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "start_date" : "",
      "end_date" : "",
    };
    _api.filterExchangeProduct(data).then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setExchangeProductInvoicesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }


  Future<void> selectDate(BuildContext context, bool isStartDate) async {
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
          getExchangeProduct();
        }
      }
    });
  }

  @override
  void onInit() {
    warehouseId.value = SessionController.user.id;
    getCustomer();
    getExchangeProduct();
    getSalesman();
    getProduct();
    getAllColorName();
    getAllSizedNumber();
    _initializeStoredPreviousProductIds();
    super.onInit();
  }
}
