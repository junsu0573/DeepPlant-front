import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:structure/components/get_qr.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/main.dart';
import 'package:structure/model/user_model.dart';

class DataManagementHomeViewModel with ChangeNotifier {
  UserModel userModel;
  DataManagementHomeViewModel(this.userModel) {
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

  String filterdResult = '3일∙최신순';

  List<String> dateList = ['3일', '1개월', '3개월', '직접입력'];
  List<bool> dateStatus = [true, false, false, false];
  int dateSelectedIdx = 0;

  List<String> sortList = ['최신순', '과거순'];
  List<bool> sortStatus = [true, false];
  int sortSelectedIdx = 0;

  // 조회 시간을 기준으로 날짜 필터링
  DateTime? toDay;
  DateTime? threeDaysAgo;
  DateTime? monthsAgo;
  DateTime? threeMonthsAgo;

  DateTime selected = DateTime.now();
  DateTime focused = DateTime.now();
  DateTime? firstDay;
  DateTime? lastDay;
  int indexDay = 0;

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

  void clickedFilter() {
    dateStatus = List.filled(dateStatus.length, false);
    dateStatus[dateSelectedIdx] = true;
    sortStatus = List.filled(sortStatus.length, false);
    sortStatus[sortSelectedIdx] = true;

    // 필터가 호출될 때, 변해야 하는 변수
    isOpnedFilter = !isOpnedFilter;
    if (isOpenTable) {
      isOpenTable = false;
    }
    notifyListeners();
  }

  void onTapDate(int index) {
    dateStatus = List.filled(dateStatus.length, false);
    dateStatus[index] = true;
    // 직접 설정이면 TableCalendar 호출
    if (index != 3) {
      isOpenTable = false;
    }
    notifyListeners();
  }

  void onTapSort(int index) {
    sortStatus = List.filled(sortStatus.length, false);
    sortStatus[index] = true;
    notifyListeners();
  }

  // TableCalendar 관련 함수
  void onTapTable(int index) {
    // 만일 날짜를 처음 지정할 시 기존 값을 초기화
    if (firstDay == null || lastDay == null) {
      selected = DateTime.now();
      focused = DateTime.now();
    }
    isOpenTable = !isOpenTable;
    indexDay = index;
    // 날짜 지정 이후 선택할 시 이전 날짜 호출
    if (index == 0 && firstDay != null) {
      selected = firstDay!;
      focused = firstDay!;
    } else if (index == 1 && lastDay != null) {
      selected = lastDay!;
      focused = lastDay!;
    }
    notifyListeners();
  }

  // TableCalendar 위젯에 사용될 날짜 변경 함수
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selected = selectedDay;
    focused = focusedDay;
    // 시작 | 종료 중 어느 지점이 변경될 지 지정
    if (indexDay == 0) {
      firstDay = selectedDay;
    } else {
      lastDay = focusedDay;
    }
    notifyListeners();
  }

  // 직접 설정 필터가 적용된 후, 날짜 선택이 완료 되었는지 판단
  bool checkedFilter() {
    if (dateStatus[3] == true && (firstDay == null || lastDay == null)) {
      return false;
    } else {
      return true;
    }
  }

  // 필터 조회 버튼 클릭시
  void onPressedFilterSave() {
    dateSelectedIdx = dateStatus.indexWhere((element) => element == true);
    sortSelectedIdx = sortStatus.indexWhere((element) => element == true);
    filterdResult = '${dateList[dateSelectedIdx]}∙${sortList[sortSelectedIdx]}';
    isOpnedFilter = false;
    isOpenTable = false;
    filterlize();
    notifyListeners();
  }

  Future<void> _initialize() async {
    await _fetchData();
    filterlize();
    isLoading = false;
    notifyListeners();
  }

  // 필터링 시 호출될 함수
  void filterlize() {
    setTime();
    sortUserData();
    setDay();
  }

  // 현재 필터링 시간을 기준으로 시간 지정
  void setTime() {
    toDay = DateTime.now();
    threeDaysAgo = toDay!.subtract(const Duration(days: 3));
    monthsAgo = toDay!.subtract(const Duration(days: 30));
    threeMonthsAgo = toDay!.subtract(const Duration(days: 30 * 3));
  }

  // 정렬 필터 입력에 따라 필터링
  void sortUserData() {
    numList.sort((a, b) {
      DateTime dateA = DateTime.parse(a["createdAt"]!);
      DateTime dateB = DateTime.parse(b["createdAt"]!);
      if (sortSelectedIdx == 1) {
        return dateA.compareTo(dateB);
      } else {
        return dateB.compareTo(dateA);
      }
    });
  }

  // 날짜 필터 입력에 따라 필터링
  void setDay() {
    selectedList = numList;
    if (dateSelectedIdx == 0) {
      print('3일');
      selectedList = selectedList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(threeDaysAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (dateSelectedIdx == 1) {
      print('1개월');
      selectedList = selectedList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(monthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else if (dateSelectedIdx == 2) {
      print('3개월');
      selectedList = selectedList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(threeMonthsAgo!) && dateTime.isBefore(toDay!);
      }).toList();
    } else {
      print('직접설정');
      selectedList = selectedList.where((data) {
        DateTime dateTime = DateTime.parse(data["createdAt"]!);
        return dateTime.isAfter(firstDay!) && dateTime.isBefore(lastDay!);
      }).toList();
    }
  }

  Future<void> _fetchData() async {
    try {
      // 자신이 입력한 데이터만 호출
      List<dynamic>? jsonData =
          await RemoteDataSource.getUserMeatData('?userId=${userModel.userId}');

      if (jsonData == null) {
        print('데이터 없음');
        throw Error();
      } else {
        // 각 사용자별로 데이터를 순회하며 id와 statusType 값을 추출하여 리스트에 추가
        for (var item in jsonData) {
          String id = item["id"];
          String statusType = item["statusType"];
          String createdAt = item["createdAt"];
          String dayTime =
              DateFormat('yyyy.MM.dd').format(DateTime.parse(createdAt));
          Map<String, String> idStatusPair = {
            "id": id,
            "statusType": statusType,
            "createdAt": createdAt,
            "dayTime": dayTime,
          };

          numList.add(idStatusPair);
        }
        selectedList = numList;
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

    selectedList = insertedText.isEmpty ? numList : filteredList;

    isLoading = false;
    notifyListeners();
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

    id = insertedText.isEmpty ? numList[idx]["id"]! : filteredList[idx]["id"]!;

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
    filteredList = selectedList.where((map) {
      String id = map["id"] ?? "";
      return id.contains(insertedText);
    }).toList();
  }

  void _movePage() {
    _context.go('/home/data-manage-normal/edit');
  }
}
