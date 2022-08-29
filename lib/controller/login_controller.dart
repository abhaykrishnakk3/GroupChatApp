import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/service/auth_service.dart';
import 'package:group_chat_app/service/database_service.dart';

class LoginController extends GetxController {
  AuthService authService = AuthService();
  bool isloading = false;

  login(dynamic formkey, String email, String password) async {
    if (formkey.currentState!.validate()) {
      isloading = true;
      update();
      await authService.LoginUserWithEmailandPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot = await DatabaseSeervice(
                  uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);

              // saving the values to out shared preferences
                  await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserEmailsf(email);
          await HelperFunction.saveUserNamesf(snapshot.docs[0]['fullName']);

          Get.to(HomeScreen());
        } else {
          Get.snackbar("error", "Check the Email or Password");

          isloading = false;
          update();
        }
      });
    }
  }
}
