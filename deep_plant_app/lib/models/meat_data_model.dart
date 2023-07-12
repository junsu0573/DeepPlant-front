class MeatData {
  // 관리 번호 생성 시 저장
  String? id;
  String? userId;
  String? createdAt;
  String? traceNum;
  String? farmAddr;
  String? farmerNum;
  String? butcheryYmd;
  String? birthYmd;
  String? sexType;
  String? speciesValue;
  String? primalValue;
  String? secondaryValue;
  String? gradeNum;

  String? imageFile;

  Map<String, double>? freshmeat;

  // 연구 데이터 추가 입력 완료 시 저장
  List<String>? deepAging;
  List<Map<String, double>>? heatedMeat;
  List<Map<String, double>>? tongueData;
  List<Map<String, double>>? labData;

  MeatData({
    this.id,
    this.userId,
    this.createdAt,
    this.traceNum,
    this.farmAddr,
    this.farmerNum,
    this.butcheryYmd,
    this.birthYmd,
    this.sexType,
    this.speciesValue,
    this.primalValue,
    this.secondaryValue,
    this.gradeNum,
    this.imageFile,
    this.freshmeat,
    this.deepAging,
    this.heatedMeat,
    this.tongueData,
    this.labData,
  });
}
