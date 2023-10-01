import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:structure/model/user_model.dart';

class UserDetailViewModel with ChangeNotifier {
  String userId = '';
  UserDetailViewModel(UserModel userModel)
      : userId = userModel.userId ?? 'None';

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

  Future<void> clickedSaveButton() async {}

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.user.homeAdress != null && widget.user.homeAdress!.isNotEmpty) {
  //     int index = widget.user.homeAdress!.indexOf('/');
  //     if (index != -1 &&
  //         widget.user.homeAdress!.substring(0, index).isNotEmpty) {
  //       _mainAddressController.text =
  //           widget.user.homeAdress!.substring(0, index);
  //     }
  //     if (index != -1 &&
  //         widget.user.homeAdress!.substring(index + 1).isNotEmpty) {
  //       _subAddressController.text =
  //           widget.user.homeAdress!.substring(index + 1);
  //     }
  //   }
  //   if (widget.user.company != null && widget.user.company!.isNotEmpty) {
  //     _companyController.text = widget.user.company!;
  //   }
  //   if (widget.user.jobTitle != null && widget.user.jobTitle!.isNotEmpty) {
  //     int index = widget.user.jobTitle!.indexOf('/');
  //     if (index != -1 && widget.user.jobTitle!.substring(0, index).isNotEmpty) {
  //       _departmentController.text = widget.user.jobTitle!.substring(0, index);
  //     }
  //     if (index != -1 &&
  //         widget.user.jobTitle!.substring(index + 1).isNotEmpty) {
  //       _jobTitleController.text = widget.user.jobTitle!.substring(index + 1);
  //     }
  //   }
  // }

  // Future<void> saveUserData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   if (_mainAddressController.text.isNotEmpty) {
  //     widget.user.homeAdress =
  //         '${_mainAddressController.text}/${_subAddressController.text}';
  //   }

  //   widget.user.company = _companyController.text;
  //   if (_departmentController.text.isNotEmpty ||
  //       _jobTitleController.text.isNotEmpty) {
  //     widget.user.jobTitle =
  //         '${_departmentController.text}/${_jobTitleController.text}';
  //   }

  //   try {
  //     // 데이터 전송
  //     final response = await ApiServices.updateUser(widget.user);
  //     if (response == null) throw Error();
  //   } catch (e) {
  //     print('$e');
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
}
