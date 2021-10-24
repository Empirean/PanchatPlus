import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/services/authentication.dart';
import 'package:panchat_plus/shared/styles.dart';
import 'package:panchat_plus/shared/widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _username = "";
  String _password = "";
  String _firstname = "";
  String _lastname = "";
  String _image = "pandi_00.png";
  String _errorText = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: background,
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
                  Visibility(
                    visible: _errorText.isNotEmpty ? true : false,
                    child: errorCard(_errorText),
                  ),
                  GestureDetector(
                    onTap: () async {
                      dynamic result = await showDialog(
                        context: context,
                        builder: (_) {
                          return avatarListDialog;
                        }
                      );

                      if (result != null) {
                        setState(() {
                          _image = result[PanchatUserInfo.nameImage];
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: mainColor,
                      radius: 85,
                      child: Image(
                        image: AssetImage("assets/$_image"),
                      ),
                    ),
                  ),
                  const Text("Your Avatar",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    decoration: fieldStyle.copyWith(
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
                    decoration: fieldStyle.copyWith(
                        hintText: "password"
                    ),
                    validator: (val) {
                      return val!.length > 6 ? null : "must be longer than 6 characters";
                    },
                    onChanged: (val) {
                      _password = val;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: fieldStyle.copyWith(
                        hintText: "confirm password"
                    ),
                    validator: (val) {
                      return val == _password ? null : "passwords do not match";
                    },
                  ),
                  TextFormField(
                    maxLength: 15,
                    decoration: fieldStyle.copyWith(
                        hintText: "first name"
                    ),
                    validator: (val) {
                      return val!.isNotEmpty  ? null : "enter your firstname";
                    },
                    onChanged: (val) {
                      _firstname = val;
                    },
                  ),
                  TextFormField(
                    maxLength: 15,
                    decoration: fieldStyle.copyWith(
                        hintText: "last name"
                    ),
                    validator: (val) {
                      return val!.isNotEmpty  ? null : "enter your lastname";
                    },
                    onChanged: (val) {
                      _lastname = val;
                    },
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
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await AuthenticationService().signUpEmail(
                            email: _username,
                            password: _password,
                            firstname: _firstname,
                            lastname: _lastname,
                            image: _image,
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
