import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/Registration/login_page.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

import 'family_list_page.dart';

class SignupPage extends StatefulWidget{
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(top:32.0,bottom: 8,left: 16),
              child: Text(ShopperLocalizations(context).localization.signup,
                style: ShopperTextStyles.headline2.copyWith(
                    fontWeight: FontWeight.bold
                ),),
            ),
            Expanded(
              child: Form(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShopperCard(
                          padding: EdgeInsets.only(bottom: 16,left: 16,right: 16,top: 12),
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
                                      hintText: ShopperLocalizations(context).localization.hint_enter_mobile
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: ShopperTextStyles.subtitle1,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context).localization.hint_enter_password
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: ShopperTextStyles.subtitle1,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context).localization.hint_enter_confirm_password
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context){
                                          return FamilyListPage();
                                        }
                                    ));
                                  },
                                  title: Text("Select Family", style: ShopperTextStyles.subtitle1,),
                                  subtitle:Text("choose your family from the list or create your own", style: ShopperTextStyles.bodyText2,),
                                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: ShopperElevatedButton(onPressed: (){},
                            textStyle: ShopperTextStyles.subtitle2,
                            textColor: ShopperColor.appColorWhite,
                            buttonText: ShopperLocalizations(context).localization.signup.toUpperCase(),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ShopperLocalizations(context).localization.already_have_account,
                style: ShopperTextStyles.subtitle2,),
                ShopperTextButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (BuildContext context){
                          return LoginPage();
                        }
                    ),ModalRoute.withName('/'));
                  },
                  buttonText: ShopperLocalizations(context).localization.login,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}