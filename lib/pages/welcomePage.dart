import 'package:flutter/material.dart';
import 'package:mytodo/pages/loginPage.dart';
import 'package:mytodo/pages/registerPage.dart';
import 'package:mytodo/widgets/appBody.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBody(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: const Text(
                'Welcome to \nMyToDo',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Create your new account with your personal information or login with an existing account to access your to-do list.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 225),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage())),
                  child: const Text('Sign In')),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage())),
                  child: const Text('Register')),
            )
          ]),
    );
  }
}
