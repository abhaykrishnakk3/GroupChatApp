import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/home_screen_controller.dart';
import 'package:group_chat_app/controller/login_controller.dart';
import 'package:group_chat_app/pages/auth/login_page.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/service/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  ProfileScreen({Key? key,required this.name,required this.email}) : super(key: key);

  HomeScreenController homecontroller = Get.put(HomeScreenController());
  LoginController lgcnt = Get.find();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              homecontroller.userName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                Get.to(HomeScreen());
              },
              selectedColor: Colors.yellow,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(ProfileScreen(name: name,email: email,));
              },
              selectedColor: Colors.yellow,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
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
                          icon: Icon(Icons.cancel)),
                      IconButton(
                          onPressed: () async {
                            lgcnt.isloading = false;
                            await authService.sighout();
                            Get.off(LoginPage());
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ))
                    ],
                    radius: 20);
              },
              selectedColor: Colors.yellow,
              selected: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
   body: Container(padding: EdgeInsets.symmetric(horizontal: 40,vertical: 70),
   child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Icon(Icons.account_circle,size: 200, color: Colors.grey[700]),
    const SizedBox(height: 75,),
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Full Name",style: TextStyle(fontSize: 17),),
       Text(name,style: TextStyle(fontSize: 17),)
    ],
    ),
    SizedBox(height: 40,),
     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Email",style: TextStyle(fontSize: 17),),
       Text(email,style: TextStyle(fontSize: 17),)
    ],
    )
   ]),
   )
    );
  }
}
