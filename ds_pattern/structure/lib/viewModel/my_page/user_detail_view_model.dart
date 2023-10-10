import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/user_model.dart';

class UserDetailViewModel with ChangeNotifier {
  UserModel userModel;
  UserDetailViewModel(this.userModel) {
    _initialize();
  }
  String userId = '';
  bool isEditting = false;
  bool isLoading = false;

  final TextEditingController mainAddress = TextEditingController();
  final TextEditingController subAddress = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController department = TextEditingController();
  final TextEditingController jobTitle = TextEditingController();

  void clickedEditButton() {
    isEditting = !isEditting;
    notifyListeners();
  }

  void onChangedMainAdress(String value) {
    if (mainAddress.text.isEmpty) {
      subAddress.text = '';
      notifyListeners();
    }
  }

  // 주소 검색 버튼 클릭시
  Future<void> clickedSearchButton(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          useLocalServer: false,
          callback: (Kpostal result) {
            mainAddress.text = result.jibunAddress;
            subAddress.text = '';
            notifyListeners();
          },
        ),
      ),
    );
  }

  void clickedChangePW(BuildContext context) {
    context.go('/home/my-page/user-detail/change-pw');
  }

  Future<void> clickedSaveButton() async {
    isLoading = true;
    notifyListeners();

    if (mainAddress.text.isNotEmpty) {
      userModel.homeAdress = '${mainAddress.text}/${subAddress.text}';
    }

    userModel.company = company.text;
    if (department.text.isNotEmpty || jobTitle.text.isNotEmpty) {
      userModel.jobTitle = '${department.text}/${jobTitle.text}';
    }

    try {
      // 데이터 전송
      final response =
          await RemoteDataSource.updateUser(_convertUserUpdateToJson());
      if (response == null) throw Error();
    } catch (e) {
      print('$e');
      // 에러 페이지
    }

    isLoading = false;
    notifyListeners();
  }

  void _initialize() {
    userId = userModel.userId ?? 'None';
    if (userModel.homeAdress != null && userModel.homeAdress!.isNotEmpty) {
      int index = userModel.homeAdress!.indexOf('/');
      if (index != -1 && userModel.homeAdress!.substring(0, index).isNotEmpty) {
        mainAddress.text = userModel.homeAdress!.substring(0, index);
      }
      if (index != -1 &&
          userModel.homeAdress!.substring(index + 1).isNotEmpty) {
        subAddress.text = userModel.homeAdress!.substring(index + 1);
      }
    }
    if (userModel.company != null && userModel.company!.isNotEmpty) {
      company.text = userModel.company!;
    }
    if (userModel.jobTitle != null && userModel.jobTitle!.isNotEmpty) {
      int index = userModel.jobTitle!.indexOf('/');
      if (index != -1 && userModel.jobTitle!.substring(0, index).isNotEmpty) {
        department.text = userModel.jobTitle!.substring(0, index);
      }
      if (index != -1 && userModel.jobTitle!.substring(index + 1).isNotEmpty) {
        jobTitle.text = userModel.jobTitle!.substring(index + 1);
      }
    }
  }

  Future<void> saveUserData() async {}

  // 유저 정보 업데이트 시 json 변환
  String _convertUserUpdateToJson() {
    Map<String, dynamic> jsonData = {
      "userId": userModel.userId,
      "name": userModel.name,
      "company": userModel.company,
      "jobTitle": userModel.jobTitle,
      "homeAddr": userModel.homeAdress,
      "alarm": userModel.alarm,
      "type": userModel.type,
    };

    return jsonEncode(jsonData);
  }
}
