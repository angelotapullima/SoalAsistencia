import 'package:flutter/material.dart';
import 'package:soal/api/asistencia_api.dart';
import 'package:soal/utils/utils.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.check_circle_sharp, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                Text(
                  "Asistencia",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/ajustes');
                    }),
                Text("Ajustes", style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
