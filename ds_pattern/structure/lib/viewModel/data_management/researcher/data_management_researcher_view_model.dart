import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:structure/components/get_qr.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/model/user_model.dart';

class DataManagementHomeResearcherViewModel with ChangeNotifier {
  MeatModel meatModel;
  UserModel userModel;
  DataManagementHomeResearcherViewModel(this.meatModel, this.userModel) {
    _initialize();
  }
  late BuildContext _context;
  // 초기 리스트
  List<Map<String, String>> numList = [];

  // 필터링된 리스트
  List<Map<String, String>> filteredList = [];

  // 선택된 리스트
  List<Map<String, String>> selectedList = [];

  String insertedText = '';
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  bool isLoading = true;
  bool isOpnedFilter = false;
  bool isOpenTable = false;
  bool isChecked = false;

  String filterdResult = '3일∙전체∙전체';

  List<String> dateList = ['3일', '1개월', '3개월', '직접입력'];
  List<bool> dateStatus = [true, false, false, false];
  int dateSelectedIdx = 0;

  List<String> dataList = ['나의 데이터', '전체'];
  List<bool> dataStatus = [false, true];
  int dataSelectedIdx = 1;

  List<String> speciesList = ['소', '돼지', '전체'];
  List<bool> speciesStatus = [false, false, true];
  int speciesSelectedIdx = 2;

  // 조회 시간을 기준으로 날짜 필터링
  DateTime? toDay;
  DateTime? threeDaysAgo;
  DateTime? monthsAgo;
  DateTime? threeMonthsAgo;

  DateTime focused = DateTime.now();
  DateTime? temp1;
  DateTime? temp2;
  DateTime? firstDay;
  DateTime? lastDay;
  String firstDayText = '';
  String lastDayText = '';
  int indexDay = 0;

  Future<void> _initialize() async {
    await _fetchData();
    filterlize();
    print(filteredList);
    isLoading = false;
    notifyListeners();
  }

  void clickedFilter() {
    dateStatus = List.filled(dateStatus.length, false);
    dateStatus[dateSelectedIdx] = true;
    dataStatus = List.filled(dataStatus.length, false);
    dataStatus[dataSelectedIdx] = true;
    speciesStatus = List.filled(speciesStatus.length, false);
    speciesStatus[speciesSelectedIdx] = true;

    // 필터가 호출될 때, 변해야 하는 변수
    if (dateSelectedIdx != 3) {
      firstDayText = '';
      lastDayText = '';
    } else {
      formatting();
      temp1 = firstDay;
      temp2 = lastDay;
    }

    if (firstDay == null || lastDay == null) {
      temp1 = null;
      temp2 = null;
    }
    isOpnedFilter = !isOpnedFilter;
    if (isOpenTable) {
      isOpenTable = false;
    }
    notifyListeners();
  }

  // 필터링 시 호출될 함수
  void filterlize() {
    setTime();
    setDay();
    sortUserData();
    setData();
    setSpecies();
  }

  // 정렬 필터 입력에 따라 필터링
  void sortUserData() {
    filteredList.sort((a, b) {
      DateTime dateA = DateTime.parse(a["createdAt"]!);
      DateTime dateB = DateTime.parse(b["createdAt"]!);
      return dateB.compareTo(dateA);
    });
    selectedList = filteredList;
  }

  void setData() {
    if (dataSelectedIdx == 0) {
      filteredList = filteredList.where((data) {
        return (data["userId"] == userModel.userId);
      }).toList();
    } else {}
  }

  void setSpecies() {
    if (speciesSelectedIdx == 0) {
      filteredList = filteredList.where((data) {
        return (data['specieValue'] == '소');
      }).toList();
    } else if (speciesSelectedIdx == 1) {
      filteredList = filteredList.where((data) {
        return (data['specieValue'] == '돼지');
      }).toList();
    } else {}

    selectedList = filteredList;
  }

  // 필터 조회 버튼 클릭시
  void onPressedFilterSave() {
    dateSelectedIdx = dateStatus.indexWhere((element) => element == true);
    dataSelectedIdx = dataStatus.indexWhere((element) => element == true);
    speciesSelectedIdx = speciesStatus.indexWhere((element) => element == true);
    filterdResult =
        '${dateList[dateSelectedIdx]}∙${dataList[dataSelectedIdx]}∙${speciesList[speciesSelectedIdx]}';
    isOpnedFilter = false;
    isOpenTable = false;
    dateSwap();
    firstDay = temp1;
    lastDay = temp2;
    formatting();
    filterlize();
    notifyListeners();
  }

  // 직접 설정 필터가 적용된 후, 날짜 선택이 완료 되었는지 판단
  bool checkedFilter() {
    if (dateStatus[3] == true && (temp1 == null || temp2 == null)) {
      return false;
    } else {
      return true;
    }
  }

  void formatting() {
    if (firstDay != null) {
      firstDayText = DateFormat('yyyy.MM.dd').format(firstDay!);
    }
    if (lastDay != null) {
      lastDayText = DateFormat('yyyy.MM.dd').format(lastDay!);
    }
  }

  void dateSwap() {
    if (temp1 != null && temp2 != null) {
      bool isA = temp1!.isAfter(temp2!);
      if (isA == true) {
        DateTime dtemp = temp1!;
        temp1 = temp2;
        temp2 = dtemp;
        String ttemp = firstDayText;
        firstDayText = lastDayText;
        lastDayText = ttemp;
      }
    }
  }

