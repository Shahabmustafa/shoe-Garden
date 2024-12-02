import '../../../../model/admin/all_branch_sale_reports_model.dart';
import '../../../../res/apiurl/admin_api_url.dart';
import '../../../network/network_api_service.dart';

class AllBranchesSaleReportRepository {
  final _apiService = NetworkApiServices();

  Future<AllBranchesSaleReportModel> getBranchSaleReport(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.allBranchSaleReports);
    return AllBranchesSaleReportModel.fromJson(response);
  }

}
