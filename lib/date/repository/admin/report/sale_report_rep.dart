import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/sale_report_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class SaleReportRepository {
  final _apiService = NetworkApiServices();

  Future<ASaleReportModel> getSaleReport(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.saleReport);
    return ASaleReportModel.fromJson(response);
  }
}
