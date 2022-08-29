
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final bool sendByMe;
  const MessageTile(
      {Key? key,
      required this.message,
      required this.sender,
      required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4, bottom: 4, left: sendByMe ? 0 : 14, right: sendByMe ? 14 : 0),
          alignment: sendByMe ? Alignment.centerRight:Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
            color: sendByMe ? Colors.yellow : Colors.green),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            sender.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          )
        ]),
      ),
    );
  }
}
