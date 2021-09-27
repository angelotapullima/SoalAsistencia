import 'package:flutter/material.dart';
import 'package:soal/api/asistencia_api.dart';
import 'package:soal/pages/custom_bottomappbar.dart';
import 'package:soal/utils/utils.dart';

class Ajustes extends StatelessWidget {
  //const Asistencia({Key key}) : super(key: key);
  static const String routeName = '/ajustes';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => Ajustes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("SOAL - PROONIX"),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                final asistenciaApi = AsistenciaApi();

                final res = await asistenciaApi.obtenerPersonas();

                if (res) {
                  showToast2("Cargado correctamente", Colors.green);
                } else {
                  showToast2("Ocurrió un error", Colors.red);
                }
              },
              child: Text('Cargar personas',
                  style: Theme.of(context).textTheme.headline6),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () async {
                final asistenciaApi = AsistenciaApi();

                final res = await asistenciaApi.guardarAsistencia();

                if (res) {
                  showToast2("Guardado correctamente", Colors.green);
                } else {
                  showToast2("Ocurrió un error", Colors.red);
                }
              },
              child: Text('Enviar Info',
                  style: Theme.of(context).textTheme.headline6),
            )
          ],
        ),
      ),
    );
  }
}
