import 'dart:convert';
import 'dart:io';

import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/get_qr_page.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/m_num_data_list_card.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class NumCallDialog extends StatefulWidget {
  final Set dataList;
  final UserData userData;
  const NumCallDialog({
    super.key,
    required this.dataList,
    required this.userData,
  });

  @override
  State<NumCallDialog> createState() => _NumCallDialogState();
}

class _NumCallDialogState extends State<NumCallDialog> {
  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;
  List<String> mNumList = [];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged); // 텍스트 필드의 값이 변경될 때 호출할 메서드 등록
  }

  void _onTextChanged() {
    setState(() {
      isButtonEnabled = _controller.text.isNotEmpty; // 텍스트 필드 값이 비어있는지 확인하여 버튼 상태 업데이트
    });
  }

  Future<void> fetchData(String text) async {
    Map<String, dynamic>? jsonData = await ApiServices.searchMeatId(text);

    if (jsonData == null) {
      print('데이터 없음');
    } else {
      // "text" 배열에서 "id" 값을 가져오기
      List<dynamic> meatData = jsonData[text];
      setState(() {
        mNumList = meatData.cast<String>();
      });
    }
  }

  Future<void> saveData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${widget.userData.userId}-data-list.json');

      if (!await directory.exists()) {
        await directory.create(recursive: true); // 디렉토리를 먼저 생성
      }

      dynamic data = widget.dataList.toList();

      await file.writeAsString(jsonEncode(data));
      print('임시저장 성공');
    } catch (e) {
      print('임시저장 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.sp),
      ),
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Container(
                width: 590.w,
                height: 750.h,
                margin: EdgeInsets.all(30.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '관리번호 불러오기',
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonButton(
                            text: Text(
                              'QR 스캔',
                              style: TextStyle(fontSize: 28.sp),
                            ),
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetQrPage(
                                    dataList: widget.dataList,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            width: 245.w,
                            height: 64.h,
                            bgColor: Colors.white,
                            fgColor: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      Divider(
                        height: 0,
                        thickness: 3.sp,
                        color: Color.fromRGBO(228, 228, 228, 1),
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400.w,
                            height: 63.h,
                            child: TextFormField(
                              controller: _controller,
                              decoration: InputDecoration(
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('관리번호 입력'),
                                    SizedBox(
                                      width: 20.w,
                                    )
                                  ],
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(232, 232, 232, 1),
                                suffixIcon: null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(42.5.sp),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                              ),
                            ),
                          ),
                          Spacer(),
                          CommonButton(
                            text: Text('검색'),
                            onPress: isButtonEnabled
                                ? () {
                                    fetchData(_controller.text);
                                    FocusScope.of(context).unfocus();
                                  }
                                : null,
                            width: 161.w,
                            height: 63.h,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 29.h,
                      ),
                      Divider(
                        height: 0,
                        thickness: 6.sp,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 300.h,
                        child: ListView.builder(
                          itemCount: mNumList.length,
                          itemBuilder: (BuildContext context, int index) {
                            String mNum = mNumList[index];
                            return MNumDataListCard(
                              idx: index + 1,
                              mNum: mNum,
                              isInserted: widget.dataList.contains(mNum),
                              buttonAction: () async {
                                widget.dataList.add(mNum);
                                await saveData();
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SaveButton(
                        onPressed: () {
                          context.pop();
                        },
                        text: '완료',
                        width: 310.w,
                        heigh: 104.h,
                        isWhite: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.close,
                size: 48.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
