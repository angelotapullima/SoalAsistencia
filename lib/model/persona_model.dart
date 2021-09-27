class PersonaModel {
  int idPersona;
  String personName;
  String personSurname;
  String personSurname2;
  String personTipoDoc;
  String personNroDoc;

  PersonaModel(
      {this.idPersona,
      this.personName,
      this.personSurname,
      this.personSurname2,
      this.personTipoDoc,
      this.personNroDoc});

  factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
      personName: json["personName"],
      personSurname: json["personSurname"],
      personSurname2: json["personSurname2"],
      personTipoDoc: json["personTipoDoc"],
      personNroDoc: json["personNroDoc"]);
}
