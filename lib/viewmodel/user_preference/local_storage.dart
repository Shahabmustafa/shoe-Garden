import 'package:shared_preferences/shared_preferences.dart';

import '../../model/auth/login_model.dart';

class UserPreference {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.token.toString());
    sp.setString('id', responseModel.id.toString());
     sp.setString('name', responseModel.name.toString());
    sp.setString('phone_number', responseModel.phoneNumber.toString());
    sp.setString('address', responseModel.address.toString());
    sp.setBool('isLogin', responseModel.isLogin!);

    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');

    String? phoneNumberr = sp.getString('phone_number');
    String? address = sp.getString('address');
    bool? isLogin = sp.getBool('isLogin');
    String? id = sp.getString('id');
    String? name = sp.getString('name');

    return UserModel(
      token: token,
      isLogin: isLogin,
      phoneNumber: phoneNumberr,
      address: address,
      id: id,
      name: name
    );
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}

// import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importing FlutterSecureStorage for secure local storage

// /// A class for managing local storage using FlutterSecureStorage.
// class LocalStorage {
//   /// Instance of FlutterSecureStorage for secure local storage.
//   final storage = const FlutterSecureStorage();

//   /// Sets a key-value pair in the local storage.
//   ///
//   /// Returns a Future<bool> indicating the success of the operation.
//   Future<bool> setValue(String key, String value) async {
//     await storage.write(key: key, value: value);
//     return true;
//   }

//   /// Reads the value associated with the given key from the local storage.
//   ///
//   /// Returns a Future<dynamic> representing the value stored for the key.
//   Future<dynamic> readValue(String key) async {
//     return await storage.read(key: key);
//   }

//   /// Clears the value associated with the given key from the local storage.
//   ///
//   /// Returns a Future<bool> indicating the success of the operation.
//   Future<bool> clearValue(String key) async {
//     await storage.delete(key: key);
//     return true;
//   }
// }
