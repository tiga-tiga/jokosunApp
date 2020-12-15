import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:jokosun/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{
  UserModel _user;
  ResponseModel _responseModel;
  Future<ResponseModel> signIn(String email, String password) async {
    final  String apiUrl = '$baseUrl/auth/login';

    final  response = await http.post(apiUrl, headers: {
      "Accept": "application/json",
    },
        body: {
          'email': email,
          'password': password,
          'device_name': 'android'
        });
    if(response.statusCode == 200 ){
      print(response.body);
      _responseModel = responseModelFromJson(response.body);
      String token =  _responseModel.data["token"];
      print(token);
      notifyListeners();
      await _setUserTokenToSharedPreferences(token);
      if(_responseModel.success){

        await _getUser(token);
      } else {
        return _responseModel;
      }
    } else{
      print(response.body);
      notifyListeners();
   // && _responseModel.statusCode == 200
    }
    return _responseModel;
  }

  UserModel get user {
    return _user;
  }

  Future<UserModel> _getUser(String token) async {
    final response =
    await http.get("$baseUrl/auth/current", headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },);
    _responseModel = responseModelFromJson(response.body);

    _user = UserModel.fromJson(_responseModel.data["user"]);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load user');
    }
  }

  Future<Void> _setUserTokenToSharedPreferences(String token) async {
    final prefs =  await SharedPreferences.getInstance();
    print('init shared');
    await prefs.setString('userToken', token);
  }
}