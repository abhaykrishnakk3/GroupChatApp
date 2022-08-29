
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/group_info_controller.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/service/database_service.dart';

class GroupInfo extends StatelessWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  GroupInfo(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.adminName})
      : super(key: key);

  GroupInfoController groupInfoController = Get.put(GroupInfoController());

  @override
  Widget build(BuildContext context) {
    groupInfoController.getMembers(groupId);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Group Info",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(onPressed: () {
              DatabaseSeervice(uid: FirebaseAuth.instance.currentUser!.uid).toggleGroupJoin(groupId, adminName, groupName).whenComplete((){
                Get.off(HomeScreen());
              });
            }, icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: GetBuilder<GroupInfoController>(
        
          builder: (controller) {
            return Column(
              children: [
                Container(
                  child: ListTile(
                    title: Text("Group : $groupName"),
                    subtitle: Text("Admin : ${groupInfoController.getName(adminName)}"),
                  ),
                ),
              groupInfoController.memberList()
              ],
            );
          }
        ));
  }


}
