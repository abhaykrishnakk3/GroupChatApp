import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/controller/chat_controller.dart';
import 'package:group_chat_app/pages/group_info.dart';

class ChatScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  ChatScreen(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  Stream<QuerySnapshot>? chats;

  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    chatController.getChatAdmin(widget.groupId);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            widget.groupName,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(GroupInfo(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: chatController.admin));
                },
                icon: const Icon(
                  Icons.info_outline,
                  size: 30,
                  color: Colors.grey,
                ))
          ],
        ),
        body: GetBuilder<ChatController>(builder: (controller) {
          return Stack(
            children: [
              // chat messages
               Container(
                color: Colors.amber,
                height: 578,
                child:  chatController.chatMessages(widget.userName),
               ),
             
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  color: Colors.grey[700],
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                      controller: messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Send a message...",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                          border: InputBorder.none),
                    )),
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                            onPressed: () async {
                              print(widget.userName);
                              chatController.sendMessage(messageController.text,
                                  widget.userName, widget.groupId);
                              messageController.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.send)))
                  ]),
                ),
              )
            ],
          );
        }));
  }
}
