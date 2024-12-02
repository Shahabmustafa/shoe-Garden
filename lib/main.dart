import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sofi_shoes/res/root/app_view.dart';

import 'viewmodel/branch/saleinvoice/database/model/sale_invoice_model.dart';
import 'viewmodel/user_preference/session_controller.dart';
import 'viewmodel/warehouse/purchase invoice/database/model/purchase_invoice_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(SaleInvoiceModelLocalStorageAdapter());
    Hive.registerAdapter(InvoiceProductsAdapter());
    Hive.registerAdapter(PurchaseInvoiceLocalStorageModelAdapter());
    Hive.registerAdapter(PurchaseModelAdapter());

    // Open boxes
    await Hive.openBox<SaleInvoiceModelLocalStorage>('sale_invoices');
    await Hive.openBox<PurchaseInvoiceLocalStorageModel>('purchase_invoices');
    // Initialize session
    await SessionController().getUserFromPreference();
  } catch (e) {
    // Handle any errors during Hive initialization or adapter registration
    print("Error initializing Hive or registering adapters: $e");
  }

  runApp(
    const App(), // Wrap your app
  );
}

