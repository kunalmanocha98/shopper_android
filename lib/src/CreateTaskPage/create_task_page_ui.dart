
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/CreateTaskPage/Models/create_task_models.dart';
import 'package:shopper/src/CreateTaskPage/checklist_add_page.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPage createState() => _CreateTaskPage();
}

class _CreateTaskPage extends State<CreateTaskPage> with ShopperMixins {
  List<String> taskList = [];
  GlobalKey<FormState> formKey = GlobalKey();
  SharedPreferences prefs = locator<SharedPreferences>();
  String note;
  String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: ShopperAppbar.getSimpleAppbar(
              actions: [
                ShopperAppBarActionTextButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      proceed();
                    }
                  },
                  buttonText: ShopperLocalizations(context).localization.next,
                  textColor: ShopperColor.appColorWhite,
                )
              ],
              title:ShopperLocalizations(context).localization.create_task),
          body: Form(
            key: formKey,
            child: Column(children: [
              ShopperCard(
                child: _getTitleWidget(
                    title: ShopperLocalizations(context).localization.title,
                    child: TextFormField(
                      maxLines: 2,
                      maxLength: 150,
                      validator: validateTextField,
                      onSaved: (value) {
                        title = value;
                      },
                      decoration: InputDecoration(
                          hintText: ShopperLocalizations(context)
                              .localization
                              .hint_enter_title,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    )),
              ),
              ShopperCard(
                child: _getTitleWidget(
                    title: ShopperLocalizations(context).localization.note,
                    child: TextFormField(
                      maxLines: 4,
                      maxLength: 250,
                      onChanged: (value) {
                        note = value;
                      },
                      decoration: InputDecoration(
                          hintText:
                          ShopperLocalizations(context).localization.hint_note,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    )),
              )
            ]),
          ),
        ));
  }

  Widget _getTitleWidget({String title, Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: ShopperTextStyles.caption,
        ),
        SizedBox(
          height: 4,
        ),
        Flexible(child: child)
      ],
    );
  }


  void proceed() {
    CreateTaskRequest payload = CreateTaskRequest();
    payload.userId = prefs.getString(Strings.userId);
    payload.familyId = prefs.getString(Strings.familyId);
    payload.title = title;
    payload.subtitle = note;
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context){
          return AddCheckListPage(payload:payload);
        }
    )).then((value) {
      if(value!=null && value){
        Navigator.pop(context,true);
      }
    });
  }
}
