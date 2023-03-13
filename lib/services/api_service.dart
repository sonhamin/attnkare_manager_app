import 'dart:convert';

import 'package:attnkare_manager_app/models/session_model.dart';
import 'package:attnkare_manager_app/models/user_detail_model.dart';
import 'package:http/http.dart' as http;

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

      print('session: $session');
    }

    return sessionInstance;
  }

  static Future<UserDetailModel?> getUserDetail(String id) async {
    UserDetailModel? userDetailInstance;
    final url = Uri.parse("$baseUrl/$id");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic userDetail = jsonDecode(response.body);
      userDetailInstance = UserDetailModel.fromJson(userDetail);
    }
    return userDetailInstance;
  }

  static Future<List<UserInfoModel?>> getUserInfoList(String id) async {
    List<UserInfoModel> userInfoInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        final instance = UserInfoModel.fromJson(user);
        userInfoInstances.add(instance);
      }
    }
    return userInfoInstances;
  }
}
