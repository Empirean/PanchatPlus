import 'package:firebase_auth/firebase_auth.dart';
import 'package:panchat_plus/models/userinfo.dart';

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

  Future signUpEmail({String email = "", String password = ""}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    }
    catch(e) {
      return e.toString();
    }

  }
}