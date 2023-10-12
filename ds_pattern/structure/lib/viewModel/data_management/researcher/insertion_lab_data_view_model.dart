import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class InsertionLabDataViewModel with ChangeNotifier {
  MeatModel meatModel;
  InsertionLabDataViewModel(this.meatModel) {
    _initialize();
  }

  bool isLoading = false;

  TextEditingController l = TextEditingController();
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController dl = TextEditingController();
  TextEditingController cl = TextEditingController();
  TextEditingController rw = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController wbsf = TextEditingController();
  TextEditingController ct = TextEditingController();
  TextEditingController mfi = TextEditingController();
  TextEditingController collagen = TextEditingController();

  void _initialize() {
    l.text = meatModel.probexptData?["L"] == null
        ? ''
        : meatModel.probexptData!["L"].toString();
    a.text = meatModel.probexptData?["a"] == null
        ? ''
        : meatModel.probexptData!["a"].toString();
    b.text = meatModel.probexptData?["b"] == null
        ? ''
        : meatModel.probexptData!["b"].toString();
    dl.text = meatModel.probexptData?["DL"] == null
        ? ''
        : meatModel.probexptData!["DL"].toString();
    cl.text = meatModel.probexptData?["CL"] == null
        ? ''
        : meatModel.probexptData!["CL"].toString();
    rw.text = meatModel.probexptData?["RW"] == null
        ? ''
        : meatModel.probexptData!["RW"].toString();
    ph.text = meatModel.probexptData?["ph"] == null
        ? ''
        : meatModel.probexptData!["ph"].toString();
    wbsf.text = meatModel.probexptData?["WBSF"] == null
        ? ''
        : meatModel.probexptData!["WBSF"].toString();
    ct.text = meatModel.probexptData?["cardepsin_activity"] == null
        ? ''
        : meatModel.probexptData!["cardepsin_activity"].toString();
    mfi.text = meatModel.probexptData?["MFI"] == null
        ? ''
        : meatModel.probexptData!["MFI"].toString();
    collagen.text = meatModel.probexptData?["Collagen"] == null
        ? ''
        : meatModel.probexptData!["Collagen"].toString();
  }

  late BuildContext _context;
  Future<void> saveData(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    meatModel.probexptData ??= {};
    meatModel.probexptData!["L"] =
        l.text.isNotEmpty ? double.parse(l.text) : null;
    meatModel.probexptData!["a"] =
        a.text.isNotEmpty ? double.parse(a.text) : null;
    meatModel.probexptData!["b"] =
        b.text.isNotEmpty ? double.parse(b.text) : null;
    meatModel.probexptData!["DL"] =
        dl.text.isNotEmpty ? double.parse(dl.text) : null;
    meatModel.probexptData!["CL"] =
        cl.text.isNotEmpty ? double.parse(cl.text) : null;
    meatModel.probexptData!["RW"] =
        rw.text.isNotEmpty ? double.parse(rw.text) : null;
    meatModel.probexptData!["ph"] =
        ph.text.isNotEmpty ? double.parse(ph.text) : null;
    meatModel.probexptData!["WBSF"] =
        wbsf.text.isNotEmpty ? double.parse(wbsf.text) : null;
    meatModel.probexptData!["cardepsin_activity"] =
        ct.text.isNotEmpty ? double.parse(ct.text) : null;
    meatModel.probexptData!["MFI"] =
        mfi.text.isNotEmpty ? double.parse(mfi.text) : null;
    meatModel.probexptData!["Collagen"] =
        collagen.text.isNotEmpty ? double.parse(collagen.text) : null;
    // 완료 검사
    meatModel.checkCompleted();
    try {
      dynamic response = await RemoteDataSource.sendMeatData(
          'probexpt_data', meatModel.toJsonProbexpt());
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
