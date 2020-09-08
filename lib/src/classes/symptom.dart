class Symptom {
  int id;
  String name;
  int idDisease;

  Symptom({this.id, this.name, this.idDisease});

  factory Symptom.fromJson(Map<String, dynamic> json) {
    return Symptom(
        id: json['id'], name: json['name'], idDisease: json['idDisease']);
  }
}
