

import 'dart:convert';

import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AdminApi {

  Future<ResponseModel> createEmploye(String email, String name, String phone) async {
    final String apiUrl = '$baseUrl/technicians';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.post(apiUrl, headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json"
    }, body: {
      "email": email,
      "phone": phone,
      "name": name,
    });

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

  Future<ResponseModel> createOffer(String fullName, String address, String city, int flatRate, int removalAndTransport, String dateWish, int  kitId, int technicians) async {
    final String apiUrl = '$baseUrl/offers';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(dateWish);
    final response = await http.post(apiUrl, headers: {
      "Authorization": "Bearer $token",
    "Accept": "application/json"
    }, body: {
      "customer_name": fullName,
      "flat_rate": flatRate.toString(),
      "removal_and_transport" : removalAndTransport.toString(),
      "address": address,
      "city": city,
      "commissioning_date": dateWish,
      "kit_id": kitId.toString(),
      "technicians": technicians.toString()
    });
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }
Future<ResponseModel> updateOffer(int id, String fullName, String address, String city, int flatRate, int removalAndTransport, String dateWish, int  kitId, int technicians) async {
    final String apiUrl = '$baseUrl/offers/$id';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(dateWish);
    final response = await http.put(apiUrl, headers: {
      "Authorization": "Bearer $token",
    "Accept": "application/json"
    }, body: {
      "customer_name": fullName,
      "flat_rate": flatRate.toString(),
      "removal_and_transport" : removalAndTransport.toString(),
      "address": address,
      "city": city,
      "commissioning_date": dateWish,
      "kit_id": kitId.toString(),
      "technicians": technicians.toString()
    });
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

Future<ResponseModel> deleteOffer(int id,) async {
    final String apiUrl = '$baseUrl/offers/$id';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    final response = await http.delete(apiUrl, headers: {
      "Authorization": "Bearer $token",
    "Accept": "application/json"
    });
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }
Future<ResponseModel> deleteInstallation(int id,) async {
    final String apiUrl = '$baseUrl/installations/$id';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    final response = await http.delete(apiUrl, headers: {
      "Authorization": "Bearer $token",
    "Accept": "application/json"
    });
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }


  Future<ResponseModel> applyOffer(List<int> technicians, int id) async {
    final String apiUrl = '$baseUrl/offers/$id/applications';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(id);




    Map<String, dynamic> args = {'technicians': technicians};
    Map<String, dynamic> toJson(List<int> technicians) => {
      "technicians": List<dynamic>.from(technicians.map((x) => x)),
    };

  print(json.encode(args));
  print(json.encode(toJson(technicians)));


    final response = await http.post(apiUrl, headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      'Content-Type': 'application/json'
    }, body: json.encode(toJson(technicians)));

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

  Future<ResponseModel> validSubmission(int offerId, int applicationId) async {
    final String apiUrl = '$baseUrl/offers/$offerId/applications/submission';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(token);
    final response = await http.post(apiUrl, headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json"
    }, body: {
      "application_id": applicationId.toString(),
    });

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

}

