import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final List<String> label = ['관리번호', '등록자', '관리'];

List<DataColumn> getColumns() {
  List<DataColumn> dataColumn = [];
  for (var i in label) {
    if (i == '관리번호') {
      dataColumn.add(
        DataColumn(
          label: SizedBox(
            width: 155,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                i,
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (i == '관리') {
      dataColumn.add(DataColumn(
          label: SizedBox(
        width: 64,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            i,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
      )));
    } else {
      dataColumn.add(
        DataColumn(
          label: Text(
            i,
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ),
      );
    }
  }
  return dataColumn;
}

DateTime toDay = DateTime.now();
DateTime threeDaysAgo = toDay.subtract(Duration(days: 3));
DateTime monthsAgo = toDay.subtract(Duration(days: 30));
DateTime threeMonthsAgo = toDay.subtract(Duration(days: 30 * 3));

void sortUserData(List<String> source, bool sortDecending) {
  source.sort((a, b) {
    DateTime dateA = DateTime.parse(a.split(',')[2]);
    DateTime dateB = DateTime.parse(b.split(',')[2]);
    if (!sortDecending) {
      return dateA.compareTo(dateB);
    } else {
      return dateB.compareTo(dateA);
    }
  });
}

List<String> setDay(List<String> source, String option1) {
  if (option1 == '3일') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dateTimeString = parts[2];
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.isAfter(threeDaysAgo) && dateTime.isBefore(toDay);
    }).toList();
  } else if (option1 == '1개월') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dateTimeString = parts[2];
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.isAfter(monthsAgo) && dateTime.isBefore(toDay);
    }).toList();
  } else if (option1 == '3개월') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dateTimeString = parts[2];
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.isAfter(threeMonthsAgo) && dateTime.isBefore(toDay);
    }).toList();
  } else {}
  return source;
}

List<DataRow> getRows(List<String> userData, String text, Function data, bool sortDscending, String option) {
  data();
  List<String> source = userData;

  sortUserData(source, sortDscending);
  source = setDay(source, option);

  List<DataRow> dataRow = [];

  // 이 과정은 기존 source에 담긴 데이터를 textfield를 통해 입력받는 'text' 변수와 비교하게 된다.
  // source에 담긴 data 값을 text의 시작과 비교하고, controller를 통해 실시간적으로 정보를 교류하게 된다.
  // contains는 중간 아무 요소나 비교, startwith는 시작부터, endwith는 끝부터 비교하는 기능임을 기억해두자.
  List<String> filteredData = source.where((data) => data.contains(text)).toList();

  for (var i = 0; i < filteredData.length; i++) {
    var csvDataCells = filteredData[i].split(',');
    List<DataCell> cells = [];
    cells.add(
      DataCell(
        SizedBox(
          width: 292.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              csvDataCells[0],
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
    cells.add(
      DataCell(
        SizedBox(
          width: 72.w,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              csvDataCells[1],
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
    // if (csvDataCells[1] == '${widget.user.name}') {
    if (csvDataCells[1] == '전수현') {
      cells.add(
        DataCell(
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                )),
            child: Text(
              '수정',
            ),
          ),
        ),
      );
    } else {
      cells.add(DataCell.empty);
    }

    dataRow.add(DataRow(cells: cells));
  }
  return dataRow;
}

Widget getDataTable(List<String> userData, String text, Function data, bool sortDscending, String option1) {
  return DataTable(
    showBottomBorder: true,
    headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
    headingRowHeight: 40.0,
    columnSpacing: 40.0,
    columns: getColumns(),
    rows: getRows(userData, text, data, sortDscending, option1),
  );
}
