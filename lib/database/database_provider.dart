import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'soal.db');
    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    return await openDatabase(path,
        version: 1,
        onOpen: (db) {},
        onConfigure: _onConfigure, onCreate: (Database db, int version) async {
      await db.execute(' CREATE TABLE Asistencia('
          ' idAsistencia INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' tipoDoc TEXT,'
          ' nroDoc TEXT,'
          ' fecha TEXT,'
          ' hora TEXT'
          ')');
      await db.execute(' CREATE TABLE Personas('
          ' idPersona INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' personName TEXT,'
          ' personSurname TEXT,'
          ' personSurname2 TEXT,'
          ' personTipoDoc TEXT,'
          ' personNroDoc TEXT'
          ')');
    });
  }
}
