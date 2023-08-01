import 'dart:convert';

import 'package:intl/intl.dart';

class UserData {
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

  // 유저 데이터 초기화
  void resetData() {
    userId = null;
    password = null;
    name = null;
    homeAdress = null;
    company = null;
    jobTitle = null;
    type = 'Normal';
    createdAt = null;
    alarm = null;
  }

  // 유저 데이터 fetch
  void fetchData(dynamic jsonData) {
    userId = jsonData['userId'];
    createdAt = jsonData['createdAt'];
    password = jsonData['password'];
    name = jsonData['name'];
    company = jsonData['company'];
    jobTitle = jsonData['jobTitle'];
    homeAdress = jsonData['homeAddr'];
    alarm = jsonData['alarm'];
    type = jsonData['type'];
    print(jsonData);
  }

  // 유저 회원가입 시 json 변환
  String convertUserSignUpToJson() {
    DateTime now = DateTime.now();
    String createdAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

    Map<String, dynamic> jsonData = {
      "userId": userId,
      "createdAt": createdAt,
      "updatedAt": null,
      "loginAt": null,
      "password": password,
      "name": name,
      "company": company,
      "jobTitle": jobTitle,
      "homeAddr": homeAdress,
      "alarm": alarm,
      "type": type,
    };
    return jsonEncode(jsonData);
  }

  // 유저 정보 업데이트 시 json 변환
  String convertUserUpdateToJson() {
    Map<String, dynamic> jsonData = {
      "userId": userId,
      "name": name,
      "company": company,
      "jobTitle": jobTitle,
      "homeAddr": homeAdress,
      "alarm": alarm,
      "type": type,
    };

    return jsonEncode(jsonData);
  }

  // 유저 비밀번호 변경 시 반환
  String convertChangeUserPwToJson(String newPw) {
    Map<String, dynamic> jsonData = {
      "userId": userId,
      "password": newPw,
    };

    return jsonEncode(jsonData);
  }

  // 유저 비밀번호 확인
  String convertPwdCheckToJson(String pw) {
    Map<String, dynamic> jsonData = {
      "id": userId,
      "password": pw,
    };
    return jsonEncode(jsonData);
  }
}
