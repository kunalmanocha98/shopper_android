import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: ShopperAppbar.getSimpleAppbar(
          title: ShopperLocalizations(context).localization.signup,
        ),
        body: Form(
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
                            title: Text("Select Family", style: ShopperTextStyles.subtitle1,),
                            subtitle:Text("choose your family from the list or create your own", style: ShopperTextStyles.bodyText2,),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                          )
                        ),
                      ],
                    ),
                  ),
                  ShopperElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return FamilyListPage();
                      }
                    ));
                  },
                    textColor: ShopperColor.appColorWhite,
                    buttonText: ShopperLocalizations(context).localization.signup,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}