//
//
// TextField 위젯 입니다.
// 파라미터로는
// 1. validate 를 위한 함수
// 2. onSaved 를 위한 함수
// 3. onChanged 를 위한 함수
// 4. 텍스트필드 바탕에 보이는 텍스트
// 5. 텍스트필드 클릭시에 보이는 힌트텍스트
// 6. 너비 조정
// 7. 문자 입력 방식 (패스워드에 경우 obscure: true)
// 8. 문자 정렬 (Center면 true)
//
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/pallete.dart';

class MainTextField extends StatelessWidget {
  final String? Function(String?)? validateFunc;
  final void Function(String?)? onSaveFunc;
  final void Function(String?)? onChangeFunc;
  final void Function(String?)? onFieldFunc;
  final String mainText;
  final String? hintText;
  final double width;
  final double height;
  final bool? isObscure;
  final bool? isCenter;
  final TextEditingController? controller;
  final int? maxLength;
  final List<FilteringTextInputFormatter>? formatter;
  final TextInputAction? action;

  const MainTextField({
    super.key,
    required this.validateFunc,
    required this.onSaveFunc,
    required this.onChangeFunc,
    this.onFieldFunc,
    required this.mainText,
    this.hintText,
    required this.width,
    required this.height,
    this.isObscure,
    this.isCenter,
    this.controller,
    this.maxLength,
    this.formatter,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 아이디 입력 필드
      width: width,
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        // 유효성 검사
        validator: validateFunc,
        onSaved: onSaveFunc,
        onChanged: onChangeFunc,
        onFieldSubmitted: onFieldFunc,
        inputFormatters: formatter,
        textInputAction: action,
        obscureText: isObscure ?? false,
        decoration: InputDecoration(
            label: isCenter != null && isCenter == true
                ? Center(
                    child: Text(mainText),
                  )
                : Text(mainText),
            filled: true,
            fillColor: Palette.mainTextFieldColor,
            hintText: hintText, // 입력 필드에 힌트로 표시될 텍스트

            suffixIcon: null, // 입력 필드 오른쪽에 표시될 아이콘
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(42.5.w),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
      ),
    );
  }
}
