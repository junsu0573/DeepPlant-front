import 'package:intl/intl.dart';

class GetDate {
  // 현재 날짜
  static String getCurrentDate() {
    DateTime now = DateTime.now();
    String createdAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(now);
    return createdAt;
  }
}
