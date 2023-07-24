import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/additional-data/data_add_home_page.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/call_mangement_dialog.dart';
import 'package:deep_plant_app/widgets/common_button.dart';
import 'package:deep_plant_app/widgets/m_num_data_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataAdd extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  const DataAdd({
    super.key,
    required this.userData,
    required this.meatData,
  });

  @override
  State<DataAdd> createState() => _DataAddState();
}

class _DataAddState extends State<DataAdd> {
  List<String> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '데이터 추가',
          style: TextStyle(
            fontSize: 36.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 21.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonButton(
              text: Text(
                '불러오기',
                style: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NumCallDialog(
                      data: dataList,
                    );
                  },
                ).then((value) {
                  setState(() {});
                });
              },
              width: 165.w,
              height: 63.h,
              bgColor: Colors.white,
              fgColor: Colors.black,
            ),
          ],
        ),
        SizedBox(
          height: 27.h,
        ),
        SizedBox(
          child: Divider(
            thickness: 6.sp,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  final data = await ApiServices.getMeatData(dataList[index]);
                  widget.meatData.fetchData(data);
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataAddHome(
                          meatData: widget.meatData, userData: widget.userData),
                    ),
                  );
                },
                child: MNumDataListCard(
                  idx: index + 1,
                  mNum: dataList[index],
                  noButton: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
