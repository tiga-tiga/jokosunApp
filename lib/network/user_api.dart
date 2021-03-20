import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jokosun/constants/app_api.dart';
import 'package:jokosun/models/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  Future<ResponseModel> createProposal(String fullName, String address,
      String phone, String dateWish, int kitId) async {
    final String apiUrl = '$baseUrl/proposals';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    print(dateWish);
    final response = await http.post(apiUrl, headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "fullName": fullName,
      "phone": phone,
      "address": address,
      "date_wish": dateWish,
      "kit_id": kitId.toString(),
    });
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

  Future<ResponseModel> startInstall(int installationId) async {
    final String apiUrl =
        '$baseUrl/installations/setups/${installationId}/begin';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');

    final response = await http.get(
      apiUrl,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

  Future<ResponseModel> prepareInstallationRequest(
      int installationId,
      String file1,
      String file2,
      String file3,
      double latitude,
      double longitude) async {
    final String apiUrl =
        '$baseUrl/installations/setups/${installationId}/prepare';
    print(installationId);
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
    var img = http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file1)).readAsBytes(),
        contentType: new MediaType('image', 'jpeg'));
    print(img.contentType);
    request.files.add(new http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file1)).readAsBytes(),
        filename: 'photo1', contentType: MediaType('image', 'jpeg')));
    request.files.add(new http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file2)).readAsBytes(),
        filename: 'photo2', contentType: new MediaType('image', 'jpeg')));
    request.files.add(new http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file3)).readAsBytes(),
        filename: 'photo3', contentType: new MediaType('image', 'jpeg')));
    request.fields['latitude'] = latitude.toString();
    request.fields['longitude'] = longitude.toString();
    request.headers.addAll(
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print(response.body);
    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

  Future<ResponseModel> finalizeInstallationRequest(
      int installationId,
      int  feeling,
      String comment,
      String file1,
      String file2,
      String file3,) async {
    final String apiUrl =
        '$baseUrl/installations/setups/${installationId}/finish';
    print(installationId);
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
    var img = http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file1)).readAsBytes(),
        contentType: new MediaType('image', 'jpeg'));
    print(img.contentType);
    request.files.add(new http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file1)).readAsBytes(),
        filename: 'photo1', contentType: MediaType('image', 'jpeg')));
    request.files.add(new http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file2)).readAsBytes(),
        filename: 'photo2', contentType: new MediaType('image', 'jpeg')));
    request.files.add(new http.MultipartFile.fromBytes(
        'photos[]', await File.fromUri(Uri.parse(file3)).readAsBytes(),
        filename: 'photo3', contentType: new MediaType('image', 'jpeg')));
    request.fields['feeling'] = feeling.toString();
    request.fields['comment'] = comment;
    request.headers.addAll(
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print(response.body);
    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }
Future<ResponseModel> sendInvoice(
      int installationId,
      String invoice,) async {
    final String apiUrl =
        '$baseUrl/installations/${installationId}/invoice';
    print(installationId);
    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    var request = new http.MultipartRequest("POST", Uri.parse(apiUrl));
   
    request.files.add(new http.MultipartFile.fromBytes(
        'invoice', await File.fromUri(Uri.parse(invoice)).readAsBytes(),
        filename: 'invoice'));

    request.headers.addAll(
        {"Authorization": "Bearer $token", "Accept": "application/json"});
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print(response.body);
    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

  Future<ResponseModel> markNotificationAsRead(String id) async {
    final String apiUrl = '$baseUrl/notifications/mark-as-read';

    final prefs = await SharedPreferences.getInstance();
    print('init shared');
    String token = await prefs.get('userToken');
    final response = await http.post(apiUrl, headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "notification_id": id,
    });
    print(response.body);

    return responseModelFromJson(utf8.decode(response.bodyBytes));
  }

}
