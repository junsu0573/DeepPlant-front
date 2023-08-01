import 'dart:convert';
import 'dart:io';

import 'package:deep_plant_app/models/data_management_filter_model.dart';
import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/data-management/data_confirm_page.dart';
import 'package:deep_plant_app/widgets/custom_appbar.dart';
import 'package:deep_plant_app/pages/data-management/data_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';

class DataManagement2 extends StatefulWidget {
  final UserData userData;
  final MeatData meatData;
  final FilterModel filter;
  const DataManagement2({
    super.key,
    required this.meatData,
    required this.userData,
    required this.filter,
  });

  @override
  State<DataManagement2> createState() => _DataManagement2State();
}

class _DataManagement2State extends State<DataManagement2> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Set<String> dataList = {};

  @override
  void initState() {
    super.initState();

    // 유저 아이디 저장
    if (widget.userData.userId != null) {
      widget.meatData.userId = widget.userData.userId;
    }
    _tabController = TabController(length: 2, vsync: this);
    widget.filter.resetCon();

    initialize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initialize() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${widget.userData.userId}-data-list.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);
      setState(() {
        dataList = data.whereType<String>().toSet();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backButton: false,
        closeButton: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab1의 내용
                    DataAdd(
                      userData: widget.userData,
                      meatData: widget.meatData,
                      dataList: dataList,
                    ),
                    // Tab2의 내용
                    DataConfirm(
                      userData: widget.userData,
                      filter: widget.filter,
                      meatData: widget.meatData,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 32.h,
        ),
        child: Stack(
          children: [
            Divider(
              height: 3.h,
              thickness: 3.sp,
              color: Color.fromRGBO(228, 228, 228, 1),
            ),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: '데이터 추가',
                ),
                Tab(
                  text: '데이터 확인',
                ),
              ],
              labelColor: Colors.black,
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(120, 120, 120, 1),
              ),
              indicator: ShapeDecoration(
                shape: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 3.0.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
