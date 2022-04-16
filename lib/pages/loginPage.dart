import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/pages/welcomePage.dart';
import 'package:mytodo/widgets/appBody.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedRegister;
  LoginPage({Key? key, required this.onClickedRegister}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              onPressed: signIn,
              child: const Text("Sign in"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: widget.onClickedRegister,
              child: const Text("Register"),
            ),
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
