import 'dart:io'; // Used for native platforms

import 'package:flutter/foundation.dart'; // Used to check if the app is running on the web
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sofi_shoes/date/response/status.dart';
import 'package:sofi_shoes/model/admin/product_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';
import 'package:sofi_shoes/res/utils/utils.dart';
import 'package:universal_html/html.dart' as html; // Used for web file handling

import '../../../date/repository/admin/product/product_repository.dart';
import '../../user_preference/session_controller.dart';

class ProductViewModel extends GetxController {
  final articalName = TextEditingController().obs;
  final barcode = TextEditingController().obs;
  final salePrice = TextEditingController().obs;
  final purchasePrice = TextEditingController().obs;
  final search = TextEditingController().obs;
  RxString searchValue = "".obs;

  Rx<File?> pickImage = Rx<File?>(null); // For mobile
  Rx<html.File?> webImage = Rx<html.File?>(null); // For web

  ImagePicker imagePicker = ImagePicker();

  RxBool loading = false.obs;

  final _api = ProductRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final productList = AProductModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setProductList(AProductModel value) => productList.value = value;
  void setError(String value) => error.value = value;

  // void getAllProduct() {
  //   setRxRequestStatus(Status.LOADING);
  //
  //   _api.getAllProduct().then((value) {
  //     setRxRequestStatus(Status.COMPLETE);
  //     setProductList(value);
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }

  void getForWarehouseProduct() {
    setRxRequestStatus(Status.LOADING);
    _api.getAllProductForWarehouse().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setProductList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  // void refreshApi() {
  //   setRxRequestStatus(Status.LOADING);
  //   _api.getAllProduct().then((value) {
  //     setRxRequestStatus(Status.COMPLETE);
  //     setProductList(value);
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }

  void refreshForWarehouseApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAllProductForWarehouse().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setProductList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void updateProduct(String id) async {
    Map<String, dynamic> data = {
      'name': articalName.value.text,
      'product_code': barcode.value.text,
      'sale_price': salePrice.value.text,
      'purchase_price': purchasePrice.value.text,
    };
    await _api.updateProduct(data, id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Get.back();
        getForWarehouseProduct();
        refreshForWarehouseApi();
        Utils.SuccessToastMessage('update product successful');
        print(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  void deleteProduct(String id) async {
    await _api.deleteProduct(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        Get.back();
        getForWarehouseProduct();
        refreshForWarehouseApi();
        Utils.SuccessToastMessage(value['body']);
        print(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  void clear() {
    articalName.value.clear();
    barcode.value.clear();
    salePrice.value.clear();
    purchasePrice.value.clear();
  }

  /// Add new product
  // Use a ValueNotifier for loading state management
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future<void> addProducts(BuildContext context) async {
    // Start loading
    isLoading.value = true;

    try {
      // Prepare the request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AdminApiUrl.product),
      );

      // Set headers
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${SessionController.user.token ?? ''}",
      };
      request.headers.addAll(headers);

      // Handle image upload based on platform
      if (kIsWeb && webImage.value != null) {
        // Handle image upload for web
        var reader = html.FileReader();
        reader.readAsArrayBuffer(webImage.value!);

        await reader.onLoadEnd.first; // Wait for the file to be fully loaded

        var bytes = reader.result as List<int>;

        var multipartFile = http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: webImage.value!.name,
        );
        request.files.add(multipartFile);
      } else if (!kIsWeb && pickImage.value != null) {
        // Handle image upload for mobile
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          pickImage.value!.path,
          filename: basename(pickImage.value!.path),
        );
        request.files.add(multipartFile);
      }

      // Add other fields to the request
      request.fields['name'] = articalName.value.text;
      request.fields['product_code'] = barcode.value.text;
      request.fields['sale_price'] = salePrice.value.text;
      request.fields['purchase_price'] = purchasePrice.value.text;

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Product added successfully');
        print('Response: $responseData');
        getForWarehouseProduct();
        Navigator.pop(context);
        Utils.SuccessToastMessage('Product added successfully.');
        articalName.value.clear();
        barcode.value.clear();
        salePrice.value.clear();
        purchasePrice.value.clear();
      } else {
        var errorData = await response.stream.bytesToString();
        print('Failed to add product');
        print('Status Code: ${response.statusCode}');
        print('Response: $errorData');
        Utils.ErrorToastMessage('Failed to add product. Please try again.');
      }
    } catch (e) {
      print('Error during product addition: $e');
      Utils.ErrorToastMessage(
          'An error occurred during the product addition. Please try again.');
    } finally {
      // Always stop loading in the finally block to ensure it stops regardless of success or error
      isLoading.value = false;
    }
  }

  getImage(ImageSource source) async {
    if (kIsWeb) {
      // Handle image picking for web
      final pick = await html.FileUploadInputElement()
        ..accept = 'image/*';
      pick.click();

      pick.onChange.listen((e) {
        final files = pick.files;
        print(files!.first.name);
        // if (files!.isEmpty) {
        //   Utils.ErrortoastMessage("Please select your image.");
        //   return;
        // }
        webImage.value = files[0];
        Get.back();
      });
    } else {
      // Handle image picking for mobile
      final pick = await imagePicker.pickImage(source: source);
      if (pick != null) {
        pickImage.value = File(pick.path);
        Get.back();
      } else {
        Utils.ErrorToastMessage("Please select your image.");
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    // getAllProduct();
    getForWarehouseProduct();
    refreshForWarehouseApi();
  }
}
