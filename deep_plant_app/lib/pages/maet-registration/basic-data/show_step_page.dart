import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_model.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:deep_plant_app/widgets/show_custom_dialog.dart';
import 'package:deep_plant_app/widgets/step_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ShowStep extends StatefulWidget {
  final UserModel user;
  final MeatData meat;
  ShowStep({
    super.key,
    required this.user,
    required this.meat,
  });

  @override
  State<ShowStep> createState() => _ShowStepState();
}

class _ShowStepState extends State<ShowStep> {
  final _firestore = FirebaseFirestore.instance;

  bool _isAllCompleted() {
    if (widget.meat.species != null &&
        widget.meat.imageFile != null &&
        widget.meat.freshData != null) {
      return true;
    }
    return false;
  }

  // 임시저장 데이터로 fetch
  Future<void> getData() async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection('user_emails').doc(widget.user.email).get();
    Map<String, dynamic> data = docSnapshot.get('temp_basic_data');
    initMeatdata(data);
  }

  // 임시 저장 데이터로 초기화
  void initMeatdata(Map<String, dynamic> data) {
    widget.meat.historyNumber = data['historyNumber'];
    widget.meat.species = data['species'];
    widget.meat.lDivision = data['lDivision'];
    widget.meat.sDivision = data['sDivision'];
    if (data['freshData'] != null) {
      widget.meat.freshData = data['freshData']?.cast<String, double>();
    } else {
      widget.meat.freshData = null;
    }
    widget.meat.gradeNm = data['gradeNm'];
    widget.meat.farmAddr = data['farmAddr'];
    widget.meat.butcheryPlaceNm = data['butcheryPlaceNm'];
    widget.meat.butcheryYmd = data['butcheryYmd'];
    widget.meat.imageFile = data['imageFile'];
  }

  // 임시저장 데이터 저장
  Future<void> saveTempData() async {
    DateTime now = DateTime.now();

    String saveDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'historyNumber': widget.meat.historyNumber,
      'species': widget.meat.species,
      'lDivision': widget.meat.lDivision,
      'sDivision': widget.meat.sDivision,
      'saveTime': saveDate,
      'gradeNm': widget.meat.gradeNm,
      'farmAddr': widget.meat.farmAddr,
      'butcheryPlaceNm': widget.meat.butcheryPlaceNm,
      'butcheryYmd': widget.meat.butcheryYmd,
      'freshData': widget.meat.freshData,
      'imageFile': widget.meat.imageFile,
    };

    DocumentReference refData =
        _firestore.collection('user_emails').doc(widget.user.email);

    await refData.update({
      'temp_basic_data': tempBasicData,
    });
  }

  // 임시저장 데이터 초기화
  Future<void> initTempData() async {
    // 데이터 생성
    Map<String, dynamic> tempBasicData = {
      'historyNumber': null,
      'species': null,
      'lDivision': null,
      'sDivision': null,
      'gradeNm': null,
      'farmAddr': null,
      'butcheryPlaceNm': null,
      'butcheryYmd': null,
      'freshData': null,
      'imageFile': null,
    };

    DocumentReference refData =
        _firestore.collection('user_emails').doc(widget.user.email);

    await refData.update({
      'temp_basic_data': tempBasicData,
    });
  }

  void initialize() async {
    // 임시저장 데이터를 가져와 객체에 저장
    await getData().then((_) {
      setState(() {});
    });

    if (widget.meat.historyNumber != null) {
      if (!mounted) return;
      // 임시저장 데이터가 null값이 아닐 때 다이얼로그 호출
      showDataRegisterDialog(context, () async {
        // 처음부터
        initTempData();
        await getData().then((_) {
          setState(() {});
        });
        if (!mounted) return;
        context.pop();
      }, () {
        // 이어서
        context.pop();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
        closeButtonOnPressed: () {
          showExitDialog(
            context,
            () => getData(),
          );
        },
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              '육류 등록',
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 105.h,
            ),
            GestureDetector(
              onTap: () async {
                context.go('/option/show-step/insert-his-num');
              },
              child: StepCard(
                mainText: '육류 기본정보 입력',
                subText: '데이터를 입력해 주세요.',
                step: '1',
                isCompleted: widget.meat.species != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () => context.go('/option/show-step/insert-meat-image'),
              child: StepCard(
                mainText: '육류 단면 촬영',
                subText: '데이터를 입력해 주세요.',
                step: '2',
                isCompleted: widget.meat.imageFile != null ? true : false,
              ),
            ),
            GestureDetector(
              onTap: () =>
                  context.go('/option/show-step/insert-fresh-evaluation'),
              child: StepCard(
                mainText: '신선육 관능평가',
                subText: '데이터를 입력해 주세요.',
                step: '3',
                isCompleted: widget.meat.freshData != null ? true : false,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SaveButton(
                    onPressed: () {
                      showTemporarySaveDialog(
                        context,
                        () {
                          saveTempData();
                          context.pop();
                        },
                      );
                    },
                    text: '임시저장',
                    width: 310.w,
                    heigh: 104.h,
                    isWhite: true,
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  SaveButton(
                    onPressed: _isAllCompleted()
                        ? () {
                            widget.user.level == 'users_2'
                                ? () {
                                    context.go('/option/complete-register-2');
                                  }
                                : context.go('/option/complete-register');
                          }
                        : null,
                    text: '저장',
                    width: 310.w,
                    heigh: 104.h,
                    isWhite: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
