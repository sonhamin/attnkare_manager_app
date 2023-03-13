class SessionModel {
  final String accessToken, renewalToken;

  SessionModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['data']['access_token'],
        renewalToken = json['data']['renewal_token'];
}
