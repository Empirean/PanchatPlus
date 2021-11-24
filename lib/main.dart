import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:panchat_plus/pages/home/menu/menu.dart';
import 'package:panchat_plus/pages/home/menu/pages/test.dart';
import 'package:panchat_plus/pages/wrapper.dart';
import 'package:panchat_plus/routes/routes.dart';
import 'package:panchat_plus/services/authentication.dart';
import 'package:panchat_plus/services/storage.dart';
import 'package:panchat_plus/shared/widget/channel.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(const MyApp());
}

Future<void> _messageHandler(RemoteMessage message) async {
  print("Handling a background message");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late FirebaseMessaging messaging;
  late String deviceToken = "";
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value){
      deviceToken = value!;
      print("token: $value");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });

  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider.value(
      initialData: null,
      value: AuthenticationService().userInfo,
      child: MaterialApp(
        color: Colors.black,
        home: FutureBuilder(
          future: LocalStorage().storeDeviceToken(deviceToken),
          builder: (context, complete) {
            if (complete.hasData) {
              // print(token.data.toString());
              return const Wrapper();
            }
            return Container();
          },
        ),
        routes: {
          Routes.actionsMenu : (context) => const ActionsMenu(),
          Routes.messages : (context) => const Channel(),
          Routes.test : (context) => const TestPage(),
        },
      ),
    );
  }
}




