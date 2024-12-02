import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:number_paginator/number_paginator.dart';
import 'package:sofi_shoes/res/utils/utils.dart';

import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/repository/branch/sale invoice/sale_invoice_respository.dart';
import '../../../date/request_header.dart';
import '../../../date/response/status.dart';
import '../../../model/branch/sale_invoice/sale_invoice_barcode_model.dart';
import '../../../res/apiurl/branch_api_url.dart';
import '../../../view/Branch/drawer/saleinvoice/export/sale_invoice_export.dart';
import 'database/model/sale_invoice_model.dart';
import 'database/services.dart';

class InvoiceController extends GetxController {
  final search = TextEditingController().obs;
  final InvoiceService _invoiceService = InvoiceService();

  final Rx<NumberPaginatorController> numberPaginatorController = NumberPaginatorController().obs;
  var invoices = <SaleInvoiceModelLocalStorage>[].obs;
  var invoicesName = <SaleInvoiceModelLocalStorage>[].obs;
  final Rx<SaleInvoiceModelLocalStorage> fetchedInvoice = SaleInvoiceModelLocalStorage(customerId: '').obs;

  RxList dropdownSalesman = [].obs;
  RxList dropdownCustomer = [].obs;
  RxList dropdownItemsColor = [].obs;
  RxList dropdownItemsSize = [].obs;
  RxList dropdownProduct = [].obs;

  RxString selectedCustomer = ''.obs;
  RxString selectSalesman = ''.obs;
  RxInt currentPageIndex = 0.obs;

  RxString selectColor = ''.obs;
  RxString selectMethod = ''.obs;
  RxString selectSize = ''.obs;
  RxString selectProduct = ''.obs;
  RxString selectType = ''.obs;
  RxString selectBrand = ''.obs;
  RxString selectCompany = ''.obs;

  RxInt totalQuantity = 0.obs;

  RxInt invoiceIndex = 0.obs;
  RxString quantity = ''.obs;
  RxString salePrice = ''.obs;
  RxString discount = ''.obs;

  RxDouble subTotal = 0.0.obs;
  RxString totalAmount = "".obs;
  RxString totalAmountlist = "".obs;
  RxString subTotallist = "".obs;
  RxDouble recievedAmount = 0.0.obs;
  RxDouble balance = 0.0.obs;
  RxDouble customerBalance = 0.0.obs;

  RxDouble customerTotalBalance = 0.0.obs;

  Map<String, String> salemanIdToNameMap = {};
  Map<String, String> customerIdToNameMap = {};

  final quantityController = TextEditingController().obs;
  final saleController = TextEditingController().obs;
  final totalQuantityController = TextEditingController().obs;
  final discountController = TextEditingController().obs;
  final barCodeController = TextEditingController().obs;
  final receivedAmountController = TextEditingController().obs;

  // Repositories
  final _api = SaleInvoiceRespository();
  final _productApi = ProductRepository();

  RxBool loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  RxString productN = ''.obs;
  RxString colorN = ''.obs;
  RxString sizeN = ''.obs;
  RxString invoiceNumber = ''.obs;

