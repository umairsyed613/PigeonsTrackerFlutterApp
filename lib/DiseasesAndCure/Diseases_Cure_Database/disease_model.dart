class DiseaseModel {
  int? id;
  String diseaseName;
  String cure;

  DiseaseModel({this.id, required this.diseaseName, required this.cure});

  factory DiseaseModel.fromMap(Map<String, dynamic> map) {
    return DiseaseModel(
      id: map['id'],
      diseaseName: map['disease_name'],
      cure: map['cure'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'disease_name': diseaseName,
      'cure': cure,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
