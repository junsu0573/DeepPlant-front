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
  List<String>? largeData;
  List<List<String>>? tableData;

  String? selectedOrder; // -> 소, 돼지의 실질적 텍스트
  int orderNum = 0; // -> 소, 돼지의 편의적 정수
  bool isselectedorder = false; // -> 완료 되었는지를 확인

  String? selectedLarge; // -> 선택된 종류에 대한 대분류 텍스트
  int largeNum = 0; // -> 선택된 분류에 대한 편의적 수
  bool isselectedlarge = false; // -> 완료 되었는지를 확인

  String? selectedLittle; // -> 선택된 종류에 대한 소분류 텍스트
  int littleNum = 0; // -> 선택된 분류에 대한 편의적 수

  String? finalNumber; // -> 모든 선택 이후에 만들게 될 텍스트
  bool isFinal = false; // -> 모든 선택이 완료되었는지에 대한 분류

  void setOrder(String order, MeatInfoSource source) {
    if (order == '소') {
      orderNum = 0;
      isselectedorder = true;
      selectedLarge = null;
      isselectedlarge = false;
      selectedLittle = null;
      finalNumber = null;
      isFinal = false;
      largeNum = 0;
      littleNum = 0;
      largeData = source.largeOrders_1;
    } else if (order == '돼지') {
      orderNum = 1;
      isselectedorder = true;
      selectedLarge = null;
      isselectedlarge = false;
      selectedLittle = null;
      finalNumber = null;
      isFinal = false;
      largeNum = 0;
      littleNum = 0;
      largeData = source.largeOrders_2;
    }
  }

  void setLarge(String large, MeatInfoSource source) {
    for (int i = 0; i < largeData!.length; i++) {
      if (large == largeData![i]) {
        largeNum = i;
        isselectedlarge = true;
        selectedLittle = null;
        finalNumber = null;
        isFinal = false;
        tableData = (orderNum == 0 ? source.tableData_1 : source.tableData_2);
        littleNum = 0;
        break;
      }
    }
  }

  void setLittle(String little, MeatInfoSource source) {
    for (int i = 0; i < tableData!.length; i++) {
      if (little == tableData![largeNum][i]) {
        littleNum = i;
        isFinal = true;
        break;
      }
    }
  }

  // 육류 정보 저장
  void saveMeatData(MeatInfoSource source) {
    widget.meatData.speciesValue = source.species[selectedOrder];
    if (selectedOrder == '소') {
      widget.meatData.primalValue = source.cattleLarge[selectedLarge];
      widget.meatData.secondaryValue = source.cattleSmall[selectedLittle];
    } else if (selectedOrder == '돼지') {
      widget.meatData.primalValue = source.pigLarge[selectedLarge];
      widget.meatData.secondaryValue = source.pigSmall[selectedLittle];
    }
  }

  @override
  void initState() {
    if (widget.meatData.speciesValue == '돼지') {
      selectedOrder = '돼지';
      setOrder(selectedOrder!, source);
    } else {
      selectedOrder = '소';
      setOrder(selectedOrder!, source);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> orders = source.orders;
    List<String> largeOrders_1 = source.largeOrders_1;
    List<String> largeOrders_2 = source.largeOrders_2;
    List<List<String>> tableData_1 = source.tableData_1;
    List<List<String>> tableData_2 = source.tableData_2;

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
                        '종류 선택',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w400,
                          color: Palette.greyTextColor,
                        ),
                      ),
                      value: selectedOrder,
                      itemList: orders,
                      onChanged: null),
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
                    itemList: orderNum == 0 ? largeOrders_1 : largeOrders_2,
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
                    itemList: orderNum == 0
                        ? tableData_1[largeNum]
                        : tableData_2[largeNum],
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
