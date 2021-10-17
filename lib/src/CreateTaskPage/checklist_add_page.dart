import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/CreateTaskPage/Models/create_task_models.dart';
import 'package:shopper/src/CreateTaskPage/assign_to_list_page.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class AddCheckListPage extends StatefulWidget{
  final CreateTaskRequest payload;
  AddCheckListPage({this.payload});
  @override
  _AddCheckListPage createState()=> _AddCheckListPage();
}
class _AddCheckListPage extends State<AddCheckListPage>{
  List<String> taskList = [];
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          appBar: ShopperAppbar.getSimpleAppbar(title: ShopperLocalizations(context).localization.add_checklist,
          actions: [
            ShopperTextButton(
              onPressed: (){
                if (taskList.length > 0) {
                  proceed();
                } else {
                  ToastAndSnackbar.showToast(
                      ShopperLocalizations(context)
                          .localization
                          .task_create_error,
                      ShopperColor.failure);
                }
              },
              buttonText: ShopperLocalizations(context).localization.next,
              textColor: ShopperColor.appColorWhite,
            )
          ]),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: ShopperCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: taskController,
                            decoration: InputDecoration(
                              hintText: ShopperLocalizations(context).localization.hint_enter_task
                            ),
                          ),
                        ),
                        ShopperElevatedButton(
                          onPressed: (){
                            if(taskController.text.isNotEmpty){
                              _addTask(taskController.text);
                            }
                          },
                          buttonText: ShopperLocalizations(context).localization.add,
                          textColor: ShopperColor.appColorWhite,
                        )
                      ],
                    ),
                  ),
                )
              ];
            },
            body: ShopperCard(
              padding: EdgeInsets.all(4),
              child:ListView.builder(
                    itemCount: taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${index+1}. ",
                                maxLines: 2,
                                style: ShopperTextStyles.headline6,
                              ),
                              Text(
                                "${taskList[index]}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: ShopperTextStyles.subtitle1.copyWith(
                                  color: ShopperColor.appColorBlack65
                                ),
                              ),
                            ],
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
                    },
                  )),
            ),
          ),
    );
  }
  void _deleteFromChecklist(int index) {
    setState(() {
      taskList.removeAt(index);
    });
  }

  void _addTask(String value) {
    setState(() {
      taskController.text ="";
      taskList.add(value);
    });
  }

  void proceed() {
    widget.payload.checkList =  List<CheckList>.generate(taskList.length, (index) {
      return CheckList(task: taskList[index]);
    });
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return AssignToListPage(payload: widget.payload);
        }
    )).then((value) {
      if(value!=null && value){
        Navigator.pop(context,true);
      }
    });
  }

}