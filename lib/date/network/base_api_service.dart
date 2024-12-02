abstract class BaseApiService {
  Future<dynamic> getApi(String url);
  Future<dynamic> postApi(dynamic data, String url);

  Future<dynamic> postApiJson(dynamic data, String url);
  Future<dynamic> deleteApi(String url);
  Future<dynamic> updateApi(dynamic data, String url);
}
