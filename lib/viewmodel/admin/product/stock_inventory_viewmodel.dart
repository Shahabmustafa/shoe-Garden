import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../date/repository/admin/company/company_repository.dart';
import '../../../date/repository/admin/product/brand_repository.dart';
import '../../../date/repository/admin/product/color_repository.dart';
import '../../../date/repository/admin/product/product_repository.dart';
import '../../../date/repository/admin/product/size_repository.dart';
import '../../../date/repository/admin/product/stock_inventory_repository.dart';
import '../../../date/response/status.dart';
import '../../../model/admin/stock_inventory_model.dart';
import '../../../res/utils/utils.dart';

class StockInventoryViewModel extends GetxController {
  final quantity = TextEditingController().obs;
  final addNewQuantity = TextEditingController().obs;
  final barcode = TextEditingController().obs;

  RxList companyDropdownItems = [].obs;
  RxList brandDropdownItems = [].obs;
  RxList productDropdownItems = [].obs;
  RxList colorDropdownItems = [].obs;
  RxList sizeDropdownItems = [].obs;
  RxString company = "".obs;
  RxString brand = "".obs;
  RxString product = "".obs;
  RxString color = "".obs;
  RxString size = "".obs;
  RxString type = "".obs;
  final search = TextEditingController().obs;
  final searchValue = ''.obs;
  RxBool loading = false.obs;

  final _companyApi = CompanyRespository();
  final _brandApi = BrandRepository();
  final _productApi = ProductRepository();
  final _colorApi = ColorRepository();
  final _sizeApi = SizeRespository();
  final _api = StockInventoryRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final stockInventoryList = AStockInventoryModel().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setStockInventoryList(AStockInventoryModel value) =>
      stockInventoryList.value = value;
  void setError(String value) => error.value = value;

