import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';
import 'package:sofi_shoes/date/repository/admin/product/product_repository.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

import '../../../date/repository/admin/company/company_repository.dart';
import '../../../date/repository/warehouse/purchase invoice/purchase_invoice_repository.dart';
import '../../../date/request_header.dart';
import '../../../date/response/status.dart';
import '../../../model/branch/sale_invoice/sale_invoice_barcode_model.dart';
import '../../../model/warehouse/purchase_invoice_model.dart';
import 'database/model/purchase_invoice_model.dart';
import 'database/purchase_service.dart';

class WPurchaseInvoiceViewModel extends GetxController {
  final PurchaseService _invoiceService = PurchaseService();

  final Rx<NumberPaginatorController> numberPaginatorController =
      NumberPaginatorController().obs;
  var invoices = <PurchaseInvoiceLocalStorageModel>[].obs;
  var invoicesName = <PurchaseInvoiceLocalStorageModel>[].obs;
  final Rx<PurchaseInvoiceLocalStorageModel> fetchedInvoice =
      PurchaseInvoiceLocalStorageModel(companyId: '').obs;
  final searchValue = ''.obs;
  final search = TextEditingController().obs;

  RxList dropdownSalesman = [].obs;
  RxList dropdownCompany = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownProduct = [].obs;

  RxString selectedCompany = ''.obs;
  RxInt currentPageIndex = 0.obs;

  RxString selectColor = ''.obs;
  RxString selectSize = ''.obs;
  RxString selectProduct = ''.obs;
  RxString selectType = ''.obs;
  RxString selectBrand = ''.obs;
  RxString selectCompany = ''.obs;

  RxString selectCompanyDropdown = ''.obs;

  RxInt totalQuantity = 0.obs;

  RxInt invoiceIndex = 0.obs;
  RxString quantity = ''.obs;
  RxString purchasePrice = ''.obs;
  // RxString discount = ''.obs;

  RxDouble subTotal = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxString totalAmountlist = "".obs;
  RxString subTotallist = "".obs;
  RxDouble recievedAmount = 0.0.obs;
  RxDouble balance = 0.0.obs;
  RxDouble companyBalance = 0.0.obs;

  RxDouble companyTotalBalance = 0.0.obs;

  final quantityController = TextEditingController().obs;
  final purchaseController = TextEditingController().obs;
  final totalQuantityController = TextEditingController().obs;
  // final discountController = TextEditingController().obs;
  final barCodeController = TextEditingController().obs;
  final recievedAmountController = TextEditingController().obs;

  // Repositories
  final _api = PurchaseInvoiceRepository();
  final _productApi = ProductRepository();
  final _companyApi = CompanyRespository();
  RxBool loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final purchaseInvoiceList = PurchaseInvoiceModel().obs;
  RxString error = ''.obs;
  RxString productN = ''.obs;
  RxString colorN = ''.obs;
  RxString sizeN = ''.obs;
  RxString invoiceNumber = ''.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setSaleInvoicesList(PurchaseInvoiceModel value) =>
      purchaseInvoiceList.value = value;
  void setError(String value) => error.value = value;

