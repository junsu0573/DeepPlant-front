import 'package:deep_plant_app/models/meat_data_model.dart';
import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/pages/maet-registration/basic-data/show_step_page.dart';
import 'package:deep_plant_app/source/api_services.dart';
import 'package:deep_plant_app/widgets/data_table_list_card.dart';
import 'package:deep_plant_app/widgets/show_custom_popup.dart';
import 'package:flutter/material.dart';

class GetDataTable extends StatefulWidget {
  final List<String> userData;
  final String text;
  final Function data;
  final bool sortDscending;
  final String option1;
  final DateTime? start;
  final DateTime? end;
  final bool selectedEtc;
  final UserData user;
  final MeatData meat;
  GetDataTable({
    super.key,
    required this.userData,
    required this.text,
    required this.data,
    required this.sortDscending,
    required this.option1,
    this.start,
    this.end,
    required this.selectedEtc,
    required this.user,
    required this.meat,
  });

  @override
  State<GetDataTable> createState() => _GetDataTableState();
}

class _GetDataTableState extends State<GetDataTable> {
  final List<String> label = ['관리번호', '등록자', '관리'];

  DateTime? toDay;
  DateTime? threeDaysAgo;
  DateTime? monthsAgo;
  DateTime? threeMonthsAgo;

  void setTime() {
    toDay = DateTime.now();
    threeDaysAgo = toDay!.subtract(Duration(days: 3));
    monthsAgo = toDay!.subtract(Duration(days: 30));
    threeMonthsAgo = toDay!.subtract(Duration(days: 30 * 3));
  }

  void sortUserData(List<String> source, bool sortDecending) {
    source.sort((a, b) {
      DateTime dateA = DateTime.parse(a.split(',')[0]);
      DateTime dateB = DateTime.parse(b.split(',')[0]);
      if (!sortDecending) {
        return dateA.compareTo(dateB);
      } else {
        return dateB.compareTo(dateA);
      }
    });
  }

  List<String> setDay(List<String> source, String option1, DateTime? start, DateTime? end, bool selectedEtc) {
    if (option1 == '3일') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(threeDaysAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (option1 == '1개월') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(monthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (option1 == '3개월') {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(threeMonthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else {
      if (selectedEtc == true) {
        source = source.where((data) {
          List<String> parts = data.split(',');
          String dateTimeString = parts[0];
          DateTime dateTime = DateTime.parse(dateTimeString);
          return dateTime.isAfter(start!) && dateTime.isBefore(end!);
        }).toList();
      }
    }
    return source;
  }

  @override
  Widget build(BuildContext context) {
    setTime();
    widget.data();
    List<String> source = widget.userData;

    sortUserData(source, widget.sortDscending);
    source = setDay(source, widget.option1, widget.start, widget.end, widget.selectedEtc);

    // 이 과정은 기존 source에 담긴 데이터를 textfield를 통해 입력받는 'text' 변수와 비교하게 된다.
    // source에 담긴 data 값을 text의 시작과 비교하고, controller를 통해 실시간적으로 정보를 교류하게 된다.
    // contains는 중간 아무 요소나 비교, startwith는 시작부터, endwith는 끝부터 비교하는 기능임을 기억해두자.

    List<String> filteredData = source.where((data) => data.contains(widget.text)).toList();

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        var dataCells = filteredData[index].split(',');
        String time = dataCells[0];
        DateTime dTime = DateTime.parse(time);

        return InkWell(
          onTap: () async {
            if ((dTime.isAfter(threeDaysAgo!) && dTime.isBefore(toDay!)) && dataCells[4] == '대기중') {
              final data = await ApiServices.getMeatData(dataCells[2]);
              widget.meat.fetchData(data);
              if (!mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowStep(
                    userData: widget.user,
                    meatData: widget.meat,
                    isEdited: true,
                  ),
                ),
              );
            } else if ((dataCells[4] == '승인')) {
              showDataManageSucceedPopup(context);
            } else if ((dataCells[4] == '반려')) {
              showDataManageFailurePopup(context);
            } else {
              showDataManageLatePopup(context);
            }
          },
          child: DataTableListCard(
            dataCells: dataCells,
          ),
        );
      },
    );
  }
}
