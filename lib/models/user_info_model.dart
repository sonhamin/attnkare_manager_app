enum UserType {
  admin,
  develooper,
  manager,
  patient,
  nothing;

  factory UserType.userType(int? type) {
    return UserType.values.firstWhere(
      (element) => element.index == type,
      orElse: () => UserType.nothing,
    );
  }
}

enum Gender {
  female,
  male,
  none;

  factory Gender.userGender(int? gender) {
    return Gender.values.firstWhere(
      (element) => element.index == gender,
      orElse: () => Gender.none,
    );
  }
}

class UserInfoModel {
  final int id;
  final int? grade, hospitalCode;
  final String uid, name;
  final String? nameAsterisk, email, phoneNumber;
  final UserType type;
  final Gender? gender;

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        uid = json['uid'],
        name = json['name'],
        nameAsterisk = json['name_asterisk'],
        email = json['email'],
        type = UserType.userType(json['type']),
        gender = Gender.userGender(json['gender']),
        grade = json['grade'],
        phoneNumber = json['phonenum'],
        hospitalCode = json['hospital_code'];
}
// bluekare_doctor