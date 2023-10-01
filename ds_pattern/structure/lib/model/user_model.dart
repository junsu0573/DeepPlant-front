import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? userId;
  String? password;
  String? name;
  String? homeAdress;
  String? company;
  String? jobTitle;
  String? type;
  String? createdAt;
  bool? alarm;

  // Constructor
  UserModel({
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

  // Data fetch
  void fromJson(Map<String, dynamic> jsonData) {
    userId = jsonData['userId'];
    password = jsonData['password'];
    name = jsonData['name'];
    homeAdress = jsonData['homeAddr'];
    company = jsonData['company'];
    jobTitle = jsonData['jobTitle'];
    type = jsonData['type'];
    createdAt = jsonData['createdAt'];
    alarm = jsonData['alarm'];
  }

  // Data reset
  void reset() {
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
}
