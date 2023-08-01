import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/data_cell_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataTableListCard extends StatelessWidget {
  final List<String>? dataCells;
  final UserData? user;
  DataTableListCard({
    super.key,
    this.dataCells,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.w,
              ),
              SizedBox(
                width: 300.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    dataCells![2],
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 80.w,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    dataCells![1],
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Spacer(),
              DataCellIconButton(
                text: (dataCells![4] == '대기중')
                    ? '대기'
                    : (dataCells![4] == '승인')
                        ? '승인'
                        : (dataCells![4] == '반려')
                            ? '반려'
                            : '',
                onPress: () {},
                width: 165.w,
                height: 55.h,
                bgColor: Colors.grey[300],
                fgColor: Colors.black,
                icon: dataCells![4] == '승인'
                    ? Icons.check_circle_outline_rounded
                    : dataCells![4] == '반려'
                        ? Icons.close_rounded
                        : dataCells![4] == '대기중'
                            ? Icons.circle_outlined
                            : null,
              ),
            ],
          ),
          Container(margin: EdgeInsets.only(top: 18.h), height: 0, child: Divider()),
        ],
      ),
    );
  }
}
