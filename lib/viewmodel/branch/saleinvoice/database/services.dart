import 'package:hive_flutter/hive_flutter.dart';

import 'model/sale_invoice_model.dart';

class InvoiceService {
  Box<SaleInvoiceModelLocalStorage>? _invoiceBox;

  Future<void> openBox() async {
    _invoiceBox =
        await Hive.openBox<SaleInvoiceModelLocalStorage>('sale_invoice');
  }

  Future<void> closeBox() async {
    if (_invoiceBox != null) {
      await _invoiceBox!.close();
      _invoiceBox = null;
    }
  }

  Future<void> addOrUpdateInvoice(
      SaleInvoiceModelLocalStorage newInvoice) async {
    if (_invoiceBox == null) {
      await openBox();
    }

    // Ensure the _invoiceBox is opened
    if (_invoiceBox == null) {
      throw Exception("Failed to open the invoice box");
    }

    int existingInvoiceIndex = _invoiceBox!.values.toList().indexWhere(
          (invoice) => invoice.invoiceNumber == newInvoice.invoiceNumber,
        );

    if (existingInvoiceIndex != -1) {
      SaleInvoiceModelLocalStorage? existingInvoice =
          _invoiceBox!.getAt(existingInvoiceIndex);

      if (existingInvoice != null) {
        for (var newProduct in newInvoice.products!) {
          int existingProductIndex = existingInvoice.products!.indexWhere(
            (product) =>
                product.productId == newProduct.productId &&
                product.colorId == newProduct.colorId &&
                product.sizeId == newProduct.sizeId,

          );

          if (existingProductIndex != -1) {
            // Update the existing product
            var existingProduct =
                existingInvoice.products![existingProductIndex];

            // Update quantity and total amount in existing product
            int currentQuantity =
                int.tryParse(existingProduct.quantity ?? '0') ?? 0;
            int newQuantity = int.tryParse(newProduct.quantity ?? '0') ?? 0;

            existingProduct.quantity =
                (currentQuantity + newQuantity).toString();

            existingProduct.subTotal =
                (double.tryParse(existingProduct.subTotal ?? '0')! +
                        double.tryParse(newProduct.subTotal ?? '0')!)
                    .toStringAsFixed(2);

            existingProduct.totalAmount =
                (double.tryParse(existingProduct.totalAmount ?? '0')! +
                        double.tryParse(newProduct.totalAmount ?? '0')!)
                    .toStringAsFixed(2);
            existingProduct.productName = newProduct.productName;
            existingProduct.colorName = newProduct.colorName;
            existingProduct.sizeNumber = newProduct.sizeNumber;
            // existingInvoice.products![existingProductIndex] = updatedProduct;
            // print('Existing Product updated: $updatedProduct');
          } else {
            // Add the new product to the existing invoice
            existingInvoice.products!.add(newProduct);
            print('New product added: $newProduct');
          }
        }

        // Update invoice-level fields   // Update invoice-level fields
        existingInvoice.customerId = newInvoice.customerId;
        existingInvoice.saleMenId = newInvoice.saleMenId ?? '';
        existingInvoice.subTotal = existingInvoice.products!
            .map((product) =>
                double.tryParse(product.subTotal.toString()) ?? 0.0)
            .reduce((a, b) => a + b)
            .toStringAsFixed(2);

        existingInvoice.totalAmount = existingInvoice.products!
            .map((product) =>
                double.tryParse(product.totalAmount.toString()) ?? 0.0)
            .reduce((a, b) => a + b)
            .toStringAsFixed(2);

        await _invoiceBox!.putAt(existingInvoiceIndex, existingInvoice);

        print("Invoice updated");
      } else {
        print("Invoice not found at index: $existingInvoiceIndex");
      }
    }
    //  else {
    //   // Add the new invoice
    //   newInvoice.subTotal = newInvoice.products!
    //       .map((product) => double.tryParse(product.subTotal.toString()) ?? 0.0)
    //       .reduce((a, b) => a + b)
    //       .toStringAsFixed(2);

    //   newInvoice.totalAmount = newInvoice.products!
    //       .map((product) =>
    //           double.tryParse(product.totalAmount.toString()) ?? 0.0)
    //       .reduce((a, b) => a + b)
    //       .toStringAsFixed(2);

    //   await _invoiceBox!.add(newInvoice);

    //   print("New invoice added");
    // }
  }

  Future<List<SaleInvoiceModelLocalStorage>> getInvoices() async {
    if (_invoiceBox == null) {
      await openBox();
    }

    return _invoiceBox!.values.toList();
  }

  Future<SaleInvoiceModelLocalStorage?> getInvoiceByNumber(
      String invoiceNumber) async {
    if (_invoiceBox == null) {
      await openBox();
    }

    try {
      return _invoiceBox!.values.firstWhere(
        (invoice) => invoice.invoiceNumber == invoiceNumber,
      );
    } catch (e) {
      print(e.toString()); // Return null if no invoice is found
    }
    return null;
  }

  Future<void> updateInvoice(
      int index, SaleInvoiceModelLocalStorage invoice) async {
    if (_invoiceBox == null) {
      await openBox();
    }

    await _invoiceBox!.putAt(index, invoice);

    print("Invoice updated");
  }

