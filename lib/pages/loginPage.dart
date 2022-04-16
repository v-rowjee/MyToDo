import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/authentication_service.dart';
import 'package:mytodo/pages/homePage.dart';
import 'package:mytodo/pages/registerPage.dart';
import 'package:mytodo/pages/welcomePage.dart';
import 'package:mytodo/widgets/appBody.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WelcomePage())),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Welcome \nBack',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 80),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
                labelText: "Password", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 40.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      final firebaseUser = context.watch<User?>();
                      return firebaseUser != null ? HomePage() : LoginPage();
                    }));
              },
              child: const Text("Sign in"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage())),
              child: const Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}
