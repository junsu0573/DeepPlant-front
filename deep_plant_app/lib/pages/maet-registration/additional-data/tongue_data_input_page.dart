import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/tongue_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:go_router/go_router.dart';

class TongueDataInputPage extends StatefulWidget {
  final MeatData meatData;
  const TongueDataInputPage({
    super.key,
    required this.meatData,
  });

  @override
  State<TongueDataInputPage> createState() => _TongueDataInputPageState();
}

class _TongueDataInputPageState extends State<TongueDataInputPage> {
  TextEditingController sourness = TextEditingController();
  TextEditingController bitterness = TextEditingController();
  TextEditingController umami = TextEditingController();
  TextEditingController richness = TextEditingController();

  void saveMeatData() {
    final sournessData = double.parse(sourness.text);
    final bitternessData = double.parse(bitterness.text);
    final umamiData = double.parse(umami.text);
    final richnessData = double.parse(richness.text);

    // 데이터 생성
    Map<String, dynamic> tongueData = {
      'sourness': sournessData,
      'bitterness': bitternessData,
      'umami': umamiData,
      'richness': richnessData,
    };

    // 데이터를 객체에 저장
    widget.meatData.tongueData = tongueData;
  }

  bool _isAllInserted() {
    if (sourness.text.isNotEmpty &&
        bitterness.text.isNotEmpty &&
        umami.text.isNotEmpty &&
        richness.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 unfocus
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: '추가정보 입력',
          backButton: true,
          closeButton: false,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 900.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 38.h,
                    ),
                    Text(
                      '전자혀 데이터',
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    TongueFiled(
                      mainText: 'Sourness',
                      subText: '신맛',
                      controller: sourness,
                    ),
                    SizedBox(
                      height: 112.h,
                    ),
                    TongueFiled(
                      mainText: 'Bitterness',
                      subText: '진한맛',
                      controller: bitterness,
                    ),
                    SizedBox(
                      height: 112.h,
                    ),
                    TongueFiled(
                      mainText: 'Umami',
                      subText: '감칠맛',
                      controller: umami,
                    ),
                    SizedBox(
                      height: 112.h,
                    ),
                    TongueFiled(
                      mainText: 'Richness',
                      subText: '후미',
                      controller: richness,
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(bottom: 28.h),
                      child: SaveButton(
                        onPressed: _isAllInserted()
                            ? () async {
                                // 데이터 저장
                                saveMeatData();

                                // 데이터 서버로 전송
                                await ApiServices.sendMeatData('probexp_data',
                                    widget.meatData.convertPorbexptToJson());

                                if (!mounted) return;
                                context.pop();
                              }
                            : null,
                        text: '저장',
                        width: 658.w,
                        heigh: 104.h,
                        isWhite: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
