import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/Registration/signup_page.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

import 'login_page.dart';

class WelcomePage extends StatefulWidget{
  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(top:32.0,bottom: 8,left: 16),
                child: Text(ShopperLocalizations(context).localization.welcome,
                style: ShopperTextStyles.headline2.copyWith(
                  fontWeight: FontWeight.bold
                ),),
              ),
              Expanded(
                  child:Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 4,bottom: 4,left: 24,right: 24),
                          child: ShopperElevatedButton(
                            padding: EdgeInsets.all(8),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return SignupPage();
                              }));
                            },
                            textStyle: ShopperTextStyles.subtitle2,
                            buttonText: ShopperLocalizations(context).localization.signup.toUpperCase(),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 4,bottom: 4,left: 24,right: 24),
                          child: ShopperElevatedButton(
                            padding: EdgeInsets.all(8),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return LoginPage();
                              }));
                            },
                            textStyle: ShopperTextStyles.subtitle2,
                            buttonText: ShopperLocalizations(context).localization.login.toUpperCase(),
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}