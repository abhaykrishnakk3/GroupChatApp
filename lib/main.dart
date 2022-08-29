import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/pages/auth/login_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isSignedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus()async{
    await HelperFunction.getUserLoggedInStatus().then((value){
      if(value != null){
        _isSignedIn =value;
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? HomeScreen() : LoginPage(),
    );
  }
}