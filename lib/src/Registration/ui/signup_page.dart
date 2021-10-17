
import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/Registration/models/family_models.dart';
import 'package:shopper/src/Registration/models/signup_model.dart';
import 'package:shopper/src/Registration/ui/family_list_page.dart';
import 'package:shopper/src/Registration/ui/login_page.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_text_field.dart';


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
  FamilyListItem familyModel;
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 32.0, bottom: 8, left: 16),
              child: Text(
                ShopperLocalizations(context).localization.welcome,
                style: ShopperTextStyles.headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 8, left: 16,right: 16),
              child: Text(
                ShopperLocalizations(context).localization.signup_welcome,
                style: ShopperTextStyles.subtitle2
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              validator: validateTextField,
                              onSaved: (value) {
                                name = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              hint: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_name,
                              labelText: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              validator: validateEmail,
                              onSaved: (value) {
                                email = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              hint: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_email,
                              labelText: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_email,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              validator: validateTextField,
                              onSaved: (value) {
                                mobile = value;
                              },
                              keyboardType: TextInputType.number,
                              hint: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_mobile,
                              labelText: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_mobile,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              controller: passwordController,
                              validator: validatePassword,
                              onSaved: (value) {
                                password = value;
                              },
                              obscureText: true,
                              hint: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_password,
                              labelText: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_password,

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                              validator: (value) {
                                return validateConfirmPassword(
                                    passwordController.text, value);
                              },
                              onSaved: (value) {
                                confirmPassword = value;
                              },
                              hint:  ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_confirm_password,
                              labelText:  ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_confirm_password,
                              obscureText: true,
                            ),
                          ),

                        ],
                      ),
                      Spacer(),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        child: ShopperElevatedButton(
                          onPressed: () {
                            if(formKey.currentState.validate()){
                              if(familyModel!=null) {
                                formKey.currentState.save();
                                proceedToFamilySelectionPage();
                                signUp();
                              }else{
                                ToastAndSnackbar.showToast(
                                ShopperLocalizations(context).localization.select_family,
                               ShopperColor.information );
                              }
                            }
                          },
                          padding: EdgeInsets.all(16),
                          textStyle: ShopperTextStyles.subtitle2,
                          textColor: ShopperColor.appColorWhite,
                          buttonText: ShopperLocalizations(context).localization.proceed
                              .toUpperCase(),
                        ),
                      )
                    ],
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
                    }), ModalRoute.withName('/'));
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

  }

  void proceedToFamilySelectionPage() {
    SignUpRequest payload = SignUpRequest();
    payload.name = name;
    payload.email = email;
    payload.password = password;
    payload.mobile = mobile;
    payload.familyId = familyModel.sId;
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return FamilyListPage(signUpData:payload);
    }));
  }
}
