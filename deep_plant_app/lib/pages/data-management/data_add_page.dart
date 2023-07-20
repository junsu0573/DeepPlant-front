import 'dart:convert';

import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/widgets/call_mangement_dialog.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/m_num_data_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class DataAdd extends StatefulWidget {
  final MeatData meat;
  const DataAdd({
    super.key,
    required this.meat,
  });

  @override
  State<DataAdd> createState() => _DataAddState();
}

class _DataAddState extends State<DataAdd> {
  List<String> dataList = [];

  Future<void> getMeatData(String text) async {
    var url = Uri.parse('http://10.221.72.45:8080/meat?id=$text');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = await jsonDecode(response.body);
      meatDataFetch(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // step-1 데이터로 객체 초기화
  void meatDataFetch(Map data) {
    widget.meat.id = data['id'];
    widget.meat.userId = data['uesrId'];
    widget.meat.createdAt = data['createdAt'];
    widget.meat.traceNum = data['traceNum'];
    widget.meat.farmAddr = data['farmAddr'];
    widget.meat.farmerNm = data['farmerNm'];
    widget.meat.butcheryYmd = data['butcheryYmd'];
    widget.meat.birthYmd = data['birthYmd'];
    widget.meat.sexType = data['sexType'];
    widget.meat.freshmeat = data['freshmeat'];
    widget.meat.gradeNum = data['gradeNum'];
    widget.meat.speciesValue = data['speciesValue'];
    widget.meat.primalValue = data['primalValue'];
    widget.meat.secondaryValue = data['secondaryValue'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '데이터 추가',
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 21.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonButton(
              text: Text(
                '불러오기',
                style: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NumCallDialog(
                      data: dataList,
                    );
                  },
                ).then((value) {
                  setState(() {});
                });
              },
              width: 165.w,
              height: 63.h,
              bgColor: Colors.white,
              fgColor: Colors.black,
            ),
          ],
        ),
        SizedBox(
          height: 27.h,
        ),
        SizedBox(
          child: Divider(
            thickness: 6.sp,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  getMeatData(dataList[index]);
                  context.go('/option/show-step-2');
                },
                child: MNumDataListCard(
                  idx: index + 1,
                  mNum: dataList[index],
                  noButton: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
