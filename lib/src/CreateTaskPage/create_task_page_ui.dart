import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/CreateTaskPage/AssignToWidget.dart';
import 'package:shopper/src/CreateTaskPage/Models/create_task_models.dart';
import 'package:shopper/src/Dialogs/dialog_add_task.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPage createState() => _CreateTaskPage();
}

class _CreateTaskPage extends State<CreateTaskPage> with ShopperMixins{
  List<String> taskList = [];
  GlobalKey<AssignToWidgetState> assignKey = GlobalKey();
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
                  if(formKey.currentState.validate()){
                    formKey.currentState.save();
                    if(taskList.length>0){
                      createTask();
                    }else{
                      ToastAndSnackbar.showToast(
                        ShopperLocalizations(context).localization.task_create_error,
                          ShopperColor.failure);
                    }
                  }
                },
                buttonText: ShopperLocalizations(context).localization.create,
                textColor: ShopperColor.appColorBlack85,
              )
            ],
            title: ShopperLocalizations(context)
                .localization
                .create_shopping_list),
        body: Form(
          key:formKey,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isSliver) {
              return [
                SliverToBoxAdapter(
                  child: ShopperCard(
                      child: _getTitleWidget(
                          title: ShopperLocalizations(context)
                              .localization
                              .assign_to,
                          child: AssignToWidget(assignKey)
                      )),
                ),
                SliverToBoxAdapter(
                  child: ShopperCard(
                    child: _getTitleWidget(
                        title: ShopperLocalizations(context).localization.title,
                        child: TextFormField(
                          maxLines: 2,
                          maxLength: 150,
                          validator: validateTextField,
                          onSaved: (value){
                            title= value;
                          },
                          decoration: InputDecoration(
                              hintText: ShopperLocalizations(context)
                                  .localization
                                  .hint_enter_title,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        )),
                  ),
                ),
                SliverToBoxAdapter(
                    child: ShopperCard(
                      child: _getTitleWidget(
                          title: ShopperLocalizations(context).localization.note,
                          child: TextFormField(
                            maxLines: 4,
                            maxLength: 250,
                            onChanged: (value){
                              note = value;
                            },
                            decoration: InputDecoration(
                                hintText: ShopperLocalizations(context)
                                    .localization
                                    .hint_note,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          )),
                    ))
              ];
            },
            body: ShopperCard(
              child: _getTitleWidget(
                  title: ShopperLocalizations(context).localization.checklist,
                  child: ListView.builder(
                    itemCount: taskList.length + 1,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == taskList.length) {
                        return ListTile(
                          trailing: IconButton(
                              icon: Icon(
                                Icons.add_circle_outline_rounded,
                                color: ShopperColor.appColorBlack65,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddTaskDialog(
                                      addCallback: (value) {
                                        _addTask(value);
                                      },
                                      cancelCallback: () {},
                                    );
                                  },
                                );
                              }),
                        );
                      } else {
                        return ListTile(
                          title: Text(
                            taskList.elementAt(index),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: ShopperTextStyles.subtitle1,
                          ),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: ShopperColor.appColorBlack65,
                              ),
                              onPressed: () {
                                _deleteFromChecklist(index);
                              }),
                        );
                      }
                    },
                  )),
            ),
          ),
        ),
      ),
    );
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

  void _deleteFromChecklist(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void _addTask(String value) {
    setState(() {
      taskList.add(value);
    });
  }

  void createTask() async{
    CreateTaskRequest payload = CreateTaskRequest();
    payload.userId = prefs.getString(Strings.userId);
    payload.familyId = prefs.getString(Strings.familyId);
    payload.assignTaskId = assignKey.currentState.getMemberId();
    payload.checkList = List<CheckList>.generate(taskList.length, (index) {return CheckList(task: taskList[index]);});
    payload.title= title;
    payload.subtitle = note;
    NetworkCall().call(jsonEncode(payload), context, AppUrl.taskCreate).then((value) {
      var res = CreateTaskResponse.fromJson(value);
      if(res.code == Strings.successCode){
        ToastAndSnackbar
            .showToast(ShopperLocalizations(context).localization.task_create_success,
            ShopperColor.information);
        Navigator.pop(context);
      }else{
        ToastAndSnackbar
            .showToast(ShopperLocalizations(context).localization.task_create_fail,
            ShopperColor.failure);
      }
    });
  }
}
