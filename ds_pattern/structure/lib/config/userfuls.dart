import 'package:intl/intl.dart';
import 'package:structure/model/meat_model.dart';

class Usefuls {
  // 현재 날짜
  static String getCurrentDate() {
    DateTime now = DateTime.now();
    String createdAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);
    return createdAt;
  }

  // period
  static int getMeatPeriod(MeatModel meatModel) {
    if (meatModel.butcheryYmd == null) return 0;
    DateTime butcheryDate = DateTime.parse(meatModel.butcheryYmd!);
    DateTime currentDate = DateTime.now();

    Duration difference = currentDate.difference(butcheryDate);
    int period = difference.inHours;
    if (period < 0) {
      return 0;
    }
    return period;
  }

  static int calculateDateDifference(String targetDate) {
    // 현재 로컬 시간 구하기
    DateTime now = DateTime.now();
    DateTime targetDateTime = DateTime.parse(targetDate);

    // 두 날짜의 차이 계산
    Duration difference = now.difference(targetDateTime);

    // 일(day) 단위로 반환
    return difference.inDays;
  }

  // 날짜 파싱
  static String parseDate(String? inputDate) {
    if (inputDate == null) return '-';
    DateTime dateTime = DateTime.parse(inputDate);

    String formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";

    return formattedDate;
  }
}
