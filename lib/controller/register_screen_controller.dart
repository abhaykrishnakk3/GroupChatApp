import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/service/auth_service.dart';
import 'package:group_chat_app/widgets/textinputdecoration.dart';  

class RegisterController extends GetxController {
  bool isloading = false;
  AuthService authService = AuthService();

  register(dynamic formkey, String name, String email, String password,
      BuildContext context) async {
    if (formkey.currentState!.validate()) {
      isloading = true;
      update();
      await authService
          .registerUserWithEmailandPassword(name, email, password)
          .then((value) async {
        if (value == true) {
          // saving th shared preference state
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserEmailsf(email);
          await HelperFunction.saveUserNamesf(name);
          Get.to(HomeScreen());
        } else {
          showSnackbar(context, Colors.yellow, "Error");

          isloading = false;
          update();
        }
      });
    }
  }
}
