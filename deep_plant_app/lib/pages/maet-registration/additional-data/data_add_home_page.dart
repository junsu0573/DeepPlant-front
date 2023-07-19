import 'package:deep_plant_app/models/deep_aging_data_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/insert_deep_aging_data_page.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DataAddHome extends StatefulWidget {
  const DataAddHome({super.key, required this.meat});
  final MeatData meat;

  @override
  State<DataAddHome> createState() => _DataAddHomeState();
}

class _DataAddHomeState extends State<DataAddHome> {
  // 딥에이징 데이터 추가 시에 등록될 버튼이 추가될 위치.
  DeepAgingData data = DeepAgingData();

  // 이곳에 최종적인 deepagingdata 객체가 모인다.
  final List<DeepAgingData> objects = [];

  final List<String> deepAgingModel = [];

  // 아래는 페이지 진행 중 지정되는 임시 변수들이다.
  int totalMinute = 0;
  int totalHour = 0;
  int index = 0;
  List<Widget> widgets = [];
  List<int> hour = List<int>.filled(4, 0);
  List<int> minute = List<int>.filled(4, 0);

  void intoString() {
    for (int i = 0; i < objects.length; i++) {
      String timeTemp = ((int.parse(objects[i].insertedHour!) * 60) + (int.parse(objects[i].insertedMinute!))).toString();
      String temp = '${objects[i].selectedYear}${objects[i].selectedMonth}${objects[i].selectedDay}/$timeTemp';
      deepAgingModel.add(temp);
    }
    // 객체에 데이터 저장
    widget.meat.deepAging = deepAgingModel;
  }

  void calTime(DeepAgingData data, int index, bool edit) {
    if (edit == true) {
      totalHour -= hour[index];
      totalMinute -= minute[index];
    }
    hour[index] = int.parse(data.insertedHour!);
    minute[index] = int.parse(data.insertedMinute!);
    totalHour += hour[index];
    totalMinute += minute[index];
    if (totalMinute >= 60) {
      int q = totalMinute ~/ 60;
      int r = totalMinute % 60;
      totalHour += q;
      totalMinute = r;
    }
  }

  void widgetCreate(int index) {
    widgets.insert(
      index,
      Container(
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 30.0,
          right: 30.0,
        ),
        height: 70.0,
        child: OutlinedButton(
          onPressed: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '  ${index + 1}차\n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '처리일',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VerticalDivider(
                  thickness: 2,
                  width: 1,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${objects[index].insertedHour}시간 ${objects[index].insertedMinute}분',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32.sp,
                  ),
                ),
              ),
              Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${objects[index].selectedYear}.${objects[index].selectedMonth}.${objects[index].selectedDay}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('수정'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'EUWD2830aeaE',
        backButton: false,
        closeButton: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 65.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '원육',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.w,
              ),
              Divider(
                height: 0,
              ),
              SizedBox(
                height: 23.w,
              ),
              Row(
                children: [
                  Text(
                    '생성자ID',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'example@example.com',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Palette.greyTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.w,
              ),
              Container(
                width: 588.w,
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                decoration: BoxDecoration(
                  color: Palette.textFieldColor,
                ),
                child: Row(
                  children: [
                    Text('종'),
                    Spacer(),
                    Text('부위'),
                    Spacer(),
                    Text('도축일자'),
                    Spacer(),
                    Text('추가정보 입력'),
                  ],
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Row(
                children: [
                  Text(
                    '처리육',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 0,
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  Text(
                    '딥에이징 데이터',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              width: 0.5,
                            ),
                            elevation: 0,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )),
                        child: Text(
                          // 이는 엑셀 파일을 업로드 하기 위한 버튼이다.
                          '엑셀파일 업로드',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 588.w,
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                decoration: BoxDecoration(color: Palette.textFieldColor),
                child: Row(
                  children: [
                    Text('차수'),
                    Spacer(),
                    Text('처리시간'),
                    Spacer(),
                    Text('처리일자'),
                    Spacer(),
                    Text('추가정보 입력'),
                  ],
                ),
              ),
              SizedBox(
                height: 309.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widgets,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              // 만일 버튼 위젯이 3개가 된다면, 추가 버튼은 사라질 것이다.
              if (widgets.length < 3)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 103.h,
                      width: 588.w,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InsertDeepAgingData(
                                        agingdata: data,
                                      ))).then((value) {
                            setState(() {
                              if (data.insertedHour != null) {
                                objects.add(data);
                                widgetCreate(index);
                                calTime(data, index++, false);
                                data = DeepAgingData();
                              }
                            });
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 30.0,
                          color: Colors.grey[400],
                        ),
                        label: Text(
                          '추가하기',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Text(
                    '총처리횟수/총처리시간',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
              SizedBox(
                height: 18.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        '${widgets.length}회/ $totalHour시간 $totalMinute분',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 17.h),
                child: SaveButton(
                  text: '저장',
                  width: 658.w,
                  heigh: 104.h,
                  isWhite: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
