import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/company_ladger_model.dart';
import 'package:sofi_shoes/model/admin/customer_leger_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class LedgerRepository {
  final _apiService = NetworkApiServices();

  Future<ACompanyLedgerReportModel> getCompanyLedger(var data) async {
    dynamic response =
        await _apiService.postApi(data,AdminApiUrl.companyLedgerReport);
    return ACompanyLedgerReportModel.fromJson(response);
  }

  Future<ACustomerLedgerReportModel> getCustomerLedger(var data) async {
    dynamic response =
        await _apiService.postApi(data,AdminApiUrl.customerLedgerReport);
    return ACustomerLedgerReportModel.fromJson(response);
  }
}
