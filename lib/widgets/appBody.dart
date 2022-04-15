import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  const AppBody({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.png'),
                  fit: BoxFit.cover,
                  opacity: 0.05)),
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(20), child: child),
        ),
      ),
    );
  }
}
