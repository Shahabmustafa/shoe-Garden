import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

import '../../../../model/branch/dashboard/branch_dashboard_model.dart';

class BranchDashboardRepository {
  final _apiService = NetworkApiServices();

  Future<BranchDashboardModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.branchDashboard);
    return BranchDashboardModel.fromJson(response);
  }
}
