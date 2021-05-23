import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/Dialogs/dialog_add_task.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_avatar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPage createState() => _CreateTaskPage();
}

class _CreateTaskPage extends State<CreateTaskPage> {
  List<String> taskList =[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ShopperAppbar.getSimpleAppbar(
          actions: [
            ShopperAppBarActionTextButton(
              onPressed: (){},
              buttonText: ShopperLocalizations(context).localization.create,
              textColor: ShopperColor.appColorBlack85,
            )
          ],
            title: ShopperLocalizations(context)
                .localization
                .create_shopping_list),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isSliver) {
            return [
              SliverToBoxAdapter(
                child: ShopperCard(
                  onTap: (){},
                    child: _getTitleWidget(
                        title: ShopperLocalizations(context)
                            .localization
                            .assign_to,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: ShopperAvatar(
                            imageUrl: 'https://picsum.photos/id/237/200/300',
                          ),
                          title: Text(ShopperLocalizations(context)
                              .localization
                              .assign_to),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: ShopperColor.appColorBlack65,
                          ),
                        ))),
              ),
              SliverToBoxAdapter(
                child: ShopperCard(
                  child: _getTitleWidget(
                      title: ShopperLocalizations(context).localization.title,
                      child: TextFormField(
                        maxLines: 2,
                        maxLength: 150,
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
                  itemCount: taskList.length+1,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if(index == taskList.length){
                      return ListTile(
                        trailing: IconButton(
                            icon: Icon(
                              Icons.add_circle_outline_rounded,
                              color: ShopperColor.appColorBlack65,
                            ),
                            onPressed: () {
                              showDialog(context: context,
                                builder: (BuildContext context) {
                                return AddTaskDialog(
                                  addCallback: (value){
                                    _addTask(value);
                                  },
                                  cancelCallback: (){

                                  },
                                );
                                },
                              );
                            }),
                      );
                    }else {
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
        child
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
}