  void getPurchaseInvoice() {
    purchaseInvoiceList.value = PurchaseInvoiceModel();
    setRxRequestStatus(Status.LOADING);
    _api.getInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleInvoicesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getInvoice().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setSaleInvoicesList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future<void> addPurchaseInvoice() async {
    try {
      loading.value = true;
      fetchedInvoice.value.receivedAmount =
          recievedAmountController.value.text.toString();

      Map<String, dynamic> purchaseData = {
        "invoice_number": fetchedInvoice.value.invoiceNumber,
        "company_id": selectCompanyDropdown.value,
        "sub_total": fetchedInvoice.value.subTotal,
        "total_amount": fetchedInvoice.value.totalAmount,
        "received_amount": fetchedInvoice.value.receivedAmount,
        "products": fetchedInvoice.value.products!
            .map((product) => {
                  "product_id": product.productId,
                  "company_id": product.companyId,
                  "brand_id": product.brandId,
                  "type_id": product.typeId,
                  "color_id": product.colorId,
                  "size_id": product.sizeId,
                  "quantity": product.quantity.toString(),
                  "sub_total": product.subTotal,
                  "discount": product.discount,
                  "total_amount": product.totalAmount,
                })
            .toList(),
      };

      // String jsonData = jsonEncode(fetchedInvoice.value);

      String jsonData = jsonEncode(purchaseData);
      print('ssssssssssssssssssjssssssssssssssssssssssss');

      print('JSON Data: $jsonData');

      // Call the API with the serialized data

      final response = await _api.addPurchaseInvoice(jsonData);

      loading.value = false;

      // Debug: Print the response
      print('API Response: $response');

      if (response['success'] == true && response['error'] == null) {
        loading.value = false;

        await deleteInvoice(invoiceIndex.value);
        Utils.SuccessToastMessage('Successfully Purchase');
      } else {
        loading.value = false;
        print(response['error']);
        Utils.ErrorToastMessage(response['error'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
      Utils.ErrorToastMessage(e.toString());
    }
  }

  void getSubTotal() {
    double purchasePrice =
        double.tryParse(purchaseController.value.text) ?? 0.0;
    int quantity = int.tryParse(quantityController.value.text) ?? 0;

    subTotal.value = purchasePrice * quantity;
    totalAmount.value = purchasePrice * quantity;

    companyTotalBalance.value = companyBalance.value +
        double.parse(fetchedInvoice.value.totalAmount.toString());
  }

  void setRecievedAmount(String value) {
    recievedAmount.value = double.tryParse(value) ?? 0.0;
    balance.value = companyTotalBalance.value - recievedAmount.value;
  }

  void clearFields() {
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    selectProduct.value = '';
    productN.value = '';
    sizeN.value = '';
    colorN.value = '';
    barCodeController.value.clear();
    purchaseController.value.clear();
    quantityController.value.clear();
  }

  // Maps to store id to name/number mapping
  Map<String, String> salemanIdToNameMap = {};
  Map<String, String> companyIdToNameMap = {};

  Future<void> getProduct() async {
    dropdownProduct.clear();
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    await _productApi.getAllProductForWarehouse().then((value) {
      for (var entry in value.body!.products!) {
        dropdownProduct.add(entry.toJson());
        print(entry.toJson());
      }
    }).catchError((error) {
      print('Error Fetching Product Name: $error');
    });
  }

  Future<void> getColor() async {
    dropdownItemsColor.clear();
    await _api.getSpecific({
      "productId": selectProduct.value.toString(),
    }).then((value) {
      // totalQuantityController.value.text =
      //     value.body!.totalQuantity.toString() ?? '0';
      // discountController.value.text =
      //     value.body!.product!.discount.toString() ?? "0";
      for (var entry in value.body!.colors!) {
        dropdownItemsColor.add(entry.toJson());
        print(entry.name.toString());
      }
    }).catchError((error) {
      print('Error Fetching Color Namexxxxx: $error');
    });
  }

  Future<void> getSize() async {
    dropdownItemsSize.clear();
    await _api.getSpecific({
      "productId": selectProduct.value,
      "colorId": selectColor.value,
    }).then((value) {
      print('xxxxxxxxxxxxxxxxxxxxx');
      print(selectCompany.value);

      for (var entry in value.body!.sizes!) {
        dropdownItemsSize.add(entry.toJson());
        print(entry.number);
      }
    }).catchError((error) {
      print('Error Fetching Size Name: $error');
    });
  }

  // Future<void> getCompanyBrandType() async {
  //   // dropdownItemsSize.clear();
  //   await _api.getSpecific({
  //     "productId": selectProduct.value,
  //     "colorId": selectColor.value,
  //     "sizeId": selectSize.value,
  //   }).then((value) {
  //     totalQuantityController.value.text =
  //         value.body!.totalQuantity.toString() ?? '0';

  //     selectCompany.value = value.body?.companies.toString() ?? '';

  //     selectBrand.value = value.body?.brands!.first.id.toString() ?? '';
  //     selectType.value = value.body?.types!.first.id.toString() ?? '';
  //     print('xxxxxxxxxxxxxxxxxxxxx');
  //     print(selectCompany.value);
  //     print('cccccccccccccccccccccccccccccccccc');
  //   }).catchError((error) {
  //     print('Error Fetching Company Name: $error');
  //   });
  // }

  Future<void> getCompanyBrandTypeId() async {
    final url = Uri.parse(AdminApiUrl.dynamicApiPurchaseInvoice);

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
    await _api.getbarcode({
      "bar_code": barcode,
    }).then((value) {
      print(value);
      // // setSearchList(value);
      barCodeController.value.text = barcode;
      // saleInvoiceData.value = SaleInvoiceBarcodeModel.fromJson(value.toJson());

      purchasePrice.value =
          value['body']['product']['purchase_price'].toString();
      productN.value = value['body']['product']['name'].toString();
      sizeN.value = value['body']['sizes']['number'].toString();
      colorN.value = value['body']['colors']['name'].toString();
      selectBrand.value = value['body']['brands']['id'].toString();

      selectProduct.value = value['body']['product']['id'].toString();
      selectColor.value = value['body']['colors']['id'].toString();
      selectSize.value = value['body']['sizes']['id'].toString();
      purchaseController.value.text =
          value['body']['product']['purchase_price'].toString();
      selectCompany.value = value['body']['companies']['id'].toString();
      selectType.value = value['body']['types']['id'].toString();

      // print(saleInvoiceData.value.body!.product!.name);
      // totalQuantity.value = value.body!.totalQuantity ?? '0';
    }).catchError((error) {
      print(error.toString());
      Utils.ErrorToastMessage('sorry no record found!');
      clearFields();
    });
  }

  // Functions to get names/numbers by id

  String? getCompanyName(String companyId) {
    return companyIdToNameMap[companyId];
  }

  String? getSaleman(String salemanId) {
    return salemanIdToNameMap[salemanId];
  }

  Future<void> getCompany() async {
    dropdownCompany.clear();
    await _companyApi.getAll().then((value) {
      for (var entry in value.body!.companies!) {
        dropdownCompany.add(entry.toJson());

        companyIdToNameMap[entry.id.toString()] = entry.name.toString();
      }
    }).catchError((error) {
      print('Error Fetching Customer Name: $error');
    });
  }

  // Get salesman
  // Future<void> getSalesman() async {
  //   await _api.getAllSaleman().then((value) {
  //     for (var entry in value.body!.saleMen!) {
  //       dropdownSalesman.add(entry.toJson());

  //       salemanIdToNameMap[entry.id.toString()] = entry.name.toString();
  //     }
  //   }).catchError((error) {
  //     print('Error Fetching Salesman Name: $error');
  //   });
  // }

  getData() async {
    loadInvoices().then((value) async {
      if (invoices.length == 1) {
        fetchedInvoice.value = (await getInvoiceByNumber(
          invoices[0].invoiceNumber.toString(),
        ))!;

        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        print(fetchedInvoice.value.invoiceNumber);
      }
    });
  }

  @override
  void onInit() {
    getCompany();
    getProduct();
    loadInvoices();
    getPurchaseInvoice();
    // getData();
    super.onInit();
  }

  Future<void> createNewInvoice() async {
    clearFields();
    invoiceNumber.value = await _api.getCounter();
    await _invoiceService.createNewInvoice(invoiceNumber.value);
    loadInvoices();
    Utils.SuccessToastMessage('New invoice created successfully!');
    clearFields();
  }

  Future<void> cleardata() async {
    await _invoiceService.clearDatabase().then((value) {
      print('Database cleared successfully');
    });
  }

  // Future<void> loadInvoices() async {
  //   // clearFields();
  //   loading.value = true;
  //   await _invoiceService.openBox();
  //   invoices.value = await _invoiceService.getInvoices();

  //   loading.value = false;
  // }
  Future<void> loadInvoices() async {
    loading.value = true;

    // Open the invoice service box and fetch all invoices
    await _invoiceService.openBox();
    var allInvoices = await _invoiceService.getInvoices();

    // Check if the list of invoices is not empty
    if (allInvoices.isNotEmpty) {
      // Check if `fetchedInvoice` has a valid invoice number
      // and if `currentPageIndex` is within the range of available invoices
      if (fetchedInvoice.value.invoiceNumber != 0 &&
          currentPageIndex.value >= 0 &&
          currentPageIndex.value < allInvoices.length) {
        // If `fetchedInvoice` has a valid invoice number, update to current page index
        fetchedInvoice.value = allInvoices[currentPageIndex.value];
      } else if (currentPageIndex.value == 0) {
        // If on the first page and no valid fetched invoice, load the first invoice
        fetchedInvoice.value = allInvoices.first;
      } else {
        // Handle case where `currentPageIndex` is out of range or invalid
        // Set the `fetchedInvoice` to a default invoice (if required)
        fetchedInvoice.value =
            allInvoices.first; // Defaulting to the first invoice
      }
    }
    getCompany();

    // Update the invoices list
    invoices.value = allInvoices;

    loading.value = false;
  }

  Future<PurchaseInvoiceLocalStorageModel?> getInvoiceByNumber(
      String invoiceNumber) async {
    clearFields();
    return await _invoiceService.getInvoiceByNumber(invoiceNumber);
  }

  Future<void> addOrUpdateInvoice() async {
    try {
      if (selectProduct.value.isNotEmpty &&
          selectColor.value.isNotEmpty &&
          selectSize.value.isNotEmpty &&
          quantityController.value.text.isNotEmpty) {
        getSubTotal();

        PurchaseInvoiceLocalStorageModel newInvoice =
            PurchaseInvoiceLocalStorageModel(
          invoiceNumber: invoiceNumber.value,
          companyId: selectCompanyDropdown.value,
          subTotal: subTotallist.value,
          totalAmount: totalAmountlist.value,
          receivedAmount: recievedAmount.value.toString(),
          products: [
            PurchaseModel(
              productName: productN.value,
              colorName: colorN.value,
              sizeNumber: sizeN.value,
              productId: selectProduct.value,
              companyId: selectCompany.value,
              brandId: selectBrand.value,
              typeId: selectType.value,
              discount: '0',
              colorId: selectColor.value,
              sizeId: selectSize.value,
              quantity: quantityController.value.text,
              totalAmount: totalAmount.value.toString(),
              subTotal: subTotal.value.toString(),
            ),
          ],
        );
        print(newInvoice.toJson());
        await _invoiceService.addOrUpdateInvoice(newInvoice);

        // print(newInvoice.toJson());
        clearFields();
        loadInvoices();
        if (invoiceNumber.isEmpty) {
          Utils.ErrorToastMessage('Please select sale invoice');
        }
      }
    } catch (e) {
      print('Error adding/updating invoice: $e');
    }
  }

  Future<void> deleteProductFromInvoice(String invoiceNumber, String productId,
      String colorId, String sizeId) async {
    await _invoiceService.deleteProductFromInvoice(
        invoiceNumber, productId, colorId, sizeId);

    clearFields();
    loadInvoices();
  }

  Future<void> deleteInvoice(int index) async {
    loading.value = true;
    clearFields();
    await _invoiceService.deleteInvoices(index);
    loadInvoices();

    loading.value = false;
  }
}
