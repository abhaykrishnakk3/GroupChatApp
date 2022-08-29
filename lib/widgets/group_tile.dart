import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/pages/chat_page.dart';

class GroupTile extends StatelessWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        onTap: () {
          Get.to(ChatScreen(
              groupId: groupId, groupName: groupName, userName: userName));
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 135, 132, 100),
          child: Text(
            groupName.substring(0, 1).toUpperCase(),
            textAlign: TextAlign.center,
            style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(groupName),
        subtitle: Text(groupId),
      ),
    );
  }
}
