import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/dashboard_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class DashboardRepository {
  final _apiService = NetworkApiServices();

  Future<ADashboardModel> getAll() async {
    dynamic response = await _apiService.getApi(AdminApiUrl.dashboard);
    return ADashboardModel.fromJson(response);
  }
}
