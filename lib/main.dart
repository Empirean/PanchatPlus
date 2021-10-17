import 'package:flutter/material.dart';
import 'package:panchat_plus/pages/wrapper.dart';
import 'package:panchat_plus/services/authentication.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: null,
      value: AuthenticationService().userInfo,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}



