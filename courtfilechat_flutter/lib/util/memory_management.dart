import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {

  static SharedPreferences prefs;

  static void init() async{
    prefs = await SharedPreferences.getInstance();
  }

  static void setUserId(String userEmail){
    prefs.setString("userId", userEmail);
  }

  static String getUserId(){
    return prefs.getString("userId");
  }

  static void setEmail(String userEmail){
    prefs.setString("email", userEmail);
  }

  static String getEmail(){
    return prefs.getString("email");
  }

  static void setName(String userEmail){
    prefs.setString("name", userEmail);
  }

  static String getName(){
    return prefs.getString("name");
  }

  static void setPhotoUrl(String userEmail){
    prefs.setString("photoUrl", userEmail);
  }

  static String getPhotoUrl(){
    return prefs.getString("photoUrl");
  }

  static void setSid(String sid){
    prefs.setString("sid", sid);
  }

  static String getSid(){
    return prefs.getString("sid");
  }

  //clear all values from shared preferences
  static void clearMemory(){
    prefs.clear();
  }
}