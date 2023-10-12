import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  bool isLoading = true;
  bool isOpnedFilter = false;

  String filterdResult = '3일∙최신순';

  List<String> dateList = ['3일', '1개월', '3개월', '직접입력'];
  List<bool> dateStatus = [true, false, false, false];
  int dateSelectedIdx = 0;

  List<String> sortList = ['최신순', '과거순'];
  List<bool> sortStatus = [true, false];
  int sortSelectedIdx = 0;

  void clickedFilter() {
    dateStatus = List.filled(dateStatus.length, false);
    dateStatus[dateSelectedIdx] = true;
    sortStatus = List.filled(sortStatus.length, false);
    sortStatus[sortSelectedIdx] = true;

    isOpnedFilter = !isOpnedFilter;
    notifyListeners();
  }

  void onTapDate(int index) {
    dateStatus = List.filled(dateStatus.length, false);
    dateStatus[index] = true;
    notifyListeners();
  }

  void onTapSort(int index) {
    sortStatus = List.filled(sortStatus.length, false);
    sortStatus[index] = true;
    notifyListeners();
  }

  // 필터 조회 버튼 클릭시
  void onPressedFilterSave() {
    dateSelectedIdx = dateStatus.indexWhere((element) => element == true);
    sortSelectedIdx = sortStatus.indexWhere((element) => element == true);
    filterdResult = '${dateList[dateSelectedIdx]}∙${sortList[sortSelectedIdx]}';
    isOpnedFilter = false;
    notifyListeners();
  }

  Future<void> _initialize() async {
    await _fetchData();
    isLoading = false;
    notifyListeners();
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

          Map<String, String> idStatusPair = {
            "id": id,
            "statusType": statusType,
            "createdAt": createdAt,
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
    filteredList = numList.where((map) {
      String id = map["id"] ?? "";
      return id.contains(insertedText);
    }).toList();
  }

  void _movePage() {
    _context.go('/home/data-manage-normal/edit');
  }
}
