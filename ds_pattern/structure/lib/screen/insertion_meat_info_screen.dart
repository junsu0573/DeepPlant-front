import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/custom_drop_down.dart';
import 'package:structure/components/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/viewModel/insertion_meat_info_view_model.dart';

class InsertionMeatInfoScreen extends StatefulWidget {
  final MeatModel meatData;
  const InsertionMeatInfoScreen({super.key, required this.meatData});

  @override
  State<InsertionMeatInfoScreen> createState() => _InsertionMeatInfoScreenState();
}

class _InsertionMeatInfoScreenState extends State<InsertionMeatInfoScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.meatData.speciesValue != null) {
      context.read<InsertionMeatInfoViewModel>().fetchMeatData();
    }
    context.read<InsertionMeatInfoViewModel>().initialize();
    setState(() {});
  }

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
          closeButton: false,
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
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      context.read<InsertionMeatInfoViewModel>().speciesValue,
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
                      '대분할',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Pallete.greyTextColor,
                      ),
                    ),
                    value: context.read<InsertionMeatInfoViewModel>().primalValue,
                    itemList: context.read<InsertionMeatInfoViewModel>().largeDiv,
                    onChanged: context.read<InsertionMeatInfoViewModel>().isSelectedSpecies
                        ? (value) {
                            setState(() {
                              context.read<InsertionMeatInfoViewModel>().primalValue = value as String;
                              context.read<InsertionMeatInfoViewModel>().setPrimal();
                            });
                          }
                        : null,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomDropdown(
                    hintText: Text(
                      '소분할',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w400,
                        color: Pallete.greyTextColor,
                      ),
                    ),
                    value: context.read<InsertionMeatInfoViewModel>().secondaryValue,
                    itemList: context.read<InsertionMeatInfoViewModel>().litteDiv,
                    onChanged: context.read<InsertionMeatInfoViewModel>().isSelectedPrimal
                        ? (value) {
                            setState(() {
                              context.read<InsertionMeatInfoViewModel>().secondaryValue = value as String;
                              context.read<InsertionMeatInfoViewModel>().secondaryValue;
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
              child: MainButton(
                onPressed: context.read<InsertionMeatInfoViewModel>().isAllChecked()
                    ? () {
                        context.read<InsertionMeatInfoViewModel>().saveMeatData();
                        Navigator.pop(context);
                      }
                    : null,
                text: '완료',
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
