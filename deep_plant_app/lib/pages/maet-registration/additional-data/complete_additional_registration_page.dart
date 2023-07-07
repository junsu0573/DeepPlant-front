import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CompleteAdditionalRegistration extends StatefulWidget {
  final UserModel user;
  final MeatData meatData;
  const CompleteAdditionalRegistration({
    super.key,
    required this.user,
    required this.meatData,
  });

  @override
  State<CompleteAdditionalRegistration> createState() =>
      _CompleteAdditionalRegistrationState();
}

class _CompleteAdditionalRegistrationState
    extends State<CompleteAdditionalRegistration> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> sendDataToFirebase() async {
    setState(() {
      isLoading = true;
    });
    try {
      // meat 컬렉션에 데이터 저장
      final refData = firestore.collection('meat').doc(widget.meatData.mNum);

      DateTime now = DateTime.now();

      String saveDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);

      await refData.update({
        'deepAging': widget.meatData.deepAging,
        'heated': widget.meatData.heatedMeat,
        'tongue': widget.meatData.tongueData,
        'labData': widget.meatData.labData,
        'saveTime': saveDate,
      });

      // 0-0-0-0-0 에 관리번호 저장
      DocumentReference documentRef =
          firestore.collection('meat').doc('0-0-0-0-0');
      await documentRef.update({
        'fix_data.meat': FieldValue.arrayUnion([widget.meatData.mNum]),
      });

      // 0-0-0-0-0 에 유저 이메일 추가
      await documentRef.update({
        'fix_data.${widget.user.level}':
            FieldValue.arrayUnion([widget.user.email]),
      });

      // user의 RevisionMeatList에 관리번호 추가
      DocumentReference refNum =
          firestore.collection(widget.user.level!).doc(widget.user.email);
      List<dynamic> newNum = [widget.meatData.mNum];
      await refNum.update({'revisionMeatList': FieldValue.arrayUnion(newNum)});
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    sendDataToFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading
            ? Text('데이터 등록중')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Icon(
                    Icons.check_circle_outline,
                    size: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '모든 등록이 완료되었습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '데이터를 서버로 전송했습니다.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 119.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('인쇄');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 494.w,
                          height: 259.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: Palette.lightOptionColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'QR코드 인쇄',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 34.h,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 30.h,
                          left: 178.w,
                          child: Image.asset(
                            'assets/images/qr.png',
                            width: 137.w,
                            height: 137.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 28.h),
                    child: SaveButton(
                      onPressed: () => context.go('/option'),
                      text: '홈으로 이동',
                      width: 658.w,
                      heigh: 104.h,
                      isWhite: false,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
