import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soal/bloc/provider_bloc.dart';
import 'package:soal/pages/home.dart';
import 'package:soal/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => MaterialApp(
            title: 'SOAL - PROONIX',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            builder: (BuildContext context, Widget child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(textScaleFactor: data.textScaleFactor > 2.0 ? 1.2 : data.textScaleFactor),
                child: child,
              );
            },
            initialRoute: 'splash',
            routes: {
              'inicio': (BuildContext context) => InicioPage(),
              'splash': (BuildContext context) => Splash(),
            }),
      ),
    );
  }
}
