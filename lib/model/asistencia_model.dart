class AsistenciaModel {
  int idAsistencia;
  String tipoDoc;
  String nroDoc;
  String fecha;
  String hora;

  AsistenciaModel(
      {this.idAsistencia, this.tipoDoc, this.nroDoc, this.fecha, this.hora});

  factory AsistenciaModel.fromJson(Map<String, dynamic> json) =>
      AsistenciaModel(
          idAsistencia: json["idAsistencia"],
          tipoDoc: json["tipoDoc"],
          nroDoc: json["nroDoc"],
          fecha: json["fecha"],
          hora: json["hora"]);
}
