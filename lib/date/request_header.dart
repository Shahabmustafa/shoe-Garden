import '../viewmodel/user_preference/session_controller.dart';

class RequestHeader {
  static final SessionController _sessionController = SessionController();
  static getHeader() {
    return {
      'Authorization': "Bearer ${_sessionController.getAccessToken()}",
      'accept': 'application/json',
    };
  }

  static postHeader() {
    return {
      'Authorization': 'Bearer ${_sessionController.getAccessToken()}',
      'content-type': 'application/json',
      'accept': 'application/json',
    };
  }

  static postImageHeader() {
    return {
      'Authorization': 'Bearer ${_sessionController.getAccessToken()}',
      'content-type': 'image/jpg; image/png',
      'accept': 'application/json',
    };
  }

  static postWithoutTokenHeader() {
    return {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
  }

  static getAuthToken() {
    return 'Bearer ${_sessionController.getAccessToken()}';
  }
}
