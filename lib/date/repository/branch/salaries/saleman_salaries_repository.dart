import 'package:sofi_shoes/date/network/network_api_service.dart';
import 'package:sofi_shoes/model/branch/saleman/branch_saleman_salaries_model.dart';
import 'package:sofi_shoes/res/apiurl/branch_api_url.dart';

class SalemanSalariesRepository {
  final _apiService = NetworkApiServices();

  Future<SalmanSalariesModel> getAll() async {
    dynamic response = await _apiService.getApi(BranchApiUrl.salemanSalaries);
    return SalmanSalariesModel.fromJson(response);
  }
}
