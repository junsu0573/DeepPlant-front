import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:structure/config/userfuls.dart';
import 'package:structure/dataSource/remote_data_source.dart';
import 'package:structure/model/meat_model.dart';

class FreshMeatEvalViewModel with ChangeNotifier {
  MeatModel meatModel;

  FreshMeatEvalViewModel(this.meatModel) {
    _initialize();
  }
  String title = '';
  String meatImage = '';

  double marbling = 0;
  double color = 0;
  double texture = 0;
  double surface = 0;
  double overall = 0;

  bool completed = false;

  void _initialize() {
    if (meatModel.seqno == 0) {
      // 원육
      title = '신선육관능평가';
      meatImage = meatModel.imagePath!;
      marbling = meatModel.freshmeat?["marbling"] ?? 0;
      color = meatModel.freshmeat?["color"] ?? 0;
      texture = meatModel.freshmeat?['texture'] ?? 0;
      surface = meatModel.freshmeat?['surfaceMoisture'] ?? 0;
      overall = meatModel.freshmeat?['overall'] ?? 0;
    } else {
      // 처리육
      title = '처리육관능평가';
      meatImage = meatModel.deepAgedImage!;
      marbling = meatModel.deepAgedFreshmeat?["marbling"] ?? 0;
      color = meatModel.deepAgedFreshmeat?["color"] ?? 0;
      texture = meatModel.deepAgedFreshmeat?['texture'] ?? 0;
      surface = meatModel.deepAgedFreshmeat?['surfaceMoisture'] ?? 0;
      overall = meatModel.deepAgedFreshmeat?['overall'] ?? 0;
    }

    if (marbling != 0 &&
        color != 0 &&
        texture != 0 &&
        surface != 0 &&
        overall != 0) {
      completed = true;
    }
    notifyListeners();
  }

  void onChangedMarbling(double value) {
    marbling = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedColor(double value) {
    color = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedTexture(double value) {
    texture = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedSurface(double value) {
    surface = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void onChangedOverall(double value) {
    overall = double.parse(value.toStringAsFixed(1));
    _checkCompleted();
    notifyListeners();
  }

  void _checkCompleted() {
    if (marbling > 0 &&
        color > 0 &&
        texture > 0 &&
        surface > 0 &&
        overall > 0) {
      completed = true;
    } else {
      completed = false;
    }
  }

  late BuildContext _context;

  Future<void> saveMeatData(BuildContext context) async {
    try {
      if (meatModel.seqno == 0) {
        // 원육 - 등록, 수정
        meatModel.freshmeat ??= {};
        meatModel.freshmeat!['createdAt'] = Usefuls.getCurrentDate();
        meatModel.freshmeat!['period'] = Usefuls.getMeatPeriod(meatModel);
        meatModel.freshmeat!['marbling'] = marbling;
        meatModel.freshmeat!['color'] = color;
        meatModel.freshmeat!['texture'] = texture;
        meatModel.freshmeat!['surfaceMoisture'] = surface;
        meatModel.freshmeat!['overall'] = overall;

        if (meatModel.id != null) {
          // 수정
          await RemoteDataSource.sendMeatData(
              'sensory_eval', meatModel.toJsonFresh(null));
        }
      } else {
        // 처리육
        meatModel.deepAgedFreshmeat ??= {};
        meatModel.deepAgedFreshmeat!['createdAt'] = Usefuls.getCurrentDate();
        meatModel.deepAgedFreshmeat!['period'] =
            Usefuls.getMeatPeriod(meatModel);
        meatModel.deepAgedFreshmeat!['marbling'] = marbling;
        meatModel.deepAgedFreshmeat!['color'] = color;
        meatModel.deepAgedFreshmeat!['texture'] = texture;
        meatModel.deepAgedFreshmeat!['surfaceMoisture'] = surface;
        meatModel.deepAgedFreshmeat!['overall'] = overall;

        await RemoteDataSource.sendMeatData(
            'sensory_eval',
            meatModel.toJsonFresh({
              "date": meatModel.deepAgingData![meatModel.seqno! - 1]["date"],
              "minute": meatModel.deepAgingData![meatModel.seqno! - 1]["minute"]
            }));
      }
      meatModel.checkCompleted();
      _context = context;
      _goNext();
    } catch (e) {
      print('에러발생: $e');
    }
  }

  void _goNext() {
    if (meatModel.seqno == 0) {
      // 원육
      if (meatModel.id == null) {
        // 등록
        _context.go('/home/registration');
      } else {
        // 수정
        _context.go('/home/data-manage-normal/edit');
      }
    } else {
      // 처리육
      _context.go('/home/data-manage-researcher/add/processed-meat');
    }
  }
}
