import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/service/database_service.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    gettingUserDAta();
  }

  String userName = "";
  String email = "";
  Stream? group;

  gettingUserDAta() async {
    await HelperFunction.getuserEmailFormSf().then((value) {
      email = value!;
    });
    await HelperFunction.getuserNameFormSf().then((value) {
      userName = value!;
    });
    update();

    await DatabaseSeervice(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      group = snapshot;
      update();
    });
  }



  PopUpDialog() {
    bool isloading = false;
    TextEditingController groupnameController = TextEditingController();
    final formkey = GlobalKey<FormState>();
    Get.defaultDialog(
        title: "Create group",
        content: Form(
          key: formkey,
          child: Column(
            children: [
              isloading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : TextFormField(
                    validator:(value){
                      if(value!.isEmpty){
                        return "Empty";
                      }
                    },
                      controller: groupnameController,
                      decoration: InputDecoration(
                          hintText: "Group name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    )
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('cancel')),
          ElevatedButton(
              onPressed: () {
               if(formkey.currentState!.validate()){
                 isloading = true;
                DatabaseSeervice(uid: FirebaseAuth.instance.currentUser!.uid)
                    .createGroup(
                        userName,
                        FirebaseAuth.instance.currentUser!.uid,
                        groupnameController.text).whenComplete((){
                          isloading = false;
                        });
                        Get.back();
               }
              },
              child: Text('create'))
        ],
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.black),
        radius: 20);
  }

}
