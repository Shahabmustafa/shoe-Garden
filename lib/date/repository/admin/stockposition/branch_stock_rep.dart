import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/assign_stock_branch_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/specific_branch_stock_position_model.dart';

class BranchStockRepository {
  final _apiService = NetworkApiServices();

  Future<AAssignStockToBranchModel> getAll() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.branchStockPosition);
    return AAssignStockToBranchModel.fromJson(response);
  }

  Future<SpecificBranchStockPositionModel> getSpecific(var id) async {
    dynamic response = await _apiService.specificGetData("${AdminApiUrl.specificBranchStockPosition}/$id");
    return SpecificBranchStockPositionModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response =
        await _apiService.postApi(data, AdminApiUrl.branchAssignStock);
    return response;
  }

  Future<dynamic> delete(var id) async {
    dynamic response =
        await _apiService.deleteApi('${AdminApiUrl.branchAssignStock}/$id');
    return response;
  }

  Future<dynamic> update(var data, var id) async {
    dynamic response = await _apiService.updateApi(
        data, "${AdminApiUrl.branchAssignStock}/$id?_method=patch");
    return response;
  }
}
