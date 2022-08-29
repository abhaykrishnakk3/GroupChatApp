
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/login_controller.dart';
import 'package:group_chat_app/controller/register_screen_controller.dart';
import 'package:group_chat_app/pages/auth/register_page.dart';
import 'package:group_chat_app/widgets/textinputdecoration.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();

   LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {

    final emailcontroller =TextEditingController();
    final passswordController = TextEditingController();
     RegisterController registerController  = Get.put(RegisterController());
    return Scaffold(
        body:GetBuilder<LoginController>(
        
          builder: (controller) {
            return SafeArea(
              child: controller.isloading ? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
                  child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Groupie",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Login now to see what they are talking',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Image.asset('assets/ezgif.com-gif-maker.jpg'),
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your email";
                          }
                        },
                        decoration: textInputDecoration.copyWith(
                            label: Text("Email"), prefixIcon: Icon(Icons.email)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Password";
                          }
                        },
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            label: Text("Password"), prefixIcon: Icon(Icons.lock)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async{
                            await  loginController.login(formkey,emailcontroller.text, passswordController.text);
                             
                            },
                            child: Text("Sign In")),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Text.rich(TextSpan(
                            text: "Dont't have an accont? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              TextSpan(
                                  text: "Register Here",
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    registerController.isloading = false;
                                   Get.to(RegisterScreen());
                                  })
                            ])),
                      )
                    ],
                  )),
                  ),
                ),
            );
          }
        ));
  }

 
}
