import 'package:deep_plant_app/pages/get_qr_page.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/m_num_data_list_card.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NumCallDialog extends StatefulWidget {
  final List data;
  const NumCallDialog({
    super.key,
    required this.data,
  });

  @override
  State<NumCallDialog> createState() => _NumCallDialogState();
}

class _NumCallDialogState extends State<NumCallDialog> {
  final TextEditingController _controller = TextEditingController();
  List<String> mNumList = [];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                        height: 41.h,
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
                                    data: widget.data,
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
                                contentPadding:
                                    EdgeInsets.only(bottom: 10, left: 10),
                              ),
                            ),
                          ),
                          Spacer(),
                          CommonButton(
                              text: Text('검색'),
                              onPress: _controller.text.isNotEmpty
                                  ? () {
                                      fetchData(_controller.text);
                                    }
                                  : null,
                              width: 161.w,
                              height: 63.h),
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
                              buttonAction: () {
                                widget.data.add(mNum);
                              },
                            );
                          },
                        ),
                      ),
                      Spacer(),
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
