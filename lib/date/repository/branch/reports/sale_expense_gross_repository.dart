import 'package:sofi_shoes/model/branch/report/sale_expense_gross_model.dart';
import 'package:sofi_shoes/res/apiurl/admin_api_url.dart';

import '../../../../model/branch/report/saleman_model.dart';
import '../../../../model/branch/report/salesman_salary_rreport_model.dart';
import '../../../../res/apiurl/branch_api_url.dart';
import '../../../network/network_api_service.dart';

class SaleExpenseGrossRepository{

  final _apiService = NetworkApiServices();

  Future<SaleExpenseGrossModel> getDat(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.saleExpenseGross);
    return SaleExpenseGrossModel.fromJson(response);
  }

  Future<SalesmanReportModel> salesmanReportGetData(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.salesmanReport);
    return SalesmanReportModel.fromJson(response);
  }
  Future<SalmanSalaryReportModel> salesmanSalaryReportGetData(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.salesmanSalaryReport);
    return SalmanSalaryReportModel.fromJson(response);
  }

  Future<dynamic> add(var data) async {
    dynamic response = await _apiService.postApi(data, BranchApiUrl.cashAssignToAdmin);
    return response;
  }

  Future<SaleExpenseGrossModel> getCashCounter(var data) async {
    dynamic response = await _apiService.postApi(data, AdminApiUrl.cashCounter);
    return SaleExpenseGrossModel.fromJson(response);
  }
}