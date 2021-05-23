import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/data_save.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/HomePage/homepage.dart';
import 'package:shopper/src/Registration/models/login_model.dart';
import 'package:shopper/src/Registration/ui/signup_page.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with ShopperMixins{
  GlobalKey<FormState> formKey = GlobalKey();
  SharedPreferences prefs = locator<SharedPreferences>();
  String emailId;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top:32.0,bottom: 8,left: 16),
                child: Text(ShopperLocalizations(context).localization.login,
                  style: ShopperTextStyles.headline2.copyWith(
                      fontWeight: FontWeight.bold
                  ),),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: ShopperTextStyles.subtitle1,
                            validator: validateEmail,
                            onSaved: (value){
                              emailId = value;
                            },
                            decoration: InputDecoration(
                                hintStyle: ShopperTextStyles.caption,
                                hintText: ShopperLocalizations(context).localization.hint_enter_email
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: ShopperTextStyles.subtitle1,
                            obscureText: true,
                            validator: validatePassword,
                            onSaved: (value){
                              password = value;
                            },
                            decoration: InputDecoration(
                                hintStyle: ShopperTextStyles.caption,
                                hintText: ShopperLocalizations(context).localization.hint_enter_password
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: ShopperElevatedButton(onPressed: (){
                            if(formKey.currentState.validate()){
                              formKey.currentState.save();
                              login();
                            }
                          },
                            textStyle: ShopperTextStyles.subtitle2,
                            textColor: ShopperColor.appColorWhite,
                            buttonText: ShopperLocalizations(context).localization.login.toUpperCase(),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ShopperLocalizations(context).localization.dont_have_account,
                    style: ShopperTextStyles.subtitle2,),
                  ShopperTextButton(
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (BuildContext context){
                            return SignupPage();
                          }
                      ),ModalRoute.withName('/'));
                    },
                    buttonText: ShopperLocalizations(context).localization.signup,
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  void login() async{
    LoginRequest payload = LoginRequest();
    payload.email = emailId;
    payload.password = password;
    NetworkCall().call(jsonEncode(payload), context, AppUrl.login,withToken: false).then((value) {
      var response = LoginResponse.fromJson(value);
      if(response.code == Strings.successCode){
        prefs.setBool(Strings.isLoggedIn,true);
        DataSaveUtil.saveData(response.results.user, response.results.token);
        ToastAndSnackbar.showToast(ShopperLocalizations(context).localization.logged_in, ShopperColor.information);
        proceedtoHomePage();
      }else{
        ToastAndSnackbar.showToast(response.message, ShopperColor.information);
      }
    });
  }

  void proceedtoHomePage() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (BuildContext context){
          return HomePage();
        }
    ),ModalRoute.withName('/'));
  }
}