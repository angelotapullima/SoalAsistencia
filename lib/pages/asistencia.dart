import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soal/database/persona_database.dart';
import 'package:soal/utils/utils.dart';

class Asistencia extends StatefulWidget {
  @override
  _AsistenciaState createState() => _AsistenciaState();
}

class _AsistenciaState extends State<Asistencia> {
  final _controller = Controller();
  final TextEditingController dniController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dataPersona = PersonaDatabase();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("SOAL - PROONIX"),
        ),
        centerTitle: true,
        //backgroundColor: Color(0XFF0635C9),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
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
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w400,
                      letterSpacing: ScreenUtil().setSp(0.016),
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Text(
                    "${obtenerFechaMostrar()}",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w400,
                      letterSpacing: ScreenUtil().setSp(0.016),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFF1AE5BE)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16), vertical: ScreenUtil().setHeight(8)),
                    //margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                    child: PopupMenuButton(
                      onSelected: (value) {
                        _controller.changeValue(value);
                        if (value == "DNI") {
                          _controller.changeMaxL(8);
                        } else {
                          _controller.changeMaxL(12);
                        }
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
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _controller.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: ScreenUtil().setSp(0.016),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0XFF1AE5BE),
                                  size: ScreenUtil().setHeight(30),
                                )
                              ],
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (_, s) {
                        return TextFormField(
                          controller: dniController,
                          maxLength: _controller.maxLeng,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide(color: Color(0XFF1AE5BE)), borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFF1AE5BE)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(
                              Icons.document_scanner,
                              color: Color(0XFF1AE5BE),
                            ),
                            labelText: "Nro de Documento",
                            labelStyle: TextStyle(color: Color(0XFF1AE5BE)),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                        );
                      }),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  InkWell(
                    onTap: () async {
                      final listPersonas = await dataPersona.obtenerPersonasDni(_controller.value, dniController.text);
                      if (listPersonas.length > 0) {
                        _controller.changeData('${listPersonas[0].personName}', 'Tu asistencia fue registrada correctamente', 1);
                      } else {
                        _controller.changeData('', 'No se encontró', 2);
                      }
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(50),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0XFF1AE5BE),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(8)),
                          Text(
                            'BUSCAR',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              fontWeight: FontWeight.w500,
                              letterSpacing: ScreenUtil().setSp(0.016),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),

                  AnimatedBuilder(
                      animation: _controller,
                      builder: (_, t) {
                        if (_controller.res == 0) {
                          return Container();
                        }

                        if (_controller.res == 1) {
                          return Column(
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(50),
                                child: SvgPicture.asset('assets/svg/user.svg'),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              Text(
                                _controller.name,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                _controller.message,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(24)),
                              InkWell(
                                onTap: () {
                                  dniController.text = '';
                                  _controller.changeData('', '', 0);
                                },
                                child: Text(
                                  'LIMPIAR',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                    color: Color(0XFF1AE5BE),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(50),
                                child: SvgPicture.asset('assets/svg/cancel.svg'),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              Text(
                                _controller.message,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(24)),
                              InkWell(
                                onTap: () {
                                  dniController.text = '';
                                  _controller.changeData('', '', 0);
                                },
                                child: Text(
                                  'LIMPIAR',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                    color: Color(0XFF1AE5BE),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      })

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     ElevatedButton.icon(
                  //       icon: Icon(Icons.search),
                  //       style: ElevatedButton.styleFrom(primary: Colors.blue),
                  //       onPressed: () async {
                  //         final listPersonas = await dataPersona.obtenerPersonasDni(_controller.value, dniController.text);
                  //         if (listPersonas.length > 0) {
                  //           personaFindController.text = "${listPersonas[0].personName}, tu asistencia fue registrada correctamente";
                  //         } else {
                  //           personaFindController.text = "No se encontró";
                  //         }
                  //       },
                  //       label: Text('BUSCAR', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white)),
                  //     )
                  //   ],
                  // ),
                  // TextFormField(
                  //   controller: personaFindController,
                  //   minLines: 3,
                  //   maxLines: 5,
                  //   decoration: InputDecoration(
                  //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue), borderRadius: BorderRadius.circular(5.5)),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(color: Colors.blue),
                  //       borderRadius: BorderRadius.circular(5.5),
                  //     ),
                  //     prefixIcon: Icon(
                  //       Icons.person,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // ),
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
  int maxLeng = 8;

  String name = '';
  String message = '';

  int res = 0;
  bool cargando = false;

  void changeData(String nam, String messag, int re) {
    name = nam;
    message = messag;
    res = re;
    notifyListeners();
  }

  void changeMaxL(int m) {
    maxLeng = m;
    notifyListeners();
  }

  void changeValue(String v) {
    if (v == "DNI") {}
    value = v;
    notifyListeners();
  }

  void changeCargado(bool c) {
    cargando = c;
    notifyListeners();
  }
}
