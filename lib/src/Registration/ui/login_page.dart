import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/Registration/ui/signup_page.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
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
                          decoration: InputDecoration(
                              hintStyle: ShopperTextStyles.caption,
                              hintText: ShopperLocalizations(context).localization.hint_enter_password
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        child: ShopperElevatedButton(onPressed: (){},
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
      )
    );
  }
}