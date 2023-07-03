class UserModel {
  String? password; // 회원가입을 위해 사용

  String? lastLog; // 회원가입 시 최초 저장

  // 회원가입 시 firebase firestore에 저장하는 데이터
  bool? isAlarmed;
  String? email;
  String? name;
  String? userAddress;
  String? company;
  String? position;
  String? companyAdress;
  String? level; // 유저 라우팅을 위해 사용

  // 관리번호 업데이트 시 저장
  List<String>? revisionMeatList;

  UserModel({
    this.password, // 회원가입을 위해 사용
    this.level, // 유저 라우팅을 위해 사용
    this.lastLog, // 회원가입 시 최초 저장

    // 회원가입 시 firebase firestore에 저장하는 데이터
    bool? isAlarmed,
    this.email,
    this.name,
    this.userAddress,
    this.company,
    this.position,
    this.companyAdress,

    // 관리번호 업데이트 시 저장
    this.revisionMeatList,
  });
}
