import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/source/pallete.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/widgets/custom_dropdown.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:deep_plant_app/source/meat_info_source.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsertionMeatInfo extends StatefulWidget {
  final MeatData meatData;
  const InsertionMeatInfo({
    super.key,
    required this.meatData,
  });

  @override
  State<InsertionMeatInfo> createState() => _InsertionMeatInfoState();
}

class _InsertionMeatInfoState extends State<InsertionMeatInfo> {
  MeatInfoSource source = MeatInfoSource();

  String? selectedOrder; // -> 소, 돼지의 실질적 텍스트

  bool isselectedorder = false; // -> 완료 되었는지를 확인

  String? selectedLarge; // -> 선택된 종류에 대한 대분류 텍스트
  int largeNum = 0; // -> 선택된 분류에 대한 편의적 수
  bool isselectedlarge = false; // -> 완료 되었는지를 확인

  String? selectedLittle; // -> 선택된 종류에 대한 소분류 텍스트
  int littleNum = 0; // -> 선택된 분류에 대한 편의적 수

  String? finalNumber; // -> 모든 선택 이후에 만들게 될 텍스트
  bool isFinal = false; // -> 모든 선택이 완료되었는지에 대한 분류

  List<String> largeDiv = [];
  List<String> litteDiv = [];

  Map<String, dynamic>? dataTable;

  void setOrder(String order, MeatInfoSource source) {
    if (order == '소') {
      isselectedorder = true;
      selectedLarge = null;
      isselectedlarge = false;
      selectedLittle = null;
      finalNumber = null;
      isFinal = false;
      largeNum = 0;
      littleNum = 0;
    } else if (order == '돼지') {
      isselectedorder = true;
      selectedLarge = null;
      isselectedlarge = false;
      selectedLittle = null;
      finalNumber = null;
      isFinal = false;
      largeNum = 0;
      littleNum = 0;
    }
  }

  void setLarge(String large, MeatInfoSource source) {
    isselectedlarge = true;
    selectedLittle = null;
    finalNumber = null;
    isFinal = false;
    littleNum = 0;
    litteDiv = List<String>.from(dataTable![large].map((element) => element.toString()));
  }

  void setLittle(String little, MeatInfoSource source) {
    isFinal = true;
  }

  // 육류 정보 저장
  void saveMeatData(MeatInfoSource source) {
    widget.meatData.speciesValue = selectedOrder;
    widget.meatData.primalValue = selectedLarge;
    widget.meatData.secondaryValue = selectedLittle;
  }

  @override
  void initState() {
    super.initState();
    if (widget.meatData.speciesValue == '돼지') {
      selectedOrder = '돼지';
      setOrder(selectedOrder!, source);
    } else {
      selectedOrder = '소';
      setOrder(selectedOrder!, source);
    }
    initialize();
    setState(() {});
  }

  void initialize() async {
    dynamic data = await MeatInfoSource.getDiv(selectedOrder!);
    dataTable = data;

    List<String> lDiv = [];
    for (String key in dataTable!.keys) {
      lDiv.add(key);
    }

    largeDiv = lDiv;
    if (widget.meatData.secondaryValue != null) {
      selectedLarge = widget.meatData.primalValue;
      setLarge(selectedLarge!, source);
      selectedLittle = widget.meatData.secondaryValue;
      setLittle(selectedLittle!, source);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: '',
          backButton: false,
          closeButton: true,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 79.w),
              child: Column(
                children: [
                  Text(
                    '육류 정보 입력',
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 126.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '종류',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      selectedOrder!,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    value: null,
                    itemList: [],
                    onChanged: null,
                  ),
                  SizedBox(
                    height: 42.0.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '부위',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0.h,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      '대분할 선택',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Palette.greyTextColor,
                      ),
                    ),
                    value: selectedLarge,
                    itemList: largeDiv,
                    onChanged: isselectedorder
                        ? (value) {
                            setState(() {
                              selectedLarge = value as String;
                              setLarge(selectedLarge!, source);
                            });
                          }
                        : null,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      '소분할 선택',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Palette.greyTextColor,
                      ),
                    ),
                    value: selectedLittle,
                    itemList: litteDiv,
                    onChanged: isselectedlarge
                        ? (value) {
                            setState(() {
                              selectedLittle = value as String;
                              setLittle(selectedLittle!, source);
                            });
                          }
                        : null,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 28.h),
              child: SaveButton(
                onPressed: isFinal
                    ? () {
                        saveMeatData(MeatInfoSource());
                        Navigator.pop(context);
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
    );
  }
}
