import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditUserInfo extends StatelessWidget {
  const EditUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '마이페이지',
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text('*아이디'),
              ),
              // 아이디 필드
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '이름',
                hintText: '이름을 입력하세요.',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text('*비밀번호'),
              ),
              // 비밀번호 변경 버튼
              Center(
                child: CommonButton(
                    text: '비밀번호 변경하기',
                    onPress: () {
                      context.go('/option/my-page/edit-info/reset-pw');
                    },
                    width: 330,
                    height: 40),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text('*권한'),
              ),
              // 소속
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '이름',
                hintText: '이름을 입력하세요.',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),

              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text('소속'),
              ),
              // 이름 입력 필드
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '이름',
                hintText: '이름을 입력하세요.',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),

              // 이름 입력 필드
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '이름',
                hintText: '이름을 입력하세요.',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),

              // 이름 입력 필드
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '이름',
                hintText: '이름을 입력하세요.',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
