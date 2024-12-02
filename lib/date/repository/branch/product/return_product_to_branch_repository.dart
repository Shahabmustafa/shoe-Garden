import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/product/return_product_to_branch_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BReturnProductToBranchRepository {
  final _apiService = NetworkApiServices();

  Future<BReturnProductToBranchModel> getAll() async {
    dynamic response =
        await _apiService.getApi(BranchApiUrl.returnProductToBranch);
    return BReturnProductToBranchModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, BranchApiUrl.returnProductToBranch);
    return response;
  }
}
