import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/Registration/models/signup_model.dart';
import 'package:shopper/src/Registration/ui/family_list_page.dart';
import 'package:shopper/src/Registration/ui/login_page.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';


class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> with ShopperMixins {
  String email;
  String mobile;
  String password;
  String confirmPassword;
  String name;
  String familyId;
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32.0, bottom: 8, left: 16),
              child: Text(
                ShopperLocalizations(context).localization.signup,
                style: ShopperTextStyles.headline2
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShopperCard(
                          padding: EdgeInsets.only(
                              bottom: 16, left: 16, right: 16, top: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateTextField,
                                  onSaved: (value) {
                                    name = value;
                                  },
                                  style: ShopperTextStyles.subtitle1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context)
                                          .localization
                                          .hint_enter_name),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateEmail,
                                  onSaved: (value) {
                                    email = value;
                                  },
                                  style: ShopperTextStyles.subtitle1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context)
                                          .localization
                                          .hint_enter_email),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: validateTextField,
                                  onSaved: (value) {
                                    mobile = value;
                                  },
                                  style: ShopperTextStyles.subtitle1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context)
                                          .localization
                                          .hint_enter_mobile),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: ShopperTextStyles.subtitle1,
                                  controller: passwordController,
                                  validator: validatePassword,
                                  onSaved: (value) {
                                    password = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context)
                                          .localization
                                          .hint_enter_password),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: ShopperTextStyles.subtitle1,
                                  validator: (value) {
                                    return validateConfirmPassword(
                                        passwordController.text, value);
                                  },
                                  onSaved: (value) {
                                    confirmPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintStyle: ShopperTextStyles.caption,
                                      hintText: ShopperLocalizations(context)
                                          .localization
                                          .hint_enter_confirm_password),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return FamilyListPage();
                                      })).then((value) {});
                                    },
                                    title: Text(
                                      "Select Family",
                                      style: ShopperTextStyles.subtitle1,
                                    ),
                                    subtitle: Text(
                                      "choose your family from the list or create your own",
                                      style: ShopperTextStyles.bodyText2,
                                    ),
                                    trailing:
                                        Icon(Icons.arrow_forward_ios_rounded),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: ShopperElevatedButton(
                            onPressed: () {
                              if(formKey.currentState.validate()){
                                formKey.currentState.save();
                                signUp();
                              }
                            },
                            textStyle: ShopperTextStyles.subtitle2,
                            textColor: ShopperColor.appColorWhite,
                            buttonText: ShopperLocalizations(context)
                                .localization
                                .signup
                                .toUpperCase(),
                          ),
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
                Text(
                  ShopperLocalizations(context)
                      .localization
                      .already_have_account,
                  style: ShopperTextStyles.subtitle2,
                ),
                ShopperTextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginPage();
                    }), ModalRoute.withName('/')).then((value){
                      if(value){
                        familyId = value;
                      }
                    });
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

  void signUp() async{
    SignUpRequest payload = SignUpRequest();
    payload.name = name;
    payload.email = email;
    payload.password = password;
    payload.mobile = mobile;
    payload.familyId = familyId;
    NetworkCall().call(jsonEncode(payload), context, AppUrl.signUp);
  }
}