  Future<void> deleteInvoices(int index) async {
    if (_invoiceBox == null) {
      await openBox();
    }

    await _invoiceBox!.deleteAt(index);
  }

  // Future<void> deleteProductFromInvoice(String invoiceNumber, String productId,
  //     String colorId, String sizeId) async {
  //   if (_invoiceBox == null) {
  //     await openBox();
  //   }

  //   int existingInvoiceIndex = _invoiceBox!.values.toList().indexWhere(
  //         (invoice) => invoice.invoiceNumber == invoiceNumber,
  //       );

  //   if (existingInvoiceIndex != -1) {
  //     SaleInvoiceModel? existingInvoice =
  //         _invoiceBox!.getAt(existingInvoiceIndex);

  //     if (existingInvoice != null) {
  //       int existingProductIndex = existingInvoice.products!.indexWhere(
  //         (product) =>
  //             product.productId == productId &&
  //             product.colorId == colorId &&
  //             product.sizeId == sizeId,
  //       );

  //       if (existingProductIndex != -1) {
  //         existingInvoice.products!.removeAt(existingProductIndex);

  //         // Recalculate invoice-level subTotal and totalAmount
  //         existingInvoice.subTotal = existingInvoice.products!
  //             .map((product) =>
  //                 double.tryParse(product.subTotal.toString()) ?? 0.0)
  //             .reduce((a, b) => a + b)
  //             .toStringAsFixed(2);

  //         existingInvoice.totalAmount = existingInvoice.products!
  //             .map((product) =>
  //                 double.tryParse(product.totalAmount.toString()) ?? 0.0)
  //             .reduce((a, b) => a + b)
  //             .toStringAsFixed(2);
  //         await _invoiceBox!.putAt(existingInvoiceIndex, existingInvoice);

  //         print("Product removed from invoice: $invoiceNumber");
  //       } else {
  //         print("Product not found in invoice: $invoiceNumber");
  //       }
  //     } else {
  //       print("Invoice not found: $invoiceNumber");
  //     }
  //   } else {
  //     print("Invoice not found: $invoiceNumber");
  //   }
  // }

  Future<void> deleteProductFromInvoice(String invoiceNumber, String productId,
      String colorId, String sizeId) async {
    try {
      // Ensure the invoice box is open
      if (_invoiceBox == null) {
        await openBox();
      }

      // Find the index of the invoice with the given invoiceNumber
      int existingInvoiceIndex = _invoiceBox!.values.toList().indexWhere(
            (invoice) => invoice.invoiceNumber == invoiceNumber,
          );

      if (existingInvoiceIndex != -1) {
        SaleInvoiceModelLocalStorage? existingInvoice =
            _invoiceBox!.getAt(existingInvoiceIndex);

        if (existingInvoice != null) {
          // Find the index of the product with the given productId, colorId, and sizeId
          int existingProductIndex = existingInvoice.products!.indexWhere(
            (product) =>
                product.productId == productId &&
                product.colorId == colorId &&
                product.sizeId == sizeId,
          );

          if (existingProductIndex != -1) {
            // Remove the product from the invoice
            existingInvoice.products!.removeAt(existingProductIndex);

            // Recalculate invoice-level subTotal and totalAmount
            if (existingInvoice.products!.isNotEmpty) {
              existingInvoice.subTotal = existingInvoice.products!
                  .map((product) =>
                      double.tryParse(product.subTotal.toString()) ?? 0.0)
                  .reduce((a, b) => a + b)
                  .toStringAsFixed(2);

              existingInvoice.totalAmount = existingInvoice.products!
                  .map((product) =>
                      double.tryParse(product.totalAmount.toString()) ?? 0.0)
                  .reduce((a, b) => a + b)
                  .toStringAsFixed(2);
            } else {
              existingInvoice.subTotal = '0.00';
              existingInvoice.totalAmount = '0.00';
            }

            // Update the invoice in the box
            await _invoiceBox!.putAt(existingInvoiceIndex, existingInvoice);

            print("Product removed from invoice: $invoiceNumber");
          } else {
            print("Product not found in invoice: $invoiceNumber");
          }
        } else {
          print("Invoice not found: $invoiceNumber");
        }
      } else {
        print("Invoice not found: $invoiceNumber");
      }
    } catch (e) {
      print("Error deleting product from invoice: $e");
    }
  }

  Future<SaleInvoiceModelLocalStorage?> createNewInvoice(
      String invoiceNumber) async {
    if (_invoiceBox == null) {
      await openBox();
    }

    try {
      // Generate a new empty invoice
      var newInvoice = SaleInvoiceModelLocalStorage(
        // Provide default values or leave them empty as needed
        invoiceNumber: invoiceNumber,
        customerId: '',
        saleMenId: '',
        products: [], // Start with an empty list of products
        subTotal: '0', // Provide default values for numerical fields
        totalAmount: '0',
      );

      await _invoiceBox!.add(newInvoice);
      return newInvoice;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> clearDatabase() async {
    if (_invoiceBox == null) {
      await openBox();
    }
    await _invoiceBox!.clear();

    print("Database cleared");
  }
}
