import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:structure/dataSource/remote_data_source.dart';

class ManagementDataViewModel with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String search = '';

  // 필터의 요소들을 보관한다.
  List<bool>? selectionsDay;
  List<bool>? selectionsData;
  List<bool>? selectionsSpecies;

  // 필터의 텍스트를 보관한다. - 필터의 정의를 텍스트로 지정할 것임.
  String? textDay;
  String? textData;
  String? textSpecies;
  String? startDay;
  String? endDay;

  // 가능성을 제어한다.
  bool isSelectedEtc = false; // 직접 설정이 지정되었는지 파악한다. + 직접 설정 날짜가 입력 되었는지도 확인!

  // 필터에 들어갈 위젯을 보관한다.
  List<Widget> widgetsDay = [
    Text('3일'),
    Text('1개월'),
    Text('3개월'),
    Text('직접설정'),
  ];
  List<Widget> widgetsData = [
    Text('나의 데이터'),
    Text('일반 데이터'),
    Text('연구 데이터'),
    Text('전체'),
  ];
  List<Widget> widgetsSpecies = [
    Text('소'),
    Text('돼지'),
    Text('전체'),
  ];

  // 필터 기능을 위한 날짜 지정
  DateTime? toDay;
  DateTime? threeDaysAgo;
  DateTime? monthsAgo;
  DateTime? threeMonthsAgo;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  // 필터를 초기화 한다.
  void reset() {
    selectionsDay = [true, false, false, false];
    selectionsData = [true, false, false, false];
    selectionsSpecies = [false, false, true];
    textDay = '3일';
    textData = '나의 데이터';
    textSpecies = '전체';
    _rangeStart = null;
    _rangeEnd = null;
    notifyListeners();
  }

  void manageDataState() {
    controller.addListener(() {
      search = controller.text;
    });
    notifyListeners();
  }

  void setTime() {
    toDay = DateTime.now();
    threeDaysAgo = toDay!.subtract(Duration(days: 3));
    monthsAgo = toDay!.subtract(Duration(days: 30));
    threeMonthsAgo = toDay!.subtract(Duration(days: 30 * 3));

    if (textDay == '3일') {
      startDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(threeDaysAgo!);
      endDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(toDay!);
    } else if (textDay == '1개월') {
      startDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(monthsAgo!);
      endDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(toDay!);
    } else if (textDay == '3개월') {
      startDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(threeMonthsAgo!);
      endDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(toDay!);
    } else {
      startDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(_rangeStart!);
      endDay = DateFormat('yyyy-MM-ddTHH:mm:ss').format(_rangeEnd!);
    }
  }

  Future<List<String>> initialize(int count, String start, String end) async {
    List<String> temp;
    final data = await RemoteDataSource.getCreatedAtData(count, start, end);
    temp = extractedData(data['meat_dict']);
    notifyListeners();
    return temp;
  }

  List<String> extractedData(dynamic data) {
    List<String> extracted = [];

    data.forEach((key, item) {
      String createdAt = item['createdAt'];
      createdAt = createdAt.replaceFirst('T', ' ');
      String name = item['name'];
      String id = item['id'];
      String specieValue = item['specieValue'];
      String statusType = item['statusType'];
      String type = item['type'];
      String userId = item['userId'];
      extracted.add('$createdAt,$name,$id,$specieValue,$statusType,$type,$userId');
    });
    return extracted;
  }
}
