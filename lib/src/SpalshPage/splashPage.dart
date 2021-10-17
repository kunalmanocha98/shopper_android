import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/HomePage/homepage.dart';
import 'package:shopper/src/Registration/ui/login_page.dart';

class  SplashPage extends StatefulWidget{
  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  SharedPreferences prefs = locator<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ShopperColor.appMainAccent,
        child: Center(
          child: Text("Shopper",style: ShopperTextStyles.headline6.copyWith(
            fontStyle: FontStyle.italic
          ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startFuture();
    });
  }

  void startFuture() async{
    Future.delayed(Duration(seconds: 1),(){
      if(prefs.containsKey(Strings.isLoggedIn)){
        if(prefs.getBool(Strings.isLoggedIn)){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (BuildContext context){
                return HomePage();
              }
          ),ModalRoute.withName('/'));
        }else{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (BuildContext context){
                return LoginPage();
              }
          ),ModalRoute.withName('/'));
        }
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (BuildContext context){
              return LoginPage();
            }
        ),ModalRoute.withName('/'));
      }
    });
  }
}