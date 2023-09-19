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
  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      userId: jsonData['userId'],
      password: jsonData['password'],
      name: jsonData['name'],
      homeAdress: jsonData['homeAddr'],
      company: jsonData['company'],
      jobTitle: jsonData['jobTitle'],
      type: jsonData['type'],
      createdAt: jsonData['createdAt'],
      alarm: jsonData['alarm'],
    );
  }
}
