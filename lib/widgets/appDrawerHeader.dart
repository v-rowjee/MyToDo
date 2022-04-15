import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/drawer.jpg'))),
        child: Stack(children: const [
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("MyToDo",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2
                  ))),
        ]));
  }
}
