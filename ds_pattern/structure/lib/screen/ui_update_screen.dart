import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/main_button.dart';
import 'package:structure/config/pallete.dart';
import 'package:structure/viewModel/ui_update_view_model.dart';

class UIUpdate extends StatelessWidget {
  const UIUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    "${context.watch<UIUpdateViewModel>().dateList[context.watch<UIUpdateViewModel>().dateSelectedIdx]}∙${context.watch<UIUpdateViewModel>().sortList[context.watch<UIUpdateViewModel>().sortSelectedIdx]}"),
                const Icon(Icons.arrow_drop_up_outlined)
              ],
            ),
            Container(
              height: 500.h,
              decoration: const BoxDecoration(color: Colors.amber),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Text('조회 기간'),
                    ],
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  FilterRow(
                      filterList: context.watch<UIUpdateViewModel>().dateList,
                      onTap: (index) =>
                          context.read<UIUpdateViewModel>().onTapDate(index),
                      status: context.watch<UIUpdateViewModel>().dateStatus),
                  SizedBox(
                    height: 10.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 282.w,
                        height: 64.h,
                        decoration: const BoxDecoration(
                            color: Palette.disabledButtonColor),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      const Text('-'),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        width: 282.w,
                        height: 64.h,
                        decoration: const BoxDecoration(
                            color: Palette.disabledButtonColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  const Row(
                    children: [
                      Text('정렬'),
                    ],
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  FilterRow(
                      filterList: context.watch<UIUpdateViewModel>().sortList,
                      onTap: (index) =>
                          context.read<UIUpdateViewModel>().onTapSort(index),
                      status: context.watch<UIUpdateViewModel>().sortStatus),
                  SizedBox(
                    height: 30.w,
                  ),
                  MainButton(
                    text: '조회',
                    width: 640.w,
                    heigh: 72.h,
                    isWhite: false,
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

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.filterList,
    required this.onTap,
    required this.status,
  });

  final List<String> filterList;
  final Function? onTap;
  final List<bool> status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        filterList.length,
        (index) => InkWell(
          onTap: onTap != null ? () => onTap!(index) : null,
          child: Container(
            height: 48.h,
            margin: EdgeInsets.only(right: 10.w),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
                color: status[index]
                    ? Palette.mainButtonColor
                    : Palette.disabledButtonColor,
                borderRadius: BorderRadius.all(Radius.circular(50.sp))),
            child: Text(
              filterList[index],
              style: TextStyle(
                color: status[index] ? Colors.white : Palette.greyTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
