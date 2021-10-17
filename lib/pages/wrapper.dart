import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
import 'login/login.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {

    final userInfo = Provider.of<PanchatUserInfo?>(context);

    if (userInfo != null) {
      return const Login();
    }
    else {
      return const Home();
    }
  }
}


