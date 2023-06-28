import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/text_insertion_field.dart';
import 'package:flutter/material.dart';

class ResetPW extends StatelessWidget {
  const ResetPW({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '비밀번호 변경',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
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
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text('기존 비밀번호'),
              ),
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '',
                hintText: '',
                width: 40,
                isObscure: true,
                isCenter: true,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text('변경할 비밀번호'),
              ),
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '영문+숫자',
                hintText: '',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),
              TextInsertionField(
                validateFunc: null,
                onSaveFunc: null,
                onChangeFunc: null,
                mainText: '비밀번호 확인',
                hintText: '',
                width: 40,
                isObscure: false,
                isCenter: false,
              ),
              SizedBox(
                height: 350,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonButton(
                      text: '저장', onPress: () {}, width: 350, height: 45),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
