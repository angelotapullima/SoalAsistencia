import 'database_provider.dart';
import 'package:soal/model/asistencia_model.dart';

class AsistenciaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarAsistencia(AsistenciaModel asistencia) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Asistencia (tipoDoc,nroDoc,fecha,hora) "
          "VALUES ('${asistencia.tipoDoc}','${asistencia.nroDoc}','${asistencia.fecha}','${asistencia.hora}')");
      print(res);
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<AsistenciaModel>> obtenerAsistencias() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Asistencia");

    List<AsistenciaModel> list = res.isNotEmpty
        ? res.map((c) => AsistenciaModel.fromJson(c)).toList()
        : [];
    print(res);
    return list;
  }

  Future<List<AsistenciaModel>> obtenerAsistenciasFecha() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Asistencia group by fecha");
    //AND idMesa!='0'

    List<AsistenciaModel> list = res.isNotEmpty
        ? res.map((c) => AsistenciaModel.fromJson(c)).toList()
        : [];
    print(res);
    return list;
  }

  Future<List<AsistenciaModel>> obtenerAsistenciasFechaPersonas(
      String fecha) async {
    final db = await dbprovider.database;
    final res =
        await db.rawQuery("SELECT * FROM Asistencia where fecha = '$fecha' ");

    List<AsistenciaModel> list = res.isNotEmpty
        ? res.map((c) => AsistenciaModel.fromJson(c)).toList()
        : [];
    print(res);
    return list;
  }

  deleteAsistencia() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Asistencia');

    return res;
  }
}
