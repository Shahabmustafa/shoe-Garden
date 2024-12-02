import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/admin/customer_model.dart';
import '../../../../model/admin/saleman_model.dart';
import '../../../../model/branch/sale_invoice/item_sale_return_model.dart';
import '../../../../model/branch/sale_invoice/sale_invoice_dynamic_search_model.dart';
import '../../../../model/branch/sale_invoice/sale_return_invoice.dart';

class SaleReturnInvoiceRespository {
  final _apiService = NetworkApiServices();

  Future<ACustomerModel> getAllCustomer() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.getAllCustomer);
    return ACustomerModel.fromJson(response);
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

  Future<dynamic> addSaleReturnInvoice(var data) async {
    dynamic response =
        await _apiService.postApiJson(data, BranchApiUrl.saleReturnInvoice);
    return response;
  }

  Future<SaleReturnModel> getSaleReturnInvoice() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.saleReturnInvoice);
    return SaleReturnModel.fromJson(response);
  }

  Future<ReturnedItemSaleInvoiceModel> getSpecificReturnInvoice(var id) async {
    dynamic response = await _apiService
        .specificGetData("${BranchApiUrl.saleReturnInvoice}/$id");
    return ReturnedItemSaleInvoiceModel.fromJson(response);
  }
}
