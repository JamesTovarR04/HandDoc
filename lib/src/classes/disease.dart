class Disease {
  int id;
  String name;
  int idUser;

  Disease({this.id, this.name, this.idUser});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(id: json['id'], name: json['name'], idUser: json['idUser']);
  }
}
