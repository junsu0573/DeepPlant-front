import 'package:deep_plant_app/models/deep_aging_data_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/insert_deep_aging_data_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/step_deepaging_meat_page.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/step_fresh_meat_page.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataAddHome extends StatefulWidget {
  final MeatData meatData;
  final UserData userData;
  const DataAddHome(
      {super.key, required this.meatData, required this.userData});

  @override
  State<DataAddHome> createState() => _DataAddHomeState();
}

class _DataAddHomeState extends State<DataAddHome> {
  // 입력된 데이터를 보관하게 된다.
  List<DeepAgingData> objects = [];

  // 진행 과정에서의 버튼 위젯이 보관된다.
  List<Widget> widgets = [];

  // 작업 진행 중 사용될 딥에이징 데이터 임시 객체
  DeepAgingData data = DeepAgingData();

  int totalMinute = 0;
  int lastHour = 0;
  int lastMinute = 0;
  // 객체와 위젯의 index를 표현한다.
  int index = 0;
  // 객체 중 시간 요소를 담게 된다.
  List<int> minute = [];

  // 추가 정보의 입력이 온전한지를 판별해준다.
  bool isFreshEnd = false;
  List<bool> isDeepEnd = [];

  void intoModel(int i) {
    // 시간을 분으로 통합 | 전달 형식에 맞게 '년월일/분'으로 변환
    // 최종적으로 데이터를 객체에 전달하는 함수이다.

    String temp =
        '${objects[i].selectedYear}${objects[i].selectedMonth}${objects[i].selectedDay}/$totalMinute';
    if (widget.meatData.deepAging == null) {
      widget.meatData.deepAging = [temp];
    } else {
      widget.meatData.deepAging!.add(temp);
    }
  }

  void calTime(DeepAgingData data, int index, bool edit) {
    // 시간 계산이 진행되며, 데이터 수정시에는 기존 값을 제거한다.
    if (edit == true) {
      totalMinute -= minute[index];
    }
    minute[index] = int.parse(data.insertedMinute!);
    totalMinute += minute[index];
    if (totalMinute >= 60) {
      int q = totalMinute ~/ 60;
      int r = totalMinute % 60;
      lastHour = q;
      lastMinute = r;
    } else {
      lastMinute = totalMinute;
    }
  }

  void editing(int index, dynamic value) {
    // 위젯을 수정, 객체의 값이 변할 때 작동한다. -> 아직은 사용되지 않는다.
    setState(() {
      objects[index] = value;
      calTime(objects[index], index, true);
      widgets[index] = widgetCreate(index);
    });
  }

  void checkFresh() {
    // 신선육 데이터가 온전히 입력 되었을 경우에 사용되는 기능이다.
    if (widget.meatData.heatedImage != null &&
        widget.meatData.heatedmeat != null &&
        widget.meatData.tongueData != null &&
        widget.meatData.labData != null) {
      isFreshEnd = true;
    } else {
      isFreshEnd = false;
    }
    setState(() {});
  }

  void checkDeep(dynamic data, int index) {
    if (data.deepAgedImage != null ||
        data.deepAgedFreshmeat != null ||
        data.heatedmeat != null ||
        data.tongueData != null ||
        data.labData != null) {
      isDeepEnd[index] = true;
    } else {
      isDeepEnd[index] = false;
    }
    setState(() {});
    print(isDeepEnd[index]);
  }

  String intoYmd(String temp) {
    String part1 = temp.substring(0, 4);
    String part2 = temp.substring(4, 6);
    String part3 = temp.substring(6, 8);

    String formattedString = "$part1.$part2.$part3";

    return formattedString;
  }

  void intoData() {
    // 딥에이징 데이터를 추가할 때 호출된다.
    setState(() {
      if (data.insertedMinute != null) {
        minute.add(0);
        objects.insert(index, data);
        widgets.insert(index, widgetCreate(index));
        // 데이터 fetch
        intoModel(index);
        // 시간 계산
        calTime(data, index++, false);
        // 객체를 초기화 해준다.
        data = DeepAgingData();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
    checkFresh();
  }

  void initialize() {
    // 초기 데이터를 불러오기 위해 사용된다.
    List<String>? deepAging = widget.meatData.deepAging;

    if (deepAging != null) {
      List<Widget> temp = [];
      for (index = 0; index < deepAging.length; index++) {
        objects.add(DeepAgingData());
        minute.add(0);

        // 정규표현식을 사용하여 연도, 월, 일, 분 값을 추출
        RegExp regex = RegExp(r"(\d{4})(\d{2})(\d{2})/(\d+)");
        Match? match = regex.firstMatch(deepAging[index]);

        if (match != null) {
          String year = match.group(1)!;
          String month = match.group(2)!;
          String day = match.group(3)!;
          int minutes = int.parse(match.group(4)!);

          objects[index].selectedYear = year;
          objects[index].selectedMonth = month;
          objects[index].selectedDay = day;
          objects[index].insertedMinute = '$minutes';
        }
        calTime(objects[index], index, false);
        temp.add(widgetCreate(index));
        widgets = temp;
      }
    }
  }

  Widget widgetCreate(int widgetIndex) {
    isDeepEnd.add(false);
    return Container(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      height: 70.0,
      child: OutlinedButton(
        onPressed: () async {
          widget.meatData.seqno = widgetIndex + 1;
          final data = await ApiServices.getMeatData(widget.meatData.id!);
          widget.meatData.fetchData(data);
          widget.meatData.fetchDataForDeepAging();
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StepDeepagingMeat(
                userData: widget.userData,
                meatData: widget.meatData,
              ),
            ),
          ).then((_) => checkDeep(widget.meatData, widgetIndex));
        },
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 6.0),
              child: Text(
                '${widgetIndex + 1}차',
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
                '${objects[widgetIndex].insertedMinute}분',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(
                '${objects[widgetIndex].selectedYear}.${objects[widgetIndex].selectedMonth}.${objects[widgetIndex].selectedDay}',
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
                (isDeepEnd[widgetIndex] == true)
                    ? '완료'
                    : '미완료', // 임시 지정, 후에 수정해야 함!
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
        title: widget.meatData.id!,
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
                    widget.meatData.createUser!,
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
                    widget.meatData.fetchDataForOrigin();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StepFreshMeat(
                          meatData: widget.meatData,
                          userData: widget.userData,
                        ),
                      ),
                    ).then((_) => checkFresh());
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
                          (intoYmd(widget.meatData.butcheryYmd!)),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 103.h,
                    width: 588.w,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        widget.meatData.seqno = widgets.length + 1;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InsertDeepAgingData(
                                      agingdata: data,
                                      meatData: widget.meatData,
                                    ))).then((_) async {
                          if (data.insertedMinute != null) {
                            intoData();
                            await ApiServices.sendMeatData(
                              'deep_aging_data',
                              widget.meatData.convertDeepAgingToJson(),
                            );
                          }
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
                        '${widgets.length}회/ $lastHour시간 $lastMinute분',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
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
