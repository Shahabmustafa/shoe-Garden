import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/admin/specific_branch_stock_position_model.dart';
import 'package:sofi_shoes/model/branch/branch_stock_position_model.dart';
import 'package:sofi_shoes/model/branch/stockposition/my_branch_stock_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class BBranchStockRepository {
  final _apiService = NetworkApiServices();

  Future<BBranchStockModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.allBranchStock);
    return BBranchStockModel.fromJson(response);
  }

  Future<SpecificBranchStockPositionModel> specificBranch(String id) async {
    dynamic response = await _apiService.specificGetData("${BranchApiUrl.specificBranchStock}/${id}");
    return SpecificBranchStockPositionModel.fromJson(response);
  }

  Future<MyBranchStockModel> myBranchStock(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.myBranchSock);
    return MyBranchStockModel.fromJson(response);
  }
}
