import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:structure/components/custom_app_bar.dart';
import 'package:structure/viewModel/data_management/edit_meat_data_view_model.dart';

class EditMeatDataScreen extends StatelessWidget {
  const EditMeatDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: '${context.read<EditMeatDataViewModel>().meatModel.id}',
          backButton: true,
          closeButton: false),
      body: Center(
        child: Column(
          children: [
            StepCard2(
              onTap: () =>
                  context.read<EditMeatDataViewModel>().clicekdBasic(context),
              title: '육류 기본정보',
              icon: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.difference,
                ),
                child: Image.asset(
                  'assets/images/meat_add.png',
                  width: 62.w,
                ),
              ),
              isEditable: context.read<EditMeatDataViewModel>().isEditable,
            ),
            SizedBox(
              width: 640.w,
              child: const Divider(
                height: 0,
              ),
            ),
            StepCard2(
              onTap: () =>
                  context.read<EditMeatDataViewModel>().clickedImage(context),
              title: '육류 단면 촬영',
              icon: Icon(
                Icons.add_a_photo_rounded,
                size: 62.w,
              ),
              isEditable: context.read<EditMeatDataViewModel>().isEditable,
            ),
            SizedBox(
              width: 640.w,
              child: const Divider(
                height: 0,
              ),
            ),
            StepCard2(
              onTap: () =>
                  context.read<EditMeatDataViewModel>().clicekdFresh(context),
              title: '신선육 관능평가',
              icon: Icon(
                Icons.article_outlined,
                size: 62.w,
              ),
              isEditable: context.read<EditMeatDataViewModel>().isEditable,
            ),
          ],
        ),
      ),
    );
  }
}

class StepCard2 extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget icon;
  final bool isEditable;
  const StepCard2({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 640.w,
        height: 145.h,
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 30.w,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(isEditable ? '수정가능' : '수정불가'),
            SizedBox(
              width: 40.w,
            ),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
