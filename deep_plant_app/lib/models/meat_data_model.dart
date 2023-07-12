class MeatData {
  // 관리 번호 생성 시 저장
  String? id;
  String? userId;
  String? createdAt;

  // 육류 오픈 API 데이터
  String? traceNum;
  String? farmAddr;
  String? farmerNm;
  String? butcheryYmd;
  String? birthYmd;
  String? sexType;
  String? lsType;
  String? gradeNum;

  // 육류 추가 정보
  String? speciesValue;
  String? primalValue;
  String? secondaryValue;

  // 육류 이미지 경로
  String? imagePath;

  Map<String, double>? freshmeat;

  // 연구 데이터 추가 입력 완료 시 저장
  List<String>? deepAging;
  List<Map<String, double>>? heatedMeat;
  List<Map<String, double>>? tongueData;
  List<Map<String, double>>? labData;

  MeatData({
    // 관리 번호 생성 시 저장
    this.id,
    this.userId,
    this.createdAt,
    this.traceNum,
    this.farmAddr,
    this.farmerNm,
    this.butcheryYmd,
    this.birthYmd,
    this.sexType,
    this.lsType,
    this.gradeNum,
    this.speciesValue,
    this.primalValue,
    this.secondaryValue,
    this.imageFile,
    this.freshmeat,

    // 연구 데이터 추가 입력 완료 시 저장
    this.deepAging,
    this.heatedMeat,
    this.tongueData,
    this.labData,
  });
}
