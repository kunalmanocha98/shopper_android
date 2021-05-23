import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/Registration/models/family_models.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

class CreateFamilyPage extends StatefulWidget {
  @override
  CreateFamilyPageState createState() => CreateFamilyPageState();
}

class CreateFamilyPageState extends State<CreateFamilyPage> with ShopperMixins{
  String familyName;
  String familyUserName;

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopperAppbar.getSimpleAppbar(title: 'Create a Family'),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: ShopperTextStyles.subtitle1,
                validator: validateTextField,
                onSaved: (value){
                  familyUserName = value;
                },
                decoration: InputDecoration(
                    hintStyle: ShopperTextStyles.caption,
                    hintText: ShopperLocalizations(context)
                        .localization
                        .hint_enter_family_user_name),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: ShopperTextStyles.subtitle1,
                validator: validateTextField,
                onSaved: (value){
                  familyName = value;
                },
                decoration: InputDecoration(
                    hintStyle: ShopperTextStyles.caption,
                    hintText: ShopperLocalizations(context)
                        .localization
                        .hint_enter_family_name),
              ),
            ),
            ShopperElevatedButton(
              onPressed: () {
                if(formKey.currentState.validate()){
                  formKey.currentState.save();
                  createFamily();
                }
              },
              textColor: ShopperColor.appColorWhite,
              buttonText:
                  ShopperLocalizations(context).localization.register_family,
            )
          ],
        ),
      ),
    );
  }

  void createFamily() async{
    FamilyCreateRequest payload = FamilyCreateRequest();
    payload.familyName = familyName;
    payload.familyUserName = familyUserName;
    NetworkCall().call(jsonEncode(payload), context, AppUrl.familyCreate,withToken: false).then((value){
      var response = FamilyCreateResponse.fromJson(value);
      if(response.code == Strings.successCode){
       Navigator.pop(context,true);
      }else{
        ToastAndSnackbar.showToast(response.message, ShopperColor.failure);
      }
    }).catchError((onError){
      ToastAndSnackbar.showToast(ShopperLocalizations(context).localization.some_error, ShopperColor.failure);
    });
  }
}
