import 'dart:convert';

class UserData {
  // 로그인 시 저장
  String? userId;
  String? password;
  String? name;
  String? homeAdress;
  String? company;
  String? jobTitle;
  String? type;
  String? createdAt;
  bool? alarm;

  UserData({
    this.userId,
    this.password,
    this.name,
    this.homeAdress,
    this.company,
    this.jobTitle,
    this.type,
    this.createdAt,
    this.alarm,
  });

  void resetData() {
    userId = null;
    password = null;
    name = null;
    homeAdress = null;
    company = null;
    jobTitle = null;
    type = null;
    createdAt = null;
    alarm = null;
  }

  // 로그인 시 json 변환
  String convertUserSignInToJson() {
    Map<String, dynamic> jsonData = {
      "userId": userId,
      "password": password,
      "type": type,
    };
    return jsonEncode(jsonData);
  }

  // 유저 정보 업데이트 시 json 변환
  String convertUserUpdateToJson() {
    Map<String, dynamic> jsonData = {
      "userId": userId,
      "createdAt": createdAt,
      "updatedAt": null,
      "loginAt": null,
      "password": password,
      "name": name,
      "company": company,
      "alarm": alarm,
      "type": type,
    };
    return jsonEncode(jsonData);
  }
}
