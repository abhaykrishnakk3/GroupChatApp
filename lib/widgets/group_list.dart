import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/home_screen_controller.dart';
import 'package:group_chat_app/widgets/group_tile.dart';

class GroupList extends StatelessWidget {
  final String userName;
  GroupList({Key? key, required this.userName}) : super(key: key);

  HomeScreenController homecontroller = Get.find();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return StreamBuilder(
            stream: homecontroller.group,
            builder: (context, AsyncSnapshot snapshot) {
              //make some checks
              if (snapshot.hasData) {
                if (snapshot.data['groups'] != null) {
                  if (snapshot.data['groups'].length != 0) {
                    return ListView.builder(
                    
                        itemCount: snapshot.data['groups'].length,
                        itemBuilder: (context, index) {
                         int reversIndex = snapshot.data['groups'].length - index -1;
                          return GroupTile(
                              userName: userName,
                              groupId: getId(snapshot.data["groups"][reversIndex]),
                              groupName: getName(snapshot.data["groups"][reversIndex]));
                        });
                  } else {
                    return noGroupList();
                  }
                } else {
                  return noGroupList();
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      }
    );
  }

  //string manipultion

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  Widget noGroupList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                homecontroller.PopUpDialog();
              },
              child: Icon(
                Icons.add_circle,
                color: Colors.grey[700],
                size: 75,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You are not Joined any groups , tap on the add icon to create a group or also search",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
