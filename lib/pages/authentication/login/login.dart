import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:panchat_plus/services/authentication.dart';
import 'package:panchat_plus/shared/styles/background.dart';
import 'package:panchat_plus/shared/styles/button.dart';
import 'package:panchat_plus/shared/styles/input.dart';
import 'package:panchat_plus/shared/styles/color.dart';
import 'package:panchat_plus/shared/widget/error.dart';

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
      body: Stack(
        children: [
          Container(
            decoration: PanchatBackground.gradient
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Visibility(
                    visible: _errorText.isNotEmpty ? true : false,
                    child: ErrorCard(errorText: _errorText),
                  ),
                  CircleAvatar(
                    backgroundColor: PanchatColors.mainColor,
                    radius: 85,
                    child: const Image(
                      image: AssetImage("assets/pandi_32.png"),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    decoration: PanchatInputStyle.decoration.copyWith(
                        hintText: "example@email.com"
                    ),
                    validator: (val) {
                      return val!.isNotEmpty  ? null : "enter an email";
                    },
                    onChanged: (val) {
                      _username = val;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: PanchatInputStyle.decoration.copyWith(
                        hintText: "password"
                    ),
                    validator: (val) {
                      return val!.length > 6 ? null : "must be longer than 6 characters";
                    },
                    onChanged: (val) {
                      _password = val;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: PanchatButtonStyle().mainButtonStyle,
                      child: Text("Login",
                        style: PanchatButtonStyle().mainButtonTextStyle,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await AuthenticationService().signInEmail(
                            email: _username,
                            password: _password,
                          );

                          if (result is String) {
                            setState(() {
                              _errorText = result.toString();
                            });
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
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
