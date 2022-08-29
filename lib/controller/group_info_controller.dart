import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/service/database_service.dart';

class GroupInfoController extends GetxController {
  Stream? member;
  Stream? memb;

  Future getMembers(groupId) async {
    DatabaseSeervice(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(groupId)
        .then((val) {
      member = val;
    
      update();
    });
  }

  getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  bool checkMemb(data) {
    if (data['memb'] == null) {
      return false;
    } else {
      return true;
    }
  }

  memberList() {
    return StreamBuilder(
        stream: member,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
       
            if (snapshot.data['members'] != null) {
              if (snapshot.data['members'].length != 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['members'].length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          getName(snapshot.data['members'][index])
                              .substring(0, 1)
                              .toUpperCase(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        title: Text(getName(snapshot.data['members'][index])),
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    "NO MEMBERS",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  "NO MEMBERS",
                  style: TextStyle(color: Colors.black),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
