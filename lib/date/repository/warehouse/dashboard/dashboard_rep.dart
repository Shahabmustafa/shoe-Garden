import 'package:sofi_shoes/model/warehouse/warehouse_dashboard_model.dart';

import '../../../../res/apiurl/warehouse_api_url.dart';
import '../../../network/network_api_service.dart';

class WarehouseDashboardRepository {
  final _apiService = NetworkApiServices();

  Future<WarehouseDashboardModel> getAll() async {
    dynamic response =
        await _apiService.getApi(WarehouseApiUrl.warehouseDashboard);
    return WarehouseDashboardModel.fromJson(response);
  }
}
