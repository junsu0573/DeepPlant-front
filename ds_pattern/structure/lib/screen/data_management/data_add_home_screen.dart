import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/components/deep_aging_card.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/data_management/data_add_home_view_model.dart';

class DataAddHome extends StatefulWidget {
  const DataAddHome({super.key});

  @override
  State<DataAddHome> createState() => _DataAddHomeState();
}

class _DataAddHomeState extends State<DataAddHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: context.read<DataAddHomeViewModel>().meatModel.id!,
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
              const Divider(
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
                    context.read<DataAddHomeViewModel>().userId,
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
                decoration: const BoxDecoration(
                  color: Palette.mainTextFieldColor,
                ),
                child: Row(
                  children: [
                    Text(
                      '종',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const Spacer(),
                    Text(
                      '부위',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const Spacer(),
                    Text(
                      '도축일자',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const Spacer(),
                    Text(
                      '추가정보 입력',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                height: 70.0,
                child: OutlinedButton(
                  onPressed: () => context
                      .read<DataAddHomeViewModel>()
                      .clickedRawMeat(context),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32.w,
                        child: Center(
                          child: Text(
                            context.read<DataAddHomeViewModel>().species,
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
                          context.read<DataAddHomeViewModel>().secondary,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 208.w,
                        child: Text(
                          context.read<DataAddHomeViewModel>().butcheryDate,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 82.w,
                        child: Text(
                          context
                                  .read<DataAddHomeViewModel>()
                                  .meatModel
                                  .rawmeatDataComplete!
                              ? '완료'
                              : '미완료',
                          style: const TextStyle(color: Colors.black),
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
              const Divider(
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
                  const Spacer(),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 588.w,
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                decoration:
                    const BoxDecoration(color: Palette.mainTextFieldColor),
                child: Row(
                  children: [
                    Text(
                      '차수',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const Spacer(),
                    Text(
                      '처리시간',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const Spacer(),
                    Text(
                      '처리일자',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                    const Spacer(),
                    Text(
                      '추가정보 입력',
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 339.h,
                child: context.watch<DataAddHomeViewModel>().isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: context
                            .read<DataAddHomeViewModel>()
                            .meatModel
                            .deepAgingData!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeepAgingCard(
                            deepAgingNum: context
                                .read<DataAddHomeViewModel>()
                                .meatModel
                                .deepAgingData![index]["deepAgingNum"],
                            minute: context
                                .read<DataAddHomeViewModel>()
                                .meatModel
                                .deepAgingData![index]["minute"],
                            butcheryDate: context
                                .read<DataAddHomeViewModel>()
                                .meatModel
                                .deepAgingData![index]["date"],
                            completed: context
                                .read<DataAddHomeViewModel>()
                                .meatModel
                                .deepAgingData![index]["complete"],
                            isLast: index ==
                                    context
                                            .read<DataAddHomeViewModel>()
                                            .meatModel
                                            .deepAgingData!
                                            .length -
                                        1
                                ? true
                                : false,
                            onTap: () async => context
                                .read<DataAddHomeViewModel>()
                                .clickedProcessedMeat(index, context),
                            delete: () async => context
                                .read<DataAddHomeViewModel>()
                                .deleteList(index + 1),
                          );
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
                      onPressed: () => context
                          .read<DataAddHomeViewModel>()
                          .addDeepAgingData(context),
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
              const Row(
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
                        context.watch<DataAddHomeViewModel>().total,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
