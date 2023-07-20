import 'package:deep_plant_app/models/deep_aging_data_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/insert_deep_aging_data_page.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DataAddHome extends StatefulWidget {
  final MeatData meatData;
  const DataAddHome({
    super.key,
    required this.meatData,
  });

  @override
  State<DataAddHome> createState() => _DataAddHomeState();
}

class _DataAddHomeState extends State<DataAddHome> {
  // deepagingdata 객체가 모인다.
  final List<DeepAgingData> objects = [];

  // model로 보낼 변환된 string이 보관된다.
  final List<String> deepAgingModel = [];

  // 작동을 진행할 버튼 위젯이 보관된다.
  List<Widget> widgets = [];

  // 작업 진행 중 사용될 딥에이징 데이터 객체
  DeepAgingData data = DeepAgingData();

  int totalMinute = 0;
  int totalHour = 0;
  // 객체와 위젯의 index를 표현한다.
  int index = 0;
  // 객체 중 시간 요소를 담게 된다.
  List<int> hour = List<int>.filled(3, 0);
  List<int> minute = List<int>.filled(3, 0);

  // 추가 정보의 입력이 온전한지를 판별해준다.
  bool isFreshEnd = false;
  List<bool> isDeepEnd = [false, false, false];

  void intoString() {
    // 시간을 분으로 통합 | 전달 형식에 맞게 '년월일/분'으로 변환
    for (int i = 0; i < objects.length; i++) {
      String timeTemp = ((int.parse(objects[i].insertedHour!) * 60) + (int.parse(objects[i].insertedMinute!))).toString();
      String temp = '${objects[i].selectedYear}${objects[i].selectedMonth}${objects[i].selectedDay}/$timeTemp';
      deepAgingModel.add(temp);
    }
    // 객체에 데이터 저장
    widget.meatData.deepAging = deepAgingModel;
  }

  void calTime(DeepAgingData data, int index, bool edit) {
    // 시간 계산이 진행되며, 데이터 수정시에는 기존 값을 제거한다.
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

  void editing(int index, dynamic value) {
    // 위젯을 수정, 객체의 값이 변할 때 작동한다.
    setState(() {
      objects[index] = value;
      calTime(objects[index], index, true);
      widgets[index] = widgetCreate(index);
    });
  }

  void checkFresh() {
    if (widget.meatData.heatedmeat != null && widget.meatData.tongueData != null && widget.meatData.labData != null) {
      isFreshEnd = true;
    } else {
      isFreshEnd = false;
    }
  }

  void tempDataFetch() {
    widget.meatData.butcheryYmd = '2022.09.19';
    widget.meatData.speciesValue = '소';
    widget.meatData.secondaryValue = '갈비살';
    widget.meatData.heatedmeat = {
      'createdAt': DateTime.now(),
      'period': DateTime.now(),
      'flavor': 1.0,
      'juiciness': 1.0,
      'tenderness': 1.0,
      'umami': 1.0,
      'palability': 1.0,
    };
    widget.meatData.freshmeat = {
      'createdAt': DateTime.now(),
      'period': DateTime.now(),
      'flavor': 1.0,
      'juiciness': 1.0,
      'tenderness': 1.0,
      'umami': 1.0,
      'palability': 1.0,
    };
    widget.meatData.tongueData = {
      'sourness': 1.0,
      'bitterness': 2.0,
      'umami': 3.0,
      'richness': 4.0,
    };
    widget.meatData.labData = {
      'L': 1.0,
      'a': 1.0,
      'b': 1.0,
      'DL': 1.0,
      'CL': 1.0,
      'RW': 1.0,
      'ph': 1.0,
      'WBSF': 1.0,
      'cardepsin_activity': 1.0,
      'MFI': 1.0,
    };
    widget.meatData.deepAging = ['20230720/120', '20230719/220'];
    intoObject(widget.meatData.deepAging!);
  }

  void intoObject(List<String> objects) {
    for (int i = 0; i < objects.length; i++) {
      String part = objects[i].replaceAll(RegExp(r'\D'), '');
      String part1 = part.substring(0, 4);
      String part2 = part.substring(4, 6);
      String part3 = part.substring(6, 8);
      String part4 = part.substring(8, part.length);
      if (int.parse(part4) >= 60) {
        data.insertedHour = (int.parse(part4) ~/ 60).toString();
        data.insertedMinute = (int.parse(part4) % 60).toString();
      }
      data.selectedYear = part1;
      data.selectedMonth = part2;
      data.selectedDay = part3;

      intoData();
    }
  }

  void intoData() {
    setState(() {
      if (data.insertedHour != null) {
        objects.insert(index, data);
        widgets.insert(index, widgetCreate(index));
        calTime(data, index++, false);
        // 객체를 초기화 해준다.
        data = DeepAgingData();
      }
    });
  }

  @override
  void initState() {
    tempDataFetch();
    checkFresh();
    super.initState();
  }

  Widget widgetCreate(int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      height: 70.0,
      child: OutlinedButton(
        onPressed: () {
          context.go('/option/data-management/data-add/data-add-home/step-deepaging-meat');
        },
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6.0),
              child: Text(
                '${index + 1}차',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: VerticalDivider(
                thickness: 2,
                width: 1,
                color: Colors.grey[300],
              ),
            ),
            Container(
              width: 190.w,
              padding: EdgeInsets.only(left: 6.0),
              child: Text(
                '${objects[index].insertedHour}시간 ${objects[index].insertedMinute}분',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(
                '${objects[index].selectedYear}.${objects[index].selectedMonth}.${objects[index].selectedDay}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 40.w,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                isDeepEnd[index] ? '완료' : '미완료',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
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
                thickness: 1.5,
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
                    Text(
                      '종',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Spacer(),
                    Text(
                      '부위',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      '도축일자',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Spacer(),
                    Text(
                      '추가정보 입력',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                height: 70.0,
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/option/data-management/data-add/data-add-home/step-fresh-meat');
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 6.0),
                        child: Text(
                          widget.meatData.speciesValue!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: VerticalDivider(
                          thickness: 2,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                      Container(
                        width: 180.w,
                        padding: EdgeInsets.only(left: 6.0),
                        child: Text(
                          widget.meatData.secondaryValue!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Text(
                          widget.meatData.butcheryYmd!,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          isFreshEnd ? '완료' : '미완료',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
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
                thickness: 1.5,
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
                    Text(
                      '차수',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Spacer(),
                    Text(
                      '처리시간',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      '처리일자',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    Spacer(),
                    Text(
                      '추가정보 입력',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 339.h,
                child: ListView.builder(
                  itemCount: widgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgets[index];
                  },
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
                                      ))).then((_) {
                            intoData();
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
