import 'package:flutter/material.dart';
import 'package:soal/bloc/inicio_bloc.dart';

class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  final inicioBloc = InicioBloc();

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(ProviderBloc oldWidget) {
    return true;
  }

  // static ProviderBloc of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<ProviderBloc>();
  // }

  static InicioBloc tabs(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).inicioBloc;
  }
}
