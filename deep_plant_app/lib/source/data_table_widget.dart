import 'package:deep_plant_app/models/user_data_model.dart';
import 'package:deep_plant_app/widgets/data_table_list_card.dart';
import 'package:flutter/material.dart';

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
    DateTime dateA = DateTime.parse(a.split(',')[2]);
    DateTime dateB = DateTime.parse(b.split(',')[2]);
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
      String dateTimeString = parts[2];
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.isAfter(threeDaysAgo!) && dateTime.isBefore(toDay!);
    }).toList();
  } else if (option1 == '1개월') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dateTimeString = parts[2];
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.isAfter(monthsAgo!) && dateTime.isBefore(toDay!);
    }).toList();
  } else if (option1 == '3개월') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dateTimeString = parts[2];
      DateTime dateTime = DateTime.parse(dateTimeString);
      return dateTime.isAfter(threeMonthsAgo!) && dateTime.isBefore(toDay!);
    }).toList();
  } else {
    if (selectedEtc == true) {
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[2];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(start!) && dateTime.isBefore(end!);
      }).toList();
    }
  }
  return source;
}

List<String> setType(List<String> source, String option3) {
  if (option3 == '소') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dataUser = parts[4];
      return (dataUser == '소');
    }).toList();
  } else if (option3 == '돼지') {
    source = source.where((data) {
      List<String> parts = data.split(',');
      String dataUser = parts[4];
      return (dataUser == '돼지');
    }).toList();
  } else {}
  return source;
}

Widget getDataTable(
    List<String> userData, String text, Function data, bool sortDscending, String option1, DateTime? start, DateTime? end, bool selectedEtc, UserData user) {
  setTime();
  data();
  List<String> source = userData;

  sortUserData(source, sortDscending);
  source = setDay(source, option1, start, end, selectedEtc);

  // 이 과정은 기존 source에 담긴 데이터를 textfield를 통해 입력받는 'text' 변수와 비교하게 된다.
  // source에 담긴 data 값을 text의 시작과 비교하고, controller를 통해 실시간적으로 정보를 교류하게 된다.
  // contains는 중간 아무 요소나 비교, startwith는 시작부터, endwith는 끝부터 비교하는 기능임을 기억해두자.
  List<String> filteredData = source.where((data) => data.contains(text)).toList();

  return ListView.builder(
    itemCount: filteredData.length,
    itemBuilder: (context, index) {
      var dataCells = filteredData[index].split(',');
      return DataTableListCard(
        dataCells: dataCells,
        toDay: toDay,
        threeDaysAgo: threeDaysAgo,
      );
    },
  );
}

Widget getConfirmTable(
    List<String> userData, String text, Function data, String option1, String option3, DateTime? start, DateTime? end, bool selectedEtc, UserData user) {
  setTime();
  data();
  List<String> source = userData;

  source = setDay(source, option1, start, end, selectedEtc);
  source = setType(source, option3);

  // 이 과정은 기존 source에 담긴 데이터를 textfield를 통해 입력받는 'text' 변수와 비교하게 된다.
  // source에 담긴 data 값을 text의 시작과 비교하고, controller를 통해 실시간적으로 정보를 교류하게 된다.
  // contains는 중간 아무 요소나 비교, startwith는 시작부터, endwith는 끝부터 비교하는 기능임을 기억해두자.
  List<String> filteredData = source.where((data) => data.contains(text)).toList();

  return ListView.builder(
    itemCount: filteredData.length,
    itemBuilder: (context, index) {
      var dataCells = filteredData[index].split(',');
      return DataTableListCard(
        dataCells: dataCells,
        toDay: toDay,
        threeDaysAgo: threeDaysAgo,
      );
    },
  );
}
