import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/home_screen_controller.dart';
import 'package:group_chat_app/controller/login_controller.dart';
import 'package:group_chat_app/pages/auth/login_page.dart';
import 'package:group_chat_app/pages/profile_screen.dart';
import 'package:group_chat_app/pages/search_page.dart';
import 'package:group_chat_app/service/auth_service.dart';
import 'package:group_chat_app/widgets/group_list.dart';
import 'package:group_chat_app/widgets/popUpDialog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  HomeScreenController homecontroller = Get.put(HomeScreenController());
  LoginController lgcnt = Get.find();

  @override
  Widget build(BuildContext context) {
    homecontroller.gettingUserDAta();
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Group Chat",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to( SearchScreen());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ]),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 50,
            ),
            GetBuilder<HomeScreenController>(builder: (controller) {
              return Text(
                controller.userName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              );
            }),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {},
              selectedColor: Colors.yellow,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(ProfileScreen(
                  name: homecontroller.userName,
                  email: homecontroller.email,
                ));
              },
              selectedColor: Colors.yellow,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                Get.defaultDialog(
                    title: "Logout",
                    middleText: "Are you sure you want to logout?",
                    //titleStyle: TextStyle(color: Colors.black),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.cancel)),
                      IconButton(
                          onPressed: () async {
                            lgcnt.isloading = false;
                            await authService.sighout();
                            Get.off(LoginPage());
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ))
                    ],
                    radius: 20);
              },
              selectedColor: Colors.yellow,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Logout",
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: GroupList(userName: homecontroller.userName,),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 206, 197, 197),
        onPressed: () {
          homecontroller.PopUpDialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
