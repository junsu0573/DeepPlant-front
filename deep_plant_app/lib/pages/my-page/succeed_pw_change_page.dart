import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SucceedPwChange extends StatefulWidget {
  final UserData userData;
  const SucceedPwChange({
    super.key,
    required this.userData,
  });

  @override
  State<SucceedPwChange> createState() => _SucceedPwChangeState();
}

class _SucceedPwChangeState extends State<SucceedPwChange> {
  bool isLoading = true;

  @override
  void initState() async {
    super.initState();

    // 유저의 정보를 서버에 전송
    await sendUserInfo(widget.userData);
  }

  // 유저의 정보를 서버에 전송
  Future<void> sendUserInfo(UserData userData) async {
    // 로딩 상태 활성화
    setState(() {
      isLoading = true;
    });

    // 서버에 전송
    await ApiServices.updateUser(userData);

    // 로딩 상태 비활성화
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Center(
                  child: Text(
                    '비밀번호 변경이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SaveButton(
                  onPressed: () => context.pop(),
                  text: '이전화면',
                  width: 658.w,
                  heigh: 104.h,
                  isWhite: false,
                ),
              ],
            ),
    );
  }
}
