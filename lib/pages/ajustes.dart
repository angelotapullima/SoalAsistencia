import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soal/api/asistencia_api.dart';
import 'package:soal/pages/asistencia.dart';
import 'package:soal/utils/utils.dart';

class Ajustes extends StatelessWidget {
  static final _controller = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("SOAL - PROONIX"),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    _controller.changeCargado(true);
                    final asistenciaApi = AsistenciaApi();

                    final res = await asistenciaApi.obtenerPersonas();

                    if (res) {
                      showToast2("Cargado correctamente", Colors.green);
                    } else {
                      showToast2("Ocurrió un error", Colors.red);
                    }
                    _controller.changeCargado(false);
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0XFF1AE5BE),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    height: ScreenUtil().setHeight(250),
                    child: Column(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(180),
                          child: SvgPicture.asset('assets/svg/add-user.svg'),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Text(
                          'Cargar personas',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w500,
                            letterSpacing: ScreenUtil().setSp(0.016),
                            //color: Color(0XFF1AE5BE),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    _controller.changeCargado(true);
                    final asistenciaApi = AsistenciaApi();

                    final res = await asistenciaApi.guardarAsistencia();

                    if (res == 1) {
                      showToast2("Guardado correctamente", Colors.green);
                    } else if (res == 0) {
                      showToast2("Sin asistencias registradas", Colors.red);
                    } else {
                      showToast2("Ocurrió un error", Colors.red);
                    }
                    _controller.changeCargado(false);
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0XFF1AE5BE),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    height: ScreenUtil().setHeight(250),
                    child: Column(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(180),
                          child: SvgPicture.asset('assets/svg/right.svg'),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        Text(
                          'Enviar info',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w500,
                            letterSpacing: ScreenUtil().setSp(0.016),
                            //color: Color(0XFF1AE5BE),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(primary: Colors.white),
                //       onPressed: () async {
                //         final asistenciaApi = AsistenciaApi();

                //         final res = await asistenciaApi.obtenerPersonas();

                //         if (res) {
                //           showToast2("Cargado correctamente", Colors.green);
                //         } else {
                //           showToast2("Ocurrió un error", Colors.red);
                //         }
                //       },
                //       child: Text('Cargar personas', style: Theme.of(context).textTheme.headline6),
                //     ),
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(primary: Colors.white),
                //       onPressed: () async {
                //         final asistenciaApi = AsistenciaApi();

                //         final res = await asistenciaApi.guardarAsistencia();

                //         if (res) {
                //           showToast2("Guardado correctamente", Colors.green);
                //         } else {
                //           showToast2("Ocurrió un error", Colors.red);
                //         }
                //       },
                //       child: Text('Enviar Info', style: Theme.of(context).textTheme.headline6),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (_, s) {
                if (_controller.cargando) {
                  return _mostrarAlert();
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }

  _mostrarAlert() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
