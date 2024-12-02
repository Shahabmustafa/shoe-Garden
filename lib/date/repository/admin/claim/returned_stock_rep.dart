import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/admin/return_stock_warehouse_model.dart';
import '../../../../model/admin/returned_stock_branch_model.dart';

class ReturnedStockRepository {
  final _apiService = NetworkApiServices();

  Future<AReturnedStockWarehouseModel> getAllReturnedStockWarehouse() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.returnedStockWarehouse);
    return AReturnedStockWarehouseModel.fromJson(response);
  }

  Future<AReturnedStockBranchModel> getAllReturnedStockBranch() async {
    dynamic response =
        await _apiService.getApi(AdminApiUrl.returnedStockBranch);
    return AReturnedStockBranchModel.fromJson(response);
  }
}
