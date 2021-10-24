import 'package:firebase_auth/firebase_auth.dart';
import 'package:panchat_plus/models/userinfo.dart';
import 'package:panchat_plus/services/database.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<PanchatUserInfo?> get userInfo{
    return _firebaseAuth.authStateChanges().map(_loginInfoFromStream);
  }

  PanchatUserInfo? _loginInfoFromStream(User? panchatUserInfo) {
    return panchatUserInfo != null ? PanchatUserInfo(uid: panchatUserInfo.uid) : null;
  }

  Future signOut() async {
    try{
      await _firebaseAuth.signOut();
    }
    catch(e) {
      return null;
    }
  }

  Future signInEmail({String email = "", String password = ""}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    }
    catch(e) {
      return e.toString();
    }
  }

  Future signUpEmail({
    String email = "",
    String password = "",
    String firstname = "",
    String lastname = "",
    String image = "pandi_00.png"
  }) async
  {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      String uid = userCredential.user!.uid;

      Map<String, String> data = {
        "UID" : uid,
        "FIRST_NAME" : firstname,
        "LAST_NAME" : lastname,
        "IMAGE" : image
      };

      DatabaseService(path: "PEOPLE").addEntry(data);
    }
    catch(e) {
      return e.toString();
    }

  }
}