import 'package:flutter/material.dart';
import 'package:soal/database/asistencia_database.dart';
import 'package:soal/database/persona_database.dart';
import 'package:soal/utils/utils.dart';

import 'custom_bottomappbar.dart';

class Asistencia extends StatefulWidget {
  //const Asistencia({Key key}) : super(key: key);
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => Asistencia());
  }

  @override
  _AsistenciaState createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  final _controller = Controller();
  final TextEditingController personaFindController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  int _maxLeng = 8;
  @override
  Widget build(BuildContext context) {
    final guardarAsistencia = AsistenciaDatabase();
    final DataPersona = PersonaDatabase();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("SOAL - PROONIX"),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Registro de Asistencia",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "${obtenerFechaMostrar()}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopupMenuButton(
                      onSelected: (value) {
                        _controller.changeValue(value);
                        if (value == "DNI") {
                          _maxLeng = 8;
                        } else {
                          _maxLeng = 12;
                        }
                        setState(() {});
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('DNI'),
                          value: 'DNI',
                        ),
                        PopupMenuItem(
                          child: Text('Pasaporte'),
                          value: 'Pasaporte',
                        ),
                        PopupMenuItem(
                          child: Text('Carnet de extranjería'),
                          value: 'Carnet de extranjería',
                        )
                      ],
                      child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, snapshot) {
                            return Text(
                              _controller.value,
                              style: TextStyle(
                                  fontSize: 18,
                                  backgroundColor: Colors.blue[50]),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: dniController,
                    maxLength: _maxLeng,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5.5)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(
                        Icons.document_scanner,
                        color: Colors.blue,
                      ),
                      labelText: "Nro de Documento",
                      labelStyle: TextStyle(color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.search),
                        style: ElevatedButton.styleFrom(primary: Colors.blue),
                        onPressed: () async {
                          final listPersonas =
                              await DataPersona.obtenerPersonasDni(
                                  _controller.value, dniController.text);
                          if (listPersonas.length > 0) {
                            personaFindController.text =
                                "${listPersonas[0].personName}, tu asistencia fue registrada correctamente";
                          } else {
                            personaFindController.text = "No se encontró";
                          }
                        },
                        label: Text('BUSCAR',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white)),
                      )
                    ],
                  ),
                  TextFormField(
                    controller: personaFindController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(5.5)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Controller extends ChangeNotifier {
  String value = 'DNI';

  void changeValue(String v) {
    if (v == "DNI") {}
    value = v;
    notifyListeners();
  }
}
