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
    homeAdress = jsonData['homeAdress'];
    alarm = jsonData['alarm'];
    type = jsonData['type'];
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
    DateTime now = DateTime.now();
    String updatedAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);
    Map<String, dynamic> jsonData = {
      "userId": userId,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "loginAt": null,
      "password": password,
      "name": name,
      "company": company,
      "jobTitle": jobTitle,
      "homeAdress": homeAdress,
      "alarm": alarm,
      "type": type,
    };
    return jsonEncode(jsonData);
  }
}
