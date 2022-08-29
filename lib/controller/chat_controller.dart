import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/service/database_service.dart';
import 'package:group_chat_app/widgets/message_tile.dart';

class ChatController extends GetxController{

Stream<QuerySnapshot>? chats;
  String admin = "";

  @override
  void onInit() {
   // getChatAdmin();
    super.onInit();

  }

  getChatAdmin(String groupid){
     DatabaseSeervice().getChats(groupid).then((val){
      chats = val;
      update();
     });

     DatabaseSeervice().getGroupAdmin(groupid).then((val){
      admin = val;
      update();
     });
  }


    chatMessages(userName) {
    return StreamBuilder(
        stream:chats,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        message: snapshot.data.docs[index]['message'],
                        sender: snapshot.data.docs[index]['sender'],
                        sendByMe:
                            userName == snapshot.data.docs[index]['sender'] ? true:false);
                  })
              : Container();
        });
  }


  sendMessage(message,userName,groupId) {
    if (message.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": message,
        "sender": userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseSeervice().sendMessage(groupId, chatMessageMap);
      // message.clear();
       update();
    }
  }
}