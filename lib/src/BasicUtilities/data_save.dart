import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/Registration/models/login_model.dart';

class DataSaveUtil{

  static saveData(User user, String token){
    SharedPreferences prefs = locator<SharedPreferences>();
    prefs.setString(Strings.name, user.name);
    prefs.setString(Strings.email, user.email);
    prefs.setString(Strings.mobile, user.mobile);
    prefs.setString(Strings.userId, user.sId);
    prefs.setString(Strings.familyId, user.familyId);
    prefs.setString(Strings.token, token);
  }

  static clearAllData(){
    SharedPreferences prefs = locator<SharedPreferences>();
    prefs.clear();
  }
}