import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _username = "";
  String _password = "";
  String _errorText = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50,),
              TextFormField(
                decoration: fieldStyle.copyWith(
                  hintText: "example@email.com"
                ),
              ),
              TextFormField(
                decoration: fieldStyle.copyWith(
                  hintText: "password"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: buttonStyle,
                  child: const Text("Login",
                    style: buttonTextStyle,
                  ),
                  onPressed: () async {

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
