import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/all_stock_of_different_branches_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

class AllStockOfDifferentBranchesRepository {
  final _apiService = NetworkApiServices();

  Future<AllStockOfDifferentBranchesModel> getAll() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.getAllStockOfDifferentBranch);
    return AllStockOfDifferentBranchesModel.fromJson(response);
  }
}
