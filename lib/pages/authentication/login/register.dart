import 'package:flutter/material.dart';
import 'package:panchat_plus/shared/styles.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _username = "";
  String _password = "";
  String _errorText = "";

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red,
                  Colors.blue,
                ],
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  const CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 85,
                    child: Image(
                      image: AssetImage("assets/pandi_00.png"),
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                      child: const Text("Register",
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
        ],
      ),
    );
  }
}
