import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';

class AddUserInfo extends StatefulWidget {
  final UserData userData;
  const AddUserInfo({
    super.key,
    required this.userData,
  });

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {
  final TextEditingController _mainAddressController = TextEditingController();

  String subHomeAdress = '';

  String company = '';

  String department = '';

  String jobTitle = '';

  void saveUserData() {
    if (_mainAddressController.text.isNotEmpty) {
      widget.userData.homeAdress =
          '${_mainAddressController.text}/$subHomeAdress';
    }

    widget.userData.company = company;
    if (department.isNotEmpty || jobTitle.isNotEmpty) {
      widget.userData.jobTitle = '$department/$jobTitle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:
            CustomAppBar(title: '상세정보', backButton: true, closeButton: false),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 62.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      '주소',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 27.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 412.w,
                          height: 50.h,
                          child: TextField(
                            controller: _mainAddressController,
                            readOnly: true,
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
                          onPress: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KpostalView(
                                  useLocalServer: false,
                                  callback: (Kpostal result) {
                                    setState(() {
                                      _mainAddressController.text =
                                          result.jibunAddress;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
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
                      height: 50.h,
                      child: TextField(
                        onChanged: (value) {
                          subHomeAdress = value;
                        },
                        enabled:
                            _mainAddressController.text.isEmpty ? false : true,
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
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            company = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: '회사명',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 240.w,
                          height: 50.h,
                          child: TextField(
                            onChanged: (value) {
                              department = value;
                            },
                            decoration: InputDecoration(
                              hintText: '부서명',
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 240.w,
                          height: 50.h,
                          child: TextField(
                            onChanged: (value) {
                              jobTitle = value;
                            },
                            decoration: InputDecoration(
                              hintText: '직위',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 34.h,
                    ),
                  ],
                ),
              ),
              SaveButton(
                onPressed: () {
                  saveUserData();
                  context.go('/sign-in/succeed-sign-up');
                },
                text: '다음',
                width: 658.w,
                heigh: 106.h,
                isWhite: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
