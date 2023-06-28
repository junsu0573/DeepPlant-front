import 'dart:io';

class MeatData {
  String? historyNumber;
  String? species;
  String? lDivision;
  String? sDivision;
  File? imageFile;
  String? date;
  Map<String, double>? freshData;

  MeatData({
    this.historyNumber,
    this.species,
    this.lDivision,
    this.sDivision,
    this.imageFile,
    this.date,
    this.freshData,
  });
}
