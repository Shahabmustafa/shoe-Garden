import 'package:sofi_shoes/res/apiurl/warehouse_api_url.dart';

import '../../../../model/admin/specific_branch_stock_position_model.dart';
import '../../../../model/warehouse/warehouse_branch_stock_model.dart';
import '../../../network/network_api_service.dart';

class WBranchStockRepository {
  final _apiService = NetworkApiServices();

  Future<WBranchStockModel> getAll() async {
    dynamic response = await _apiService.getApi(WarehouseApiUrl.branchStock);
    return WBranchStockModel.fromJson(response);
  }

  Future<SpecificBranchStockPositionModel> specificBranch(String id) async {
    dynamic response = await _apiService.specificGetData("${WarehouseApiUrl.specificBranchStock}/${id}");
    return SpecificBranchStockPositionModel.fromJson(response);
  }
}
