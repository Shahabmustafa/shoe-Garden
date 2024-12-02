import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sofi_shoes/date/request_header.dart';

import '../app_exception.dart';
import 'base_api_service.dart';

class NetworkApiServices extends BaseApiService {
  // Get Api Function
  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: RequestHeader.getHeader(),).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
      print(response.statusCode);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on ServerException {
      throw ServerException('');
    }
    return responseJson;
  }

  // Post Api Function
  @override
  Future<dynamic> postApi(var data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: RequestHeader.getHeader(),
          )
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
      // print(response.body);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on ServerException {
      throw ServerException('');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiJson(var data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: RequestHeader.postHeader(),
          )
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
      // print(response.body);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on ServerException {
      throw ServerException('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
          response.statusCode == 401
              ? "Unauthorized"
              : response.statusCode == 404
                  ? "Not Found"
                  : response.statusCode == 500
                      ? "Internal Server Error"
                      : response.statusCode == 521
                          ? "Web Server Is Down"
                          : response.statusCode == 522
                              ? "Connection Timed Out"
                              : 'Error Exception while communicating with server ${response.reasonPhrase}',
        );
    }
  }

  @override
  Future deleteApi(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .delete(
            Uri.parse(url),
            headers: RequestHeader.getHeader(),
          )
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
      print(response.body);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on ServerException {
      throw ServerException('');
    }
    return responseJson;
  }

  @override
  Future updateApi(data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .put(
            Uri.parse(url),
            body: data,
            headers: RequestHeader.getHeader(),
          )
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
      print(response.body);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on ServerException {
      throw ServerException('');
    }
    return responseJson;
  }

  @override
  Future specificGetApi(data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: data,
            headers: RequestHeader.postHeader(),
          )
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on ServerException {
      throw ServerException('');
    }
    return responseJson;
  }

  Future specificGetData(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: RequestHeader
                .getHeader(), // Assuming you have a RequestHeader class
          )
          .timeout(const Duration(seconds: 30));
      responseJson =
          returnResponse(response); // Assuming returnResponse is defined
    } on SocketException {
      throw InternetExceptions('No Internet connection');
    } on RequestTimeOut {
      throw RequestTimeOut('Request timed out');
    } on ServerException {
      throw ServerException('Server error');
    }
    return responseJson;
  }
}
