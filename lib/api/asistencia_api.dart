import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soal/database/asistencia_database.dart';
import 'package:soal/database/persona_database.dart';

import 'package:soal/model/persona_model.dart';
import 'package:soal/utils/utils.dart';

class AsistenciaApi {
  final _asistenciaDatabase = AsistenciaDatabase();
  final _personaDatabase = PersonaDatabase();
  Future<bool> guardarAsistencia() async {
    try {
      final url = Uri.parse('https://intranet.proonix.com.pe/api/bufeo/guardar_asistencia_diaria');

      final String fecha = obtenerFecha();

      var personas = '';

      final listAsistencias = await _asistenciaDatabase.obtenerAsistenciasFechaPersonas(fecha);

      for (var i = 0; i < listAsistencias.length; i++) {
        personas += '${listAsistencias[i].tipoDoc};${listAsistencias[i].nroDoc};${listAsistencias[i].hora}|';
      }

      if (listAsistencias.length > 0) {
        final resp = await http.post(url, body: {
          'fecha': '$fecha',
          'personas': '$personas',
        });

        final decodedData = json.decode(resp.body);
        print(decodedData);

        if (decodedData['result']['code'] == 1) {
          await _asistenciaDatabase.deleteAsistencia();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> obtenerPersonas() async {
    try {
      await _personaDatabase.deletePersonas();
      final url = Uri.parse('https://intranet.proonix.com.pe/api/bufeo/listar_miembros_asistencia');

      final resp = await http.post(url, body: {});
      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData['result']['code'] == 1) {
        for (var i = 0; i < decodedData['result']['personal'].length; i++) {
          PersonaModel persona = PersonaModel();
          persona.personName = decodedData['result']['personal'][i]['person_name'];
          persona.personSurname = decodedData['result']['personal'][i]['person_surname'];
          persona.personSurname2 = decodedData['result']['personal'][i]['person_surname2'];
          persona.personTipoDoc = decodedData['result']['personal'][i]['person_type_document'];
          persona.personNroDoc = decodedData['result']['personal'][i]['person_dni'];

          await _personaDatabase.insertarPersona(persona);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
