import 'package:soal/model/persona_model.dart';

import 'database_provider.dart';

class PersonaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarPersona(PersonaModel persona) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Personas (personName,personSurname,personSurname2,personTipoDoc,personNroDoc)"
          "VALUES ('${persona.personName}','${persona.personSurname}','${persona.personSurname2}','${persona.personTipoDoc}','${persona.personNroDoc}')");
      print(res);
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<PersonaModel>> obtenerPersonasDni(
      String tipoDoc, String nroDoc) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery(
        "SELECT * FROM Personas where personTipoDoc = '$tipoDoc' and personNroDoc = '$nroDoc'");

    List<PersonaModel> list =
        res.isNotEmpty ? res.map((c) => PersonaModel.fromJson(c)).toList() : [];
    print(res);
    return list;
  }

  deletePersonas() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Personas');

    return res;
  }
}
