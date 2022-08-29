import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailkey = "USEREMAILKEY";



  // saving the data to sf

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn)async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }
  
   static Future<bool> saveUserNamesf(String userName)async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

   static Future<bool> saveUserEmailsf(String userEmail)async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailkey, userEmail);
  }
  

  // GETIING THE DATA FROM SF

  static Future<bool?> getUserLoggedInStatus()async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

   static Future<String?> getuserEmailFormSf()async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailkey);
  }

   static Future<String?> getuserNameFormSf()async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }
}