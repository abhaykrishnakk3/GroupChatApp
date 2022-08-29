import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/register_screen_controller.dart';
import 'package:group_chat_app/pages/auth/login_page.dart';
import 'package:group_chat_app/widgets/textinputdecoration.dart';

class RegisterScreen extends StatelessWidget {
 RegisterScreen({Key? key}) : super(key: key);




  final formkey = GlobalKey<FormState>();

  RegisterController registerController  = Get.put(RegisterController());

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(
        
        builder: (controller) {
          return SafeArea(
            child:registerController.isloading
                      ? const Center(
                          child:  CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 80),
                            child: Form(
                                key: formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Groupie",
                                      style:  TextStyle(
                                          fontSize: 40, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Create your account now to chat and explore',
                                      style:  TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w400),
                                    ),
                                    Center(
                                        child: Image.asset(
                                      'assets/ezgif.com-gif-maker.jpg',
                                      height: 300,
                                      width: 300,
                                    )),
                                    TextFormField(
                                      controller: nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter your Name";
                                        }
                                      },
                                      decoration: textInputDecoration.copyWith(
                                          label: const Text("Name"),
                                          prefixIcon: const Icon(Icons.email)),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter your email";
                                        }
                                      },
                                      decoration: textInputDecoration.copyWith(
                                          label: const Text("Email"),
                                          prefixIcon: const Icon(Icons.email)),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter your Password";
                                        }
                                      },
                                      obscureText: true,
                                      decoration: textInputDecoration.copyWith(
                                          label: const Text("Password"),
                                          prefixIcon: const Icon(Icons.lock)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 40,
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                           registerController.register(formkey, nameController.text, emailController.text, passwordController.text,context);
                                          },
                                          child: const Text("Sign Up")),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Already have an account? "),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (ctx) {
                                                return LoginPage();
                                              }));
                                            },
                                            child: const Text("Login Now"))
                                      ],
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