  /// show data on ui
  void getAllStockInventory() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setStockInventoryList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshApi() {
    setRxRequestStatus(Status.LOADING);
    _api.getAll().then((value) {
      setRxRequestStatus(Status.COMPLETE);
      setStockInventoryList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  /// add new stock inventory
  void addStockInventory() {
    try {
      loading.value = true;
      Map data = {
        "product_id": product.value,
        "company_id": company.value,
        "brand_id": brand.value,
        "type_id": type.value,
        "color_id": color.value,
        "size_id": size.value,
        "quantity": quantity.value.text,
        "barcode": barcode.value.text,
      };
      _api.add(data).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          // clear();
          getAllStockInventory();
          Get.back();
          Utils.SuccessToastMessage(
            'Add Stock Inventory',
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

  /// delete stock inventory
  void deleteStockInventory(String id) async {
    await _api.delete(id).then((value) {
      if (value['success'] == true && value['error'] == null) {
        getAllStockInventory();

        Get.back();
        Utils.SuccessToastMessage(value['body']);
      } else {
        Utils.ErrorToastMessage(value['error']);
      }
    });
  }

  /// update stock inventory
  void updateStockInventory(String userId) async {
    try {
      loading.value = true;
      Map data = {
        "product_id": product.value,
        "company_id": company.value,
        "brand_id": brand.value,
        "type_id": type.value,
        "color_id": color.value,
        "size_id": size.value,
        "quantity": quantity.value.text,
        "barcode": barcode.value.text.toString(),
        "add_new_quantity": addNewQuantity.value.text,
      };
      await _api.update(data, userId).then((value) {
        loading.value = false;
        if (value['success'] == true && value['error'] == null) {
          getAllStockInventory();
          Get.back();
          Utils.SuccessToastMessage('Update Stock Inventory');
        } else {
          Utils.ErrorToastMessage(value['error']);
          print(value["error"]);
        }
      });
    } catch (e) {
      loading.value = false;
      Utils.ErrorToastMessage(e.toString());
    }
  }

  /// show on company name in dropdown
  void companyDropDown() {
    _companyApi.getAll().then((value) {
      for (var entry in value.body!.companies!) {
        companyDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Company names: $error');
      // Set loading state to false
    });
  }

  /// show on brand name in dropdown
  void brandDropDown() {
    _brandApi.getAll().then((value) {
      for (var entry in value.body!.brands!) {
        brandDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Company names: $error');
      // Set loading state to false
    });
  }

  /// show on product name in dropdown
  void productDropDown() {
    _productApi.getAllProductForWarehouse().then((value) {
      for (var entry in value.body!.products!) {
        productDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Product names: $error');
      // Set loading state to false
    });
  }

  /// show on color name in dropdown
  void colorDropDown() {
    _colorApi.getAll().then((value) {
      for (var entry in value.body!.colors!) {
        colorDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Color names: $error');
      // Set loading state to false
    });
  }

  /// show on size name in dropdown
  void sizeDropDown() {
    _sizeApi.getAll().then((value) {
      for (var entry in value.body!.sizes!) {
        sizeDropdownItems.add(entry.toJson());
      }
    }).catchError((error) {
      print('Error fetching Size names: $error');
      // Set loading state to false
    });
  }

  String findCompany(String companyId) {
    for (var company in companyDropdownItems) {
      if (company['id'].toString() == companyId) {
        return company['name'];
      }
    }
    return 'Company not found'; // Default message if branch not found
  }

  String findBrand(String branchId) {
    for (var branch in brandDropdownItems) {
      if (branch['id'].toString() == branchId) {
        return branch['name'];
      }
    }
    return 'Brand not found'; // Default message if branch not found
  }

  String findProduct(String productId) {
    for (var product in productDropdownItems) {
      if (product['id'].toString() == productId) {
        return product['name'];
      }
    }
    return 'Product not found'; // Default message if branch not found
  }

  String findColor(String colorId) {
    for (var color in colorDropdownItems) {
      if (color['id'].toString() == colorId) {
        return color['name'];
      }
    }
    return 'Color not found'; // Default message if branch not found
  }

  String findSize(String sizeId) {
    for (var size in sizeDropdownItems) {
      if (size['id'].toString() == sizeId) {
        return size['number'];
      }
    }
    return 'Size not found'; // Default message if branch not found
  }

  clearDropDown() {
    company.value = "";
    brand.value = "";
    product.value = "";
    color.value = "";
    size.value = "";
    type.value = "";
    barcode.value.clear();
    quantity.value.clear();
  }

  void printBarcode(BuildContext context, String? barcodeData, String? articalN,
      String? colorN, String? sizeN) async {
    final pdf = pw.Document();
    // Define a custom page size for barcode printing
    final pageSize =
        PdfPageFormat(120 * PdfPageFormat.mm, 50 * PdfPageFormat.mm);
    pdf.addPage(
      pw.Page(
        pageFormat: pageSize, // Set the custom page size
        build: (context) {
          return pw.Padding(
              padding: const pw.EdgeInsets.all(5), // Adding some padding

              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.only(left: 15),
                    child: pw.Text(
                      articalN!,
                      style: pw.TextStyle(
                        fontSize: 10, // Smaller font size
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.BarcodeWidget(
                    data: barcodeData!,
                    barcode: pw.Barcode.code128(),
                    width: 120, // Reduced width to fit the small page
                    height: 40, // Reduced height for a more compact barcode
                  ),
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.only(left: 15),
                          child: pw.Text(
                            colorN!,
                            style: pw.TextStyle(
                              fontSize: 10, // Smaller font size
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                        pw.SizedBox(width: 10),
                        pw.Text(
                          sizeN!,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ])
                ],
              ));
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      format: pageSize,
    );
  }

  @override
  void onInit() {
    getAllStockInventory();
    brandDropDown();
    colorDropDown();
    productDropDown();
    companyDropDown();
    sizeDropDown();
    super.onInit();
  }
}
