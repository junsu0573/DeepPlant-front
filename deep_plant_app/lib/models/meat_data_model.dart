class MeatData {
  String? imageFile;
  String? mNum;

  // 관리 번호 생성 시 firebase firestore 에 저장하는 데이터
  String? userEmail;
  String? saveTime;
  String? historyNumber;
  String? species;
  String? lDivision;
  String? sDivision;
  String? gradeNm;
  String? farmAddr;
  String? butcheryPlaceNm;
  String? butcheryYmd;
  Map<String, double>? freshData;

  // 연구 데이터 추가 입력 완료 시 firebase firestore에 저장하는 데이터
  List<String>? deepAging;
  Map<String, double>? heatedMeat;
  Map<String, double>? tongueData;
  Map<String, double>? labData;

  MeatData({
    this.imageFile,
    this.mNum,

    // 관리 번호 생성 시 firebase firestore 에 저장하는 데이터
    this.userEmail,
    this.saveTime,
    this.historyNumber,
    this.species,
    this.lDivision,
    this.sDivision,
    this.gradeNm,
    this.farmAddr,
    this.butcheryPlaceNm,
    this.butcheryYmd,
    this.freshData,

    // 연구 데이터 추가 입력 완료 시 firebase firestore에 저장하는 데이터
    this.deepAging,
    this.heatedMeat,
    this.tongueData,
    this.labData,
  });
}
