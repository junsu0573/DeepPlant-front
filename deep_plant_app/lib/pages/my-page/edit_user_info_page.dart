import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';

class EditUserInfo extends StatefulWidget {
  final UserData user;
  const EditUserInfo({
    super.key,
    required this.user,
  });

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  bool _isEditting = false;
  bool _isLoading = false;

  final TextEditingController _mainAddressController = TextEditingController();
  final TextEditingController _subAddressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user.homeAdress != null && widget.user.homeAdress!.isNotEmpty) {
      int index = widget.user.homeAdress!.indexOf('/');
      if (index != -1 &&
          widget.user.homeAdress!.substring(0, index).isNotEmpty) {
        _mainAddressController.text =
            widget.user.homeAdress!.substring(0, index);
      }
      if (index != -1 &&
          widget.user.homeAdress!.substring(index + 1).isNotEmpty) {
        _subAddressController.text =
            widget.user.homeAdress!.substring(index + 1);
      }
    }
    if (widget.user.company != null && widget.user.company!.isNotEmpty) {
      _companyController.text = widget.user.company!;
    }
    if (widget.user.jobTitle != null && widget.user.jobTitle!.isNotEmpty) {
      int index = widget.user.jobTitle!.indexOf('/');
      if (index != -1 && widget.user.jobTitle!.substring(0, index).isNotEmpty) {
        _departmentController.text = widget.user.jobTitle!.substring(0, index);
      }
      if (index != -1 &&
          widget.user.jobTitle!.substring(index + 1).isNotEmpty) {
        _jobTitleController.text = widget.user.jobTitle!.substring(index + 1);
      }
    }
  }

  Future<void> saveUserData() async {
    setState(() {
      _isLoading = true;
    });

    if (_mainAddressController.text.isNotEmpty) {
      widget.user.homeAdress =
          '${_mainAddressController.text}/${_subAddressController.text}';
    }

    widget.user.company = _companyController.text;
    if (_departmentController.text.isNotEmpty ||
        _jobTitleController.text.isNotEmpty) {
      widget.user.jobTitle =
          '${_departmentController.text}/${_jobTitleController.text}';
    }

    try {
      // 데이터 전송
      final response = await ApiServices.updateUser(widget.user);
      if (response == null) throw Error();
    } catch (e) {
      print('$e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          CustomAppBar(title: '아이디/비밀번호', backButton: true, closeButton: false),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 62.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '아이디',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          height: 85.h,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(232, 232, 232, 1),
                            borderRadius: BorderRadius.circular(42.sp),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 32.w,
                              ),
                              Text(
                                widget.user.userId!,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(153, 153, 153, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        Text(
                          '비밀번호',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // 비밀번호 변경 버튼
                        CommonButton(
                          text: Text('비밀번호 변경하기'),
                          onPress: () {
                            context.go('/option/my-page/edit-info/reset-pw');
                          },
                          width: 500,
                          height: 85.h,
                        ),
                        SizedBox(
                          height: 36.h,
                        ),
                        Row(
                          children: [
                            Text(
                              '주소',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (_isEditting) {
                                    _isEditting = false;
                                  } else {
                                    _isEditting = true;
                                  }
                                });
                              },
                              child: Text(
                                _isEditting ? '완료' : '수정',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 412.w,
                              child: TextField(
                                onChanged: (value) {
                                  if (_mainAddressController.text.isEmpty) {
                                    setState(() {
                                      _subAddressController.text = '';
                                    });
                                  }
                                },
                                controller: _mainAddressController,
                                enabled: _isEditting,
                                decoration: InputDecoration(
                                  hintText: '주소',
                                ),
                              ),
                            ),
                            Spacer(),
                            CommonButton(
                              text: Text(
                                '검색',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPress: _isEditting
                                  ? () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => KpostalView(
                                            useLocalServer: false,
                                            callback: (Kpostal result) {
                                              setState(() {
                                                _mainAddressController.text =
                                                    result.jibunAddress;
                                                _subAddressController.text = '';
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              width: 125.w,
                              height: 75.h,
                              bgColor: Color.fromRGBO(46, 48, 62, 1),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        SizedBox(
                          child: TextField(
                            enabled: _isEditting,
                            controller: _subAddressController,
                            decoration: InputDecoration(
                              hintText: '상세주소 (동/호수)',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 68.h,
                        ),
                        Text(
                          '회사정보',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 27.h,
                        ),

                        TextField(
                          controller: _companyController,
                          enabled: _isEditting,
                          decoration: InputDecoration(
                            hintText: '회사명',
                          ),
                        ),
                        SizedBox(
                          height: 34.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 235.w,
                              child: TextField(
                                enabled: _isEditting,
                                controller: _departmentController,
                                decoration: InputDecoration(
                                  hintText: '부서명',
                                ),
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 235.w,
                              child: TextField(
                                enabled: _isEditting,
                                controller: _jobTitleController,
                                decoration: InputDecoration(
                                  hintText: '직위',
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 81.h,
                        ),
                      ],
                    ),
                  ),
                  SaveButton(
                    onPressed: !_isEditting
                        ? () async {
                            await saveUserData();
                          }
                        : null,
                    text: '저장',
                    width: 658.w,
                    heigh: 106.h,
                    isWhite: false,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                ],
              ),
            ),
          ),
          _isLoading ? CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
