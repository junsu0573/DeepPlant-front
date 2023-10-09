import 'package:flutter/material.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/user_model.dart';

class ManagementNormalViewModel with ChangeNotifier {
  UserModel userModel;
  ManagementNormalViewModel({required this.userModel});

  final TextEditingController controller = TextEditingController();
  String search = '';
  final FocusNode focusNode = FocusNode();

  DateTime selected = DateTime.now();
  DateTime focused = DateTime.now();

  // 필터의 요소들을 보관한다.
  List<bool>? selectionsDay = [true, false, false, false];
  List<bool>? selectionsSort = [true, false];

  // 필터의 텍스트를 보관한다. - 필터의 정의를 텍스트로 지정할 것임.
  String? textDay;
  String? textSort;
  String? startDay;
  String? endDay;

  // 가능성을 제어한다.
  bool isSelectedEnd = false; // 모든 작업이 완료됨을 알린다. - 특히 직접 설정 날짜가 입력됨을 알린다.
  bool isSelectedFilter = false;

  // 필터에 들어갈 위젯을 보관한다.
  List<Widget> widgetsDay = [
    Text('3일'),
    Text('1개월'),
    Text('3개월'),
    Text('직접설정'),
  ];
  List<Widget> widgetsSort = [
    Text('최신순'),
    Text('과거순'),
  ];

  DateTime? rangeStart;
  DateTime? rangeEnd;

  DateTime? toDay;
  DateTime? threeDaysAgo;
  DateTime? monthsAgo;
  DateTime? threeMonthsAgo;

  Future<List<String>> initialize() async {
    final data = await RemoteDataSource.getMyData(userModel.userId!);
    List<String> extracted = data.map<String>((item) {
      String id = item['id'];
      String createdAt = item['createdAt'];
      createdAt = createdAt.replaceFirst('T', ' ');
      String name = '${userModel.name}';
      String statusType = item['statusType'];
      return '$createdAt,$name,$id, ,$statusType';
    }).toList();
    notifyListeners();
    return extracted;
  }

  void manageDataState() {
    controller.addListener(() {
      search = controller.text;
    });
    notifyListeners();
  }

  void textClear() {
    controller.clear();
    search = '';
    notifyListeners();
  }

  void setTime() {
    toDay = DateTime.now();
    threeDaysAgo = toDay!.subtract(Duration(days: 3));
    monthsAgo = toDay!.subtract(Duration(days: 30));
    threeMonthsAgo = toDay!.subtract(Duration(days: 30 * 3));
    notifyListeners();
  }

  void sortUserData(List<String> source) {
    source.sort((a, b) {
      DateTime dateA = DateTime.parse(a.split(',')[0]);
      DateTime dateB = DateTime.parse(b.split(',')[0]);
      if (textSort == '과거순') {
        return dateA.compareTo(dateB);
      } else {
        return dateB.compareTo(dateA);
      }
    });
    notifyListeners();
  }

  List<String> setDay(List<String> source) {
    if (textDay == '3일') {
      print('3일');
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(threeDaysAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (textDay == '1개월') {
      print('1개월');
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(monthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (textDay == '3개월') {
      print('3개월');
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(threeMonthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else {
      print('기타');
      source = source.where((data) {
        List<String> parts = data.split(',');
        String dateTimeString = parts[0];
        DateTime dateTime = DateTime.parse(dateTimeString);
        return dateTime.isAfter(rangeStart!) && dateTime.isBefore(rangeEnd!);
      }).toList();
    }
    notifyListeners();
    return source;
  }
}
