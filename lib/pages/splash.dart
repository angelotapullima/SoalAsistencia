import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soal/bloc/provider_bloc.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  @override
  void afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final tabBloc = ProviderBloc.tabs(context);
      tabBloc.changePage(0);
      Navigator.pushReplacementNamed(context, 'inicio');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
