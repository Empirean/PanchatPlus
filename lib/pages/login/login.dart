import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Card(
            child: Column(
              children: [
                TextFormField(),
                TextFormField(),
                ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () {

                  },
                ),
                ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () {

                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
