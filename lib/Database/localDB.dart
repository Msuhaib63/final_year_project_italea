import 'package:shared_preferences/shared_preferences.dart';

class LocalDB{
  static final uidKey = "fsfjkfskjfsfv";
  static final ekey = "asdasfasfgasdfasf";
  static final bkey = "sadasfdasfvasvav";
  static final lkey = "467435bvesgwyh";
  static final rkey = "4543467435bvesgwyh";
  static final nkey = "45363w54svegrft";
  static final mkey = "65g14er4efesdfeaswcsdfv45";
  static final pkey = "65g14ascafder4ev45";


  static Future<bool> saveUserID(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uidKey, uid);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(uidKey);
  }

  static Future<bool> saveUserEmail(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ekey, uid);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ekey);
  }

  static Future<bool> saveBio(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(bkey, uid);
  }

  static Future<String?> getBio() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(bkey);
  }



  static Future<bool> savePoint(String point) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(mkey, point);
  }

  static Future<String?> getPoint() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(mkey);
  }



  static Future<bool> saveUserName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nkey, name);
  }

  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nkey);
  }


  static Future<bool> saveUrl(String prourl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(pkey, prourl);
  }

  static Future<String?> getUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(pkey);
  }



  static Future<bool> saveLevel(String level) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(lkey, level);
  }

  static Future<String?> getLevel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(lkey);
  }

  static Future<bool> saveRank(String rank) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(rkey, rank);
  }

  static Future<String?> getRank() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(rkey);
  }





}