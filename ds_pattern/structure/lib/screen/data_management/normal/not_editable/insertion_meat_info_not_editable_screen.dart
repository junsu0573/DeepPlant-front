import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/viewModel/data_management/normal/not_editable/insertion_meat_info_not_editable_view_model.dart';

class InsertionMeatInfoNotEditableScreen extends StatefulWidget {
  const InsertionMeatInfoNotEditableScreen({super.key});

  @override
  State<InsertionMeatInfoNotEditableScreen> createState() =>
      _InsertionMeatInfoNotEditableScreenState();
}

class _InsertionMeatInfoNotEditableScreenState
    extends State<InsertionMeatInfoNotEditableScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: '육류 기본정보',
          backButton: true,
          closeButton: true,
          closeButtonOnPressed: () => context
              .read<InsertionMeatInfoNotEditableViewModel>()
              .clickedCloseButton(context),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 79.w),
              child: Column(
                children: [
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      context
                          .read<InsertionMeatInfoNotEditableViewModel>()
                          .speciesValue,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    value: null,
                    itemList: const [],
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
                      context
                          .read<InsertionMeatInfoNotEditableViewModel>()
                          .primalValue,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    value: null,
                    itemList: const [],
                    onChanged: null,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      context
                          .read<InsertionMeatInfoNotEditableViewModel>()
                          .secondaryValue,
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    value: null,
                    itemList: const [],
                    onChanged: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
