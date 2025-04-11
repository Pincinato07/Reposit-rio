import 'package:flutter/material.dart';
import 'package:login/ui/login_page.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(Object context) {
    return MaterialApp(
      home: LoginPage(),
    );

  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Olá Mundo"),),
    );
  }
}