  Future<void> addSaleInvoice() async {
    try {
      loading.value = true;
      fetchedInvoice.value.customerId = selectedCustomer.value;

      fetchedInvoice.value.saleMenId = selectSalesman.value;

      Map<String, dynamic> saleData = {
        "invoice_number": fetchedInvoice.value.invoiceNumber,
        "customer_id": 18,
        "sale_men_id": fetchedInvoice.value.saleMenId,
        "sub_total": fetchedInvoice.value.subTotal,
        "total_amount": fetchedInvoice.value.totalAmount,
        "received_amount": fetchedInvoice.value.totalAmount,
        "payment_method": selectMethod.value,
        "products": fetchedInvoice.value.products!.map((product) => {
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
        }).toList(),
      };
      String jsonData = jsonEncode(saleData);
      print('JSON Data: $jsonData');

      // Call the API with the serialized data

      final response = await _api.addSaleInvoice(jsonData);

      loading.value = false;

      // Debug: Print the response
      print('API Response: $response');

      if (response['success'] == true && response['error'] == null) {
        loading.value = false;
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
        print(response);
        // Extract relevant data from response body
        var invoice = response['body']['sale_invoice'];
        var customer = invoice[
            'customer']; // Use invoice['customer'] instead of response['body']['customer']
        var salesman = invoice[
            'saleman']; // Use invoice['saleman'] instead of response['body']['saleman']
        var products = invoice['invoice_products'];
        DateTime createdAt = DateTime.parse(invoice['created_at']);
        // Create invoice data for export
        final invoiceData = InvoiceExport(
          id: invoice['invoice_number'].toString(), // Ensure ID is a string if required
          date: createdAt,
          paymentMethod: invoice["payment_method"],
          saleman: Salesman(name: salesman['name']),
          customer: Customer(name: customer['name']),
          total: invoice['total_amount'].toString(),
          items: products.map<InvoiceItem>((product) {
            var prod = product['product'];
            return InvoiceItem(
                product: prod['name'] ?? 'Unknown',
                salePrice: product['sale_price'].toString(),
                qty: product['quantity'] ?? 'x',
                dis: product['discount'] != null
                    ? "${product['discount']}%"
                    : "Null",
                subTotal: product['sub_total'] != null
                    ? product['sub_total'].toString()
                    : 'null',
                totalAmount: product['total_amount'] != null
                    ? product['total_amount'].toString()
                    : 'null');
          }).toList(),
        );

        print('xxxxxxxxxxxmmmmmmmmmmmmmmmmmm');
        print(invoiceData.customer);

        Utils.SuccessToastMessage('Successfully sold');
        await generateInvoice(invoiceData);

        deleteInvoice(invoiceIndex.value);
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
    double salePrice = double.tryParse(saleController.value.text) ?? 0.0;
    int quantity = int.tryParse(quantityController.value.text) ?? 0;
    double discount = double.tryParse(discountController.value.text) ?? 0.0;

    subTotal.value = salePrice * quantity;
    totalAmount.value =
        (subTotal.value * (1 - discount / 100)).toStringAsFixed(2);

    customerTotalBalance.value = customerBalance.value +
        double.parse(fetchedInvoice.value.totalAmount.toString());
  }

  void setRecievedAmount(String value) {
    recievedAmount.value = double.tryParse(value) ?? 0.0;
    balance.value = customerTotalBalance.value - recievedAmount.value;
  }

  void clearFields() {
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    selectProduct.value = '';
    productN.value = '';
    sizeN.value = '';
    colorN.value = '';
    barCodeController.value.clear();
    saleController.value.clear();
    totalQuantityController.value.clear();
    quantityController.value.clear();
    discountController.value.clear();
    selectMethod.value = '';
  }

  String? getCustomerName(String customerId) {
    return customerIdToNameMap[customerId];
  }

  String? getSaleman(String salemanId) {
    return salemanIdToNameMap[salemanId];
  }

  Future<void> getProduct() async {
    dropdownProduct.clear();
    dropdownItemsColor.clear();
    dropdownItemsSize.clear();
    await _productApi.getAllProduct().then((value) {
      for (var entry in value.body!.products!) {
        dropdownProduct.add(entry.toJson());
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
    await _api.getSpecific({
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
    await _api.getBarcode({
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

  Future<void> getCustomer() async {
    await _api.getAllCustomer().then((value) {
      for (var entry in value.body!.customers!) {
        dropdownCustomer.add(entry.toJson());
        customerIdToNameMap[entry.id.toString()] = entry.name.toString();
      }
    }).catchError((error) {
      print('Error Fetching Customer Name: $error');
    });
  }

  // Get salesman
  Future<void> fetchAllSaleman() async {
    dropdownSalesman.clear();
    try {
      await _api.getAllSaleman().then((value) {
        for (var entry in value.body!.saleMen!) {
          dropdownSalesman.add(entry.toJson());

          salemanIdToNameMap[entry.id.toString()] = entry.name.toString();
          print('xxxxxxxxxxxxxxxxxxxxcccccccccc');
          print(entry.toJson());
        }
      }).catchError((error) {
        print('Error Fetching Customer Name: $error');
      });
    } catch (e) {
      print(e.toString());
    }
  }

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
    getCustomer();
    getProduct();
    loadInvoices();
    fetchAllSaleman();
    getData();
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

    fetchAllSaleman();
    // Update the invoices list
    invoices.value = allInvoices;

    loading.value = false;
  }

  Future<SaleInvoiceModelLocalStorage?> getInvoiceByNumber(
      String invoiceNumber) async {
    clearFields();
    return await _invoiceService.getInvoiceByNumber(invoiceNumber);
  }

  Future<void> addOrUpdateInvoice() async {
    // Parse quantity safely
    int quantity = int.tryParse(quantityController.value.text) ?? 0;
    int totalQuantity = int.tryParse(totalQuantityController.value.text) ?? 0;
    // Check if total quantity is greater than quantity

    try {
      if (selectProduct.value.isNotEmpty &&
          selectColor.value.isNotEmpty &&
          selectSize.value.isNotEmpty &&
          // selectMethod.value.isNotEmpty &&
          quantityController.value.text.isNotEmpty) {
        getSubTotal();

        SaleInvoiceModelLocalStorage newInvoice = SaleInvoiceModelLocalStorage(
          invoiceNumber: invoiceNumber.value,
          saleMenId: selectSalesman.value.toString(),
          customerId: selectedCustomer.value,
          products: [
            InvoiceProducts(
              productId: selectProduct.value,
              productName: productN.value,
              colorName: colorN.value,
              sizeNumber: sizeN.value,
              companyId: selectCompany.value,
              brandId: selectBrand.value,
              typeId: selectType.value,
              discount: discountController.value.text,
              colorId: selectColor.value,
              sizeId: selectSize.value,
              quantity: quantityController.value.text,
              totalAmount: totalAmount.value,
              subTotal: subTotal.value.toString(),
            ),
          ],
        );

        print(newInvoice.toJson());

        if (totalQuantity < quantity) {
          Utils.ErrorToastMessage(
              'Cannot add product: Entered quantity is greater than available quantity');
          return;
        } else {
          await _invoiceService.addOrUpdateInvoice(newInvoice);
          clearFields();
          loadInvoices();
        }
        // invoice index
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
