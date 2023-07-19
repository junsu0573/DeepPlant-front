import 'package:deep_plant_app/models/deep_aging_data_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/insert_deep_aging_data_page.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DeepAging extends StatefulWidget {
  const DeepAging({super.key, required this.meat});
  final MeatData meat;

  @override
  State<DeepAging> createState() => _DeepAgingState();
}

class _DeepAgingState extends State<DeepAging> {
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

  void intoString() {
    // 시간을 분으로 통합 | 전달 형식에 맞게 '년월일/분'으로 변환
    for (int i = 0; i < objects.length; i++) {
      String timeTemp = ((int.parse(objects[i].insertedHour!) * 60) + (int.parse(objects[i].insertedMinute!))).toString();
      String temp = '${objects[i].selectedYear}${objects[i].selectedMonth}${objects[i].selectedDay}/$timeTemp';
      deepAgingModel.add(temp);
    }
    // 객체에 데이터 저장
    widget.meat.deepAging = deepAgingModel;
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

  Widget widgetCreate(int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 30.0,
        right: 30.0,
      ),
      height: 70.0,
      child: OutlinedButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InsertDeepAgingData(
                        agingdata: objects[index],
                      ))).then((_) {
            editing(index, objects[index]);
          });
        },
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
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 20.0,
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
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: '', backButton: false, closeButton: true),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '딥에이징 데이터',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(
                  right: 30.0,
                ),
                child: ElevatedButton(
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
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widgets.length,
              itemBuilder: (BuildContext context, int index) {
                return widgets[index];
              },
            ),
          ),
          // 만일 버튼 위젯이 3개가 된다면, 추가 버튼은 사라질 것이다.
          if (widgets.length < 3)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  height: 70.0,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InsertDeepAgingData(
                                    agingdata: data,
                                  ))).then((_) {
                        setState(() {
                          if (data.insertedHour != null) {
                            objects.insert(index, data);
                            widgets.insert(index, widgetCreate(index));
                            calTime(data, index++, false);
                            // 객체를 초기화 해준다.
                            data = DeepAgingData();
                          }
                        });
                      });
                    },
                    // 이 아래는 추가하는 버튼에 대한 내용이며, 위는 setState를 통해 버튼이 만들어진다.
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
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0, bottom: 5.0),
            child: Row(
              children: [
                Text(
                  '총처리횟수/총처리시간',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 5.0, bottom: 20.0),
            child: Column(
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
            child: Transform.translate(
              offset: Offset(0, 0),
              child: SizedBox(
                height: 55,
                width: 350,
                child: ElevatedButton(
                  onPressed: (objects.isNotEmpty)
                      ? () {
                          intoString();
                          context.pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    disabledBackgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    '저장',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
