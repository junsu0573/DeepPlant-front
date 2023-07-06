import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/m_num_data_list_card.dart';
import 'package:deep_plant_app/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void showCallManagement(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        insetPadding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: Stack(
          children: [
            Container(
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
                            '엑셀파일 업로드',
                            style: TextStyle(fontSize: 28.sp),
                          ),
                          onPress: () {},
                          width: 245.w,
                          height: 63.h,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonButton(
                          text: Text(
                            'QR 스캔',
                            style: TextStyle(fontSize: 28.sp),
                          ),
                          onPress: () {},
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
                            ),
                          ),
                        ),
                        Spacer(),
                        CommonButton(
                            text: Text('검색'),
                            onPress: () {},
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
                      height: 200.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MNumDataListCard(
                                idx: 1, mNum: '000189843795aefasfesfa'),
                            MNumDataListCard(idx: 2, mNum: '000189843795'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SaveButton(
                      onPressed: () {},
                      text: '완료',
                      width: 310.w,
                      heigh: 104.h,
                      isWhite: false,
                    ),
                  ],
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
    },
  );
}
