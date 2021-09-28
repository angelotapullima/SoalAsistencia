import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:soal/bloc/provider_bloc.dart';
import 'package:soal/pages/ajustes.dart';
import 'package:soal/pages/asistencia.dart';

class InicioPage extends StatefulWidget {
  InicioPage({Key key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(Asistencia());
    pageList.add(Ajustes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabBloc = ProviderBloc.tabs(context);

    return Scaffold(
      body: StreamBuilder(
        stream: tabBloc.selectPageStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: kBottomNavigationBarHeight + ScreenUtil().setHeight(40),
                  ),
                  child: IndexedStack(
                    index: snapshot.data,
                    children: pageList,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      right: ScreenUtil().setWidth(30),
                      bottom: ScreenUtil().setHeight(15),
                    ),
                    height: kBottomNavigationBarHeight + ScreenUtil().setHeight(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            tabBloc.changePage(0);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(30),
                                width: ScreenUtil().setWidth(30),
                                child: (tabBloc.page == 0)
                                    ? SvgPicture.asset(
                                        'assets/svg/calendar1On.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/svg/calendarOff.svg',
                                      ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Text(
                                'Asistencia',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                  color: (tabBloc.page == 0) ? Colors.blue : Color(0XFFC4C4C4),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            tabBloc.changePage(1);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: ScreenUtil().setHeight(30),
                                width: ScreenUtil().setWidth(30),
                                child: (tabBloc.page == 1)
                                    ? SvgPicture.asset(
                                        'assets/svg/option1On.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/svg/optionOff.svg',
                                      ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Text(
                                'Opciones',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(14),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                  color: (tabBloc.page == 1) ? Colors.blue : Color(0XFFC4C4C4),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            tabBloc.changePage(0);
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
