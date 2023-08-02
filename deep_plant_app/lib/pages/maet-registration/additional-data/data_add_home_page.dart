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
  const DataAddHome({super.key, required this.meatData, required this.userData});

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

  void calTime(DeepAgingData data, int index, bool edit) {
    // 시간 계산이 진행되며, 데이터 수정시에는 기존 값을 제거한다.
    if (edit == false) {
      totalMinute += int.parse(data.insertedMinute!);
    } else {
      totalMinute -= int.parse(data.insertedMinute!);
    }

    if (totalMinute >= 60) {
      int q = totalMinute ~/ 60;
      int r = totalMinute % 60;
      lastHour = q;
      lastMinute = r;
    } else {
      lastHour = 0;
      lastMinute = totalMinute;
    }
  }

  String intoYmd(String temp) {
    String part1 = temp.substring(0, 4);
    String part2 = temp.substring(4, 6);
    String part3 = temp.substring(6, 8);

    String formattedString = "$part1.$part2.$part3";

    return formattedString;
  }

  // 딥에이징 데이터 추가
  void addDeepAgingData() {
    // 딥에이징 데이터를 추가할 때 호출된다.
    setState(() {
      if (data.insertedMinute != null) {
        if (index >= 1) {
          widgets[index - 1] = widgetCreate(index - 1, null);
        }
        objects.insert(index, data);

        widgets.insert(index, widgetCreate(index, true));
        // 시간 계산
        calTime(data, index++, false);
      }
    });
  }

  // 딥에이징 데이터 삭제
  void deleteDeepAgingData() async {
    final data = await ApiServices.deleteDeepAging(widget.meatData.id!, index);
    if (data == null) {
      print('딥에이징 데이터 삭제 실패');
    } else {
      setState(() {
        calTime(objects.last, index, true);
        objects.removeLast();
        widgets.removeLast();
        widget.meatData.deepAging!.removeLast();
      });
    }
  }

  Future<void> dataFetch() async {}

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    // 초기 데이터를 불러오기 위해 사용된다.
    List<String>? deepAging = widget.meatData.deepAging;

    if (deepAging != null) {
      List<Widget> temp = [];
      for (index = 0; index < deepAging.length; index++) {
        objects.add(DeepAgingData());

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
        if (index == widget.meatData.deepAging!.length - 1) {
          temp.add(widgetCreate(index, true));
        } else {
          temp.add(widgetCreate(index, null));
        }

        widgets = temp;
      }
    }
  }

  Widget widgetCreate(int widgetIndex, bool? isLast) {
    return Stack(
      children: [
        Container(
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
              await widget.meatData.fetchDataForDeepAging();
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StepDeepagingMeat(
                    userData: widget.userData,
                    meatData: widget.meatData,
                  ),
                ),
              ).then((_) async {
                final data = await ApiServices.getMeatData(widget.meatData.id!);
                widget.meatData.fetchData(data);
                widgets[widgetIndex] = widgetCreate(widgetIndex, null);
              });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 52.w,
                  child: Center(
                    child: Text(
                      '${widgetIndex + 1}차',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 54.w,
                  child: VerticalDivider(
                    thickness: 2,
                    width: 1,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  width: 128.w,
                  child: Text(
                    '${objects[widgetIndex].insertedMinute}분',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 186.w,
                  child: Text(
                    '${objects[widgetIndex].selectedYear}.${objects[widgetIndex].selectedMonth}.${objects[widgetIndex].selectedDay}',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    widget.meatData.processedmeatDataComplete![widgetIndex] ? '완료' : '진행중',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
        isLast != null && isLast == true
            ? Positioned(
                top: -5.h,
                right: -10.w,
                child: IconButton(
                  onPressed: () {
                    deleteDeepAgingData();
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 30.sp,
                    color: Palette.greyTextColor,
                  ),
                ),
              )
            : Container(),
      ],
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
                padding: EdgeInsets.symmetric(horizontal: 32.w),
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
                    Spacer(),
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
                    ).then((_) async {
                      final data = await ApiServices.getMeatData(widget.meatData.id!);
                      widget.meatData.fetchData(data);
                      setState(() {});
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32.w,
                        child: Center(
                          child: Text(
                            widget.meatData.speciesValue!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 42.w,
                        child: VerticalDivider(
                          thickness: 2,
                          width: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 140.w,
                        child: Text(
                          widget.meatData.secondaryValue!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 208.w,
                        child: Text(
                          (intoYmd(widget.meatData.butcheryYmd!)),
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 82.w,
                        child: Text(
                          widget.meatData.rawmeatDataComplete! ? '완료' : '진행중',
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
                padding: EdgeInsets.symmetric(horizontal: 32.w),
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
                    Spacer(),
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
                            await ApiServices.sendMeatData(
                              'deep_aging_data',
                              widget.meatData.convertDeepAgingToJson(),
                            );
                            final response = await ApiServices.getMeatData(widget.meatData.id!);
                            widget.meatData.fetchData(response);
                            addDeepAgingData();
                            // 객체를 초기화 해준다.
                            data = DeepAgingData();
                            setState(() {});
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
