import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login

  Future LoginUserWithEmailandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }
  }

  // register

  Future registerUserWithEmailandPassword(
      String name, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseSeervice(uid: user.uid).savingUserData(name, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }
  }

  //sign out
  Future sighout() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailsf("");
      await HelperFunction.saveUserNamesf("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
