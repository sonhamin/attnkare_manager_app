import 'dart:convert';
import 'dart:developer' as devtools show log;

import 'package:attnkare_manager_app/models/register_patient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/job_model.dart';
import '../models/session_model.dart';
import '../models/subscribe_model.dart';
import '../models/user_info_model.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class ApiService {
  static const String baseUrl = "http://jdi.bitzflex.com:4007/api/v2";
  static const String loginUrl = "/session";
  static const String userUrl = "/users";

  static Future<Map<String, String>> _generateHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');

    return {
      'Content-Type': 'application/json',
      'Authorization': accessToken!,
    };
  }

  static Future<SessionModel?> login(String id, String pwd) async {
    SessionModel? sessionInstance;
    final url = Uri.parse("$baseUrl$loginUrl");
    var body = json.encode({
      'user': {
        'uid': id,
        'password': pwd,
      },
    });

    try {
      var response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final dynamic session = jsonDecode(response.body);
        sessionInstance = SessionModel.fromJson(session);
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return sessionInstance;
  }

  static Future<UserInfoModel?> getManagerInfo() async {
    Map<String, String> headers = await _generateHeaders();

    UserInfoModel? userInfoInstance;
    final url = Uri.parse("$baseUrl/manager/info");

    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic userDetail = jsonDecode(response.body);
        userInfoInstance = UserInfoModel.fromJson(userDetail['data']['user']);
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return userInfoInstance;
  }

  static Future<UserInfoModel?> getUserDetail(String id) async {
    Map<String, String> headers = await _generateHeaders();
    UserInfoModel? userInfoInstance;
    final url = Uri.parse("$baseUrl/manager/users/$id");

    try {
      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic userDetail = jsonDecode(response.body);
        userInfoInstance = UserInfoModel.fromJson(userDetail['data']['user']);
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return userInfoInstance;
  }

  static Future<List<UserInfoModel?>> getPatientList() async {
    Map<String, String> headers = await _generateHeaders();
    List<UserInfoModel> patientInfoInstances = [];
    final url = Uri.parse("$baseUrl/manager/chosen");

    try {
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
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return patientInfoInstances;
  }

  static Future<List<UserInfoModel?>> searchPatient(
      String term, int servieType) async {
    Map<String, String> headers = await _generateHeaders();
    List<UserInfoModel> patientInfoInstances = [];

    try {
      final url =
          Uri.parse("$baseUrl/manager/search?query=$term&service=$servieType");
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
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return patientInfoInstances;
  }

  static Future<List<JobModel?>> getJobList(
      [int userId = 10, int subscriptionId = 10]) async {
    Map<String, String> headers = await _generateHeaders();
    List<JobModel> jobInfoInstances = [];

    try {
      final url = Uri.parse(
          "$baseUrl/manager/users/$userId/subscriptions/$subscriptionId/jobs");
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dynamic jobInfos = jsonDecode(response.body);
        for (var job in jobInfos['data']['jobs']) {
          final instance = JobModel.fromJson(job);
          jobInfoInstances.add(instance);
        }
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return jobInfoInstances;
  }

  static Future<RegisterPatientModel?> regisgerPatient(int id) async {
    Map<String, String> headers = await _generateHeaders();
    RegisterPatientModel? regisgterPatientInstance;
    final url = Uri.parse("$baseUrl/manager/choose/$id");

    try {
      var response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic registeredPatient = jsonDecode(response.body);
        regisgterPatientInstance =
            RegisterPatientModel.fromJson(registeredPatient['data']['patient']);
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      e.log();
    }

    return regisgterPatientInstance;
  }

  static Future<SubscribeModel?> getSubscribeInfo(int id) async {
    Map<String, String> headers = await _generateHeaders();
    SubscribeModel? subscribeInstance;
    final url = Uri.parse("$baseUrl/manager/users/$id/subscriptions");

    try {
      var response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final dynamic subscribe = jsonDecode(response.body);
        subscribeInstance =
            SubscribeModel.fromJson(subscribe['data']['subscriptions']);
      } else {
        url.log();
        response.statusCode.log();
      }
    } catch (e) {
      url.log();
      e.log();
    }

    return subscribeInstance;
  }
}