  void onTapDate(int index) {
    dateStatus = List.filled(dateStatus.length, false);
    dateStatus[index] = true;
    // 직접 설정이면 TableCalendar 호출
    if (index != 3) {
      isOpenTable = false;
      firstDayText = '';
      lastDayText = '';
    } else {
      formatting();
    }

    if (firstDay == null || lastDay == null) {
      temp1 = null;
      temp2 = null;
    }

    notifyListeners();
  }

  void onTapData(int index) {
    dataStatus = List.filled(dataStatus.length, false);
    dataStatus[index] = true;
    notifyListeners();
  }

  void onTapSpecies(int index) {
    speciesStatus = List.filled(speciesStatus.length, false);
    speciesStatus[index] = true;
    notifyListeners();
  }

  // TableCalendar 관련 함수
  void onTapTable(int index) {
    // 만일 날짜를 처음 지정할 시 기존 값을 초기화
    if (firstDay == null || lastDay == null) {
      focused = DateTime.now();
    }
    isOpenTable = !isOpenTable;
    indexDay = index;
    // 날짜 지정 이후 선택할 시 이전 날짜 호출
    if (index == 0 && temp1 != null) {
      focused = temp1!;
    } else if (index == 1 && temp2 != null) {
      focused = temp2!;
    }
    dateSwap();
    notifyListeners();
  }

  // TableCalendar 위젯에 사용될 날짜 변경 함수
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    focused = selectedDay;
    // 시작 | 종료 중 어느 지점이 변경될 지 지정
    if (indexDay == 0) {
      temp1 = selectedDay;
      firstDayText = DateFormat('yyyy.MM.dd').format(temp1!);
    } else {
      temp2 = selectedDay;
      lastDayText = DateFormat('yyyy.MM.dd').format(temp2!);
    }
    notifyListeners();
  }

  // 현재 필터링 시간을 기준으로 시간 지정
  void setTime() {
    toDay = DateTime.now();
    threeDaysAgo =
        DateTime(toDay!.year, toDay!.month, toDay!.day - 3, 0, 0, 0, 0);
    monthsAgo = DateTime(toDay!.year, toDay!.month - 1, toDay!.day, 0, 0, 0, 0);
    threeMonthsAgo =
        DateTime(toDay!.year, toDay!.month - 3, toDay!.day, 0, 0, 0, 0);
  }

  // 날짜 필터 입력에 따라 필터링
  void setDay() {
    filteredList = numList;
    if (dateSelectedIdx == 0) {
      print('3일');
      filteredList = filteredList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(threeDaysAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (dateSelectedIdx == 1) {
      print('1개월');
      filteredList = filteredList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(monthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (dateSelectedIdx == 2) {
      print('3개월');
      filteredList = filteredList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(threeMonthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else {
      print('직접설정');
      filteredList = filteredList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(DateTime(
                firstDay!.year, firstDay!.month, firstDay!.day, 0, 0, 0, 0)) &&
            dateTime.isBefore(DateTime(
                lastDay!.year, lastDay!.month, lastDay!.day + 1, 0, 0, 0, 0));
      }).toList();
    }
  }

  Future<void> _fetchData() async {
    try {
      // 자신이 입력한 데이터만 호출
      Map<String, dynamic>? jsonData =
          await RemoteDataSource.getConfirmedMeatData();

      if (jsonData == null) {
        print('데이터 없음');
        throw Error();
      } else {
        // 각 사용자별로 데이터를 순회하며 id와 statusType 값을 추출하여 리스트에 추가
        jsonData.forEach((key, value) {
          for (var item in value) {
            String id = item["id"];
            String createdAt = item["createdAt"];
            String userId = item["userId"];
            String dayTime =
                DateFormat('yyyy.MM.dd').format(DateTime.parse(createdAt));
            String specieValue = item['specieValue'];
            Map<String, String> idStatusPair = {
              "id": id,
              "createdAt": createdAt,
              "userId": userId,
              "dayTime": dayTime,
              "specieValue": specieValue,
            };

            numList.add(idStatusPair);
          }
        });
      }
    } catch (e) {
      print("에러발생: $e");
    }
  }

  void onChanged(String? value) {
    isLoading = true;
    notifyListeners();

    insertedText = value ?? '';
    _filterStrings();

    isLoading = false;
    notifyListeners();
  }

  Future<void> clickedQr(BuildContext context) async {
    final response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GetQr(),
      ),
    );
    if (response != null) {
      controller.text = response;
      insertedText = response;
      _filterStrings();
      notifyListeners();
    }
  }

  // 버튼을 눌러 텍스트 입력을 초기화
  void textClear(BuildContext context) {
    FocusScope.of(context).unfocus();
    controller.clear();
    onChanged(null);
  }

  // 관리번호 클릭 시
  Future<void> onTap(int idx, BuildContext context) async {
    String id = '';

    id = selectedList[idx]['id']!;

    try {
      isLoading = true;
      notifyListeners();

      dynamic response = await RemoteDataSource.getMeatData(id);
      if (response == null) throw Error();
      meatModel.reset();
      meatModel.fromJson(response);
      meatModel.seqno = 0;
      print(meatModel);
      _context = context;
      _movePage();
    } catch (e) {
      print("에러발생: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  void _filterStrings() {
    // 검색어를 포함하는 문자열을 반환
    selectedList = filteredList.where((map) {
      String id = map["id"] ?? "";
      return id.contains(insertedText);
    }).toList();
  }

  void _movePage() {
    _context.go('/home/data-manage-researcher/add');
  }
}
