import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';
import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/admin/brand_model.dart';
import '../../../../model/admin/company_model.dart';
import '../../../../model/admin/customer_model.dart';
import '../../../../model/admin/saleman_model.dart';
import '../../../../model/admin/warehouse_model.dart';
import '../../../../model/branch/sale_invoice/sale_invoice_dynamic_search_model.dart';
import '../../../../model/branch/sale_invoice/sale_invoice_models.dart';
import '../../../../model/branch/sale_invoice/sale_return_invoice.dart';

class SaleInvoiceRespository {
  final _apiService = NetworkApiServices();

  Future<ACustomerModel> getAllCustomer() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.getAllCustomer);
    return ACustomerModel.fromJson(response);
  }

  Future<ACompanyModel> getAllCompany() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.company);
    return ACompanyModel.fromJson(response);
  }

  Future<ABrandModel> getAllBrand() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.brand);
    return ABrandModel.fromJson(response);
  }

  Future<ASalemenModel> getAllSaleman() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.getAllSaleman);
    return ASalemenModel.fromJson(response);
  }

  Future<SaleInvoiceDynamicSearchModel> getSpecific(var data) async {
    final response = await _apiService.postApi(
      data,
      BranchApiUrl.saleInvoiceDynamicApi,
    );
    return SaleInvoiceDynamicSearchModel.fromJson(response);
  }

  Future<dynamic> addSaleInvoice(var data) async {
    dynamic response =
        await _apiService.postApiJson(data, BranchApiUrl.saleInvoice);
    return response;
  }

  Future<SaleInvoiceModels> getSaleInvoice() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.saleInvoice);
    return SaleInvoiceModels.fromJson(response);
  }

  Future<SaleInvoiceModels> specificSaleInvoice(var id) async {
    dynamic response = await _apiService
        .specificGetData("${BranchApiUrl.saleInvoice}/$id?_method=patch");
    return SaleInvoiceModels.fromJson(response);
  }

  Future<AWarehouseModel> getAllWarehouse() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.warehouse);
    return AWarehouseModel.fromJson(response);
  }

  Future<dynamic> getBarcode(var data) async {
    final response = await _apiService.postApi(
      data,
      BranchApiUrl.saleInvoiceDynamicApi,
    );
    return response;
  }

  Future<String> getCounter() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.counter);
    if (response != null && response['success'] == true) {
      return response['body'].toString();
    } else {
      throw Exception('Failed to fetch counter value');
    }
  }

  /// filter invoice

  /// get sale invoice with date
  Future<SaleInvoiceModels> filterSaleInvoice(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.saleInvoiceReport);
    return SaleInvoiceModels.fromJson(response);
  }

  /// get sale return invoice with date
  Future<SaleReturnModel> filterSaleReturnInvoice(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.saleReturnInvoiceReport);
    return SaleReturnModel.fromJson(response);
  }


  /// warehouse get sale invoice with date
  Future<SaleInvoiceModels> warehouseFilterSaleInvoice(var data) async {
    dynamic response = await _apiService.postApi(data, WarehouseApiUrl.saleInvoiceReport);
    return SaleInvoiceModels.fromJson(response);
  }

  /// warehouse get sale return invoice with date
  Future<SaleReturnModel> warehouseFilterSaleReturnInvoice(var data) async {
    dynamic response = await _apiService.postApi(data, WarehouseApiUrl.saleReturnInvoiceReport);
    return SaleReturnModel.fromJson(response);
  }
}
