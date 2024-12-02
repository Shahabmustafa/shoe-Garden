import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/target/b_branch_target_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BTargetRepository {
  final _apiService = NetworkApiServices();

  Future<BBranchTargetModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.branchTarget);
    return BBranchTargetModel.fromJson(response);
  }
}
