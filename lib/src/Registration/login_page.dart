import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopperAppbar.getSimpleAppbar(title: 'Login Page'),
      body:Column(
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
          ShopperElevatedButton(onPressed: (){},
            textColor: ShopperColor.appColorWhite,
            buttonText: ShopperLocalizations(context).localization.login,)
        ],
      )
    );
  }
}