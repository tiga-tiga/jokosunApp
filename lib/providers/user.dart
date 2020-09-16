import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/models/auth_model.dart';
import 'package:jokosun/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier{
  User _user;
  AuthModel _auth;
  Future<AuthModel> signIn(String email, String password) async {
    final  String apiUrl = '$baseUrl/btp/authenticate';

    final  response = await http.post(apiUrl, headers: {
      "Accept": "application/json",
    },
        body: {
          'username': email,
          'password': password
        });

    _auth = authModelFromJson(response.body);
    if(response.statusCode == 200 && _auth.status == 0){
      _user  =  _auth.data.user;
      print(user.firstname);
      notifyListeners();
      await _setUserTokenToSharedPreferences(_auth.data.token);

    } else{
      print(response.body);
      notifyListeners();

    }
    return _auth;
  }

  User get user {
    return _user;
  }

  Future<User> _getUser(String token) async {
    final response =
    await http.get("$baseUrl/api/auth/user", headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(User.fromJson(json.decode(response.body)));
      return User.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.body);
      throw Exception('Failed to load album');
    }
  }

  Future<Void> _setUserTokenToSharedPreferences(String token) async {
    final prefs =  await SharedPreferences.getInstance();
    print('init shared');
    await prefs.setString('userToken', token);
  }
}