import 'dart:convert';

import 'package:attnkare_manager_app/models/session_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_info_model.dart';

class ApiService {
  static const String baseUrl = "http://jdi.bitzflex.com:4007/api/v2";
  static const String loginUrl = "/session";
  static const String userUrl = "/users";

  static Future<SessionModel?> login(String id, String pwd) async {
    SessionModel? sessionInstance;
    final url = Uri.parse("$baseUrl$loginUrl");
    var body = json.encode({
      'user': {
        'uid': id,
        'password': pwd,
      },
    });

    var response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final dynamic session = jsonDecode(response.body);
      sessionInstance = SessionModel.fromJson(session);
    }

    return sessionInstance;
  }

  static Future<UserInfoModel?> getManagerInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!,
    };

    UserInfoModel? userInfoInstance;
    final url = Uri.parse("$baseUrl/manager/info");
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final dynamic userDetail = jsonDecode(response.body);
      userInfoInstance = UserInfoModel.fromJson(userDetail['data']['user']);
    }
    return userInfoInstance;
  }

  static Future<UserInfoModel?> getUserDetail(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!,
    };

    UserInfoModel? userInfoInstance;
    final url = Uri.parse("$baseUrl/manager/users/$id");
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final dynamic userDetail = jsonDecode(response.body);
      userInfoInstance = UserInfoModel.fromJson(userDetail['data']['user']);
    }
    return userInfoInstance;
  }

  static Future<List<UserInfoModel?>> getPatientList() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': accessToken!,
    };

    List<UserInfoModel> patientInfoInstances = [];
    final url = Uri.parse("$baseUrl/manager/chosen");
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final dynamic userDetails = jsonDecode(response.body);
      for (var user in userDetails['data']['patients']) {
        final instance = UserInfoModel.fromJson(user);
        patientInfoInstances.add(instance);
      }
    }
    return patientInfoInstances;
  }
}
