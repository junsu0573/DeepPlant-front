import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class HeatedMeatEvalViewModel with ChangeNotifier {
  MeatModel meatModel;
  HeatedMeatEvalViewModel(this.meatModel) {
    _initialize();
  }
  bool isLoading = false;

  double flavor = 0;
  double juiciness = 0;
  double tenderness = 0;
  double umami = 0;
  double palatability = 0;

  void _initialize() {
    flavor = meatModel.heatedmeat?["flavor"] ?? 0;
    juiciness = meatModel.heatedmeat?["juiciness"] ?? 0;
    tenderness = meatModel.heatedmeat?["tenderness"] ?? 0;
    umami = meatModel.heatedmeat?["umami"] ?? 0;
    palatability = meatModel.heatedmeat?["palability"] ?? 0;
  }

  void onChangedFlavor(dynamic value) {
    flavor = double.parse(value.toStringAsFixed(1));
    notifyListeners();
  }

  void onChangedJuiciness(dynamic value) {
    juiciness = double.parse(value.toStringAsFixed(1));
    notifyListeners();
  }

  void onChangedTenderness(dynamic value) {
    tenderness = double.parse(value.toStringAsFixed(1));
    notifyListeners();
  }

  void onChangedUmami(dynamic value) {
    umami = double.parse(value.toStringAsFixed(1));
    notifyListeners();
  }

  void onChangedPalatability(dynamic value) {
    palatability = double.parse(value.toStringAsFixed(1));
    notifyListeners();
  }

  late BuildContext _context;
  Future<void> saveData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    meatModel.heatedmeat ??= {};
    meatModel.heatedmeat!['flavor'] = flavor;
    meatModel.heatedmeat!['juiciness'] = juiciness;
    meatModel.heatedmeat!['tenderness'] = tenderness;
    meatModel.heatedmeat!['umami'] = umami;
    meatModel.heatedmeat!['palability'] = palatability;

    try {
      dynamic response = await RemoteDataSource.sendMeatData(
          'heatedmeat_eval', meatModel.toJsonHeated());
      if (response == null) {
        throw Error();
      } else {
        _context = context;
        _movePage();
      }
    } catch (e) {
      print("에러발생: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void _movePage() {
    if (meatModel.seqno == 0) {
      // 원육
      _context.go('/home/data-manage-researcher/add/raw-meat');
    } else {
      // 처리육
      _context.go('/home/data-manage-researcher/add/processed-meat');
    }
  }
}
