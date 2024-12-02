import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/sale_report_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class ReturnStockFromWarhouseRepository {
  final _apiService = NetworkApiServices();

  Future<ASaleReportModel> getReturnStock(var data) async {
    dynamic response = await _apiService.postApi(
        data, AdminApiUrl.returnStockFromWarehouseReport);
    return ASaleReportModel.fromJson(response);
  }
}
