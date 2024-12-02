import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/branch_dynamic_product_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BranchSearchDynamicProductRepository {
  final _apiService = NetworkApiServices();

  Future<BranchSearchDynamicProductModel> getSpecific(var data) async {
    final response = await _apiService.postApi(
      data,
      BranchApiUrl.branchSearchDynamicProductStock,
    );
    return BranchSearchDynamicProductModel.fromJson(response);
  }

  Future<dynamic> getBarcode(var data) async {
    final response = await _apiService.postApi(
      data,
      BranchApiUrl.branchSearchDynamicProductStock,
    );
    return response;
  }
}
