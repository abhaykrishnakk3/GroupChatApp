import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/pages/chat_page.dart';
import 'package:group_chat_app/service/database_service.dart';

class SearchController extends GetxController {
  bool isloading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;

  String userName = "";

  User? user;
  bool isJoined = false;
  //initial function

  initiateSearchMethod(search) async {
    if (search.isNotEmpty) {
      isloading = true;
      update();
      await DatabaseSeervice().searchByName(search).then((snapshot) {
        searchSnapshot = snapshot;
        isloading = false;
        hasUserSearched = true;
        update();
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                  userName,
                  searchSnapshot!.docs[index]['groupId'],
                  searchSnapshot!.docs[index]['groupName'],
                  searchSnapshot!.docs[index]['admin']);
            })
        : Container();
  }

  joinedOrNot(
      String userName, String groupId, String groupname, String admin) async {
    await DatabaseSeervice(uid: user!.uid)
        .isUserJoined(groupname, groupId, userName)
        .then((value) {
      isJoined = value;
      update();
    });
  }

  Widget groupTile(
      String userName, String groupid, String groupName, String admin) {
    joinedOrNot(userName, groupid, groupName, admin);
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.green,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(groupName,style: TextStyle(color: Colors.black),),
      trailing: InkWell(onTap: ()async{
          await DatabaseSeervice(uid: user!.uid).toggleGroupJoin(groupid, userName, groupName);
          if(isJoined){
              isJoined = !isJoined;
              update();
              Get.snackbar("", "Success full creatd");
              Future.delayed(Duration(seconds: 2),(){
                Get.to(ChatScreen(groupId: groupid, groupName: groupName, userName: userName));
              });
          }else{
          //  isJoined 
          }
      },
      child: isJoined ? Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
        border: Border.all(color: Colors.white,width:1 ),

      ),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Text("Joined",style: TextStyle(color: Colors.white),),
      ): Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
        ,color: Colors.green,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Text("Join",style: TextStyle(color: Colors.white),)
        
        ,
      )
      ),
    );
  }

  getCurrentUserIdandName() async {
    await HelperFunction.getuserNameFormSf().then((value) {
      userName = value!;
      update();
    });
    user = FirebaseAuth.instance.currentUser;
  }
}
