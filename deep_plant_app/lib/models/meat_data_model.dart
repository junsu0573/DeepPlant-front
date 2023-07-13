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

  Map<String, dynamic>? freshmeat;

  // 연구 데이터 추가 입력 완료 시 저장
  List<String>? deepAging;
  Map<String, dynamic>? heatedmeat;
  Map<String, dynamic>? tongueData;
  Map<String, dynamic>? labData;

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
    this.imagePath,
    this.freshmeat,

    // 연구 데이터 추가 입력 완료 시 저장
    this.deepAging,
    this.heatedmeat,
    this.tongueData,
    this.labData,
  });

  // 저장된 기본 데이터를 json 형식으로 변환
  Map<String, dynamic> convertBasicToJson() {
    return {
      'id': id,
      'userId': userId,
      'createdAt': createdAt,
      'traceNum': traceNum,
      'farmAddr': farmAddr,
      'farmerNm': farmerNm,
      'butcheryYmd': butcheryYmd,
      'birthYmd': birthYmd,
      'sexType': sexType,
      'speciesValue': speciesValue,
      'primalValue': primalValue,
      'secondaryValue': secondaryValue,
      'freshmeat': freshmeat,
    };
  }

  // 저장된 추가 데이터를 json 형식으로 변환
  Map<String, dynamic> convertAdditionToJson() {
    return {
      'deepAging': deepAging,
      'freshmeat': freshmeat,
      'heatedmeat': heatedmeat,
      'probexpt': _getProbexptJson(),
    };
  }

  Map<String, dynamic>? _getProbexptJson() {
    Map<String, dynamic> probexpt = {};

    if (tongueData != null && labData != null) {
      DateTime now = DateTime.now();

      probexpt['sourness'] = tongueData!['sourness'];
      probexpt['bitterness'] = tongueData!['bitterness'];
      probexpt['umami'] = tongueData!['umami'];
      probexpt['richness'] = tongueData!['richness'];
      probexpt['L'] = labData!['L'];
      probexpt['a'] = labData!['a'];
      probexpt['b'] = labData!['b'];
      probexpt['DL'] = labData!['DL'];
      probexpt['CL'] = labData!['CL'];
      probexpt['RW'] = labData!['RW'];
      probexpt['ph'] = labData!['ph'];
      probexpt['WBSF'] = labData!['WBSF'];
      probexpt['cardepsin_activity'] = labData!['cardepsin_activity'];
      probexpt['MFI'] = labData!['MFI'];
      probexpt['Collagen'] = labData!['Collagen'];
    }

    return null;
  }
}
