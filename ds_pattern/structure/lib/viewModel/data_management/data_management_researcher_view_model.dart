import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class DataManagementHomeResearcherViewModel with ChangeNotifier {
  MeatModel meatModel;
  DataManagementHomeResearcherViewModel(this.meatModel) {
    _initialize();
  }
  late BuildContext _context;
  List<Map<String, String>> numList = [];
  List<Map<String, String>> filteredList = [];

  String insertedText = '';

  bool isLoading = true;

  Future<void> _initialize() async {
    await _fetchData();
    isLoading = false;
    notifyListeners();
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
            String statusType = item["statusType"];
            String createdAt = item["createdAt"];

            Map<String, String> idStatusPair = {
              "id": id,
              "statusType": statusType,
              "createdAt": createdAt,
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
    _context.go('/home/data-manage-researcher/add');
  }
}
