import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

obtenerFecha() {
  var fecha = DateTime.now();
  final DateFormat fech = new DateFormat('yyyy-MM-dd');
  return fech.format(fecha);
}

obtenerFechaMostrar() {
  var fecha = DateTime.now();
  final DateFormat fech = new DateFormat('dd MMM yyyy');
  return fech.format(fecha);
}

obtenerHora() {
  var fecha = DateTime.now();
  final DateFormat fech = new DateFormat('HH:mm:ss');
  return fech.format(fecha);
}

void showToast2(String texto, Color color) {
  Fluttertoast.showToast(
      msg: "$texto",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
      backgroundColor: color,
      textColor: Colors.white);
}
