import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';
import 'package:structure/screen/data_management/add_deep_aging_data_screen.dart';
import 'package:structure/viewModel/data_management/researcher/add_deep_aging_data_view_model.dart';

class DataAddHomeViewModel with ChangeNotifier {
  MeatModel meatModel;
  DataAddHomeViewModel(this.meatModel) {
    initialize();
  }

  bool isLoading = false;

  String userId = '-';
  String butcheryDate = '-';
  String species = '-';
  String secondary = '-';

  String total = '-';

  void initialize() {
    userId = meatModel.createUser ?? '-';
    butcheryDate = meatModel.butcheryYmd ?? '-';
    species = meatModel.speciesValue ?? '-';
    secondary = meatModel.secondaryValue ?? '-';
    _setTotal();
  }

  Future<void> deleteList(int idx) async {
    isLoading = true;
    notifyListeners();
    try {
      dynamic response =
          await RemoteDataSource.deleteDeepAging(meatModel.id!, idx);
      if (response == null) {
        throw Error();
      } else {
        meatModel.deepAgingData!.removeLast();
      }
    } catch (e) {
      print("에러발생: $e");
    }
    _setTotal();
    isLoading = false;
    notifyListeners();
  }

  void addDeepAgingData(BuildContext context) {
    isLoading = true;
    notifyListeners();

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) =>
                AddDeepAgingDataViewModel(meatModel: meatModel),
            child: const AddDeepAgingDataScreen(),
          ),
        )).then((value) async {
      _setTotal();
      dynamic response = await RemoteDataSource.getMeatData(meatModel.id!);
      if (response == null) throw Error();
      meatModel.reset();
      meatModel.fromJson(response);
      isLoading = false;
      notifyListeners();
    });
  }

  void _setTotal() {
    int totalMinutes = meatModel.deepAgingData!
        .map((item) => item['minute'] as int)
        .fold(0, (sum, minute) => sum + minute);

    total = '${meatModel.deepAgingData!.length}회 / $totalMinutes분';
  }

  void clickedRawMeat(BuildContext context) {
    meatModel.fromJsonAdditional('RAW');
    meatModel.seqno = 0;
    context.go('/home/data-manage-researcher/add/raw-meat');
  }

  late BuildContext _context;
  Future<void> clickedProcessedMeat(int idx, BuildContext context) async {
    dynamic response = await RemoteDataSource.getMeatData(meatModel.id!);
    if (response == null) throw Error();
    meatModel.reset();
    meatModel.fromJson(response);
    meatModel.fromJsonAdditional(meatModel.deepAgingData![idx]["deepAgingNum"]);
    meatModel.seqno = idx + 1;
    _context = context;
    _movePage();
  }

  void _movePage() {
    _context.go('/home/data-manage-researcher/add/processed-meat');
  }
}
