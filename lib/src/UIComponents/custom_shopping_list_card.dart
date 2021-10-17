import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/DashboardPage/Models/change_status.dart';
import 'package:shopper/src/DashboardPage/Models/checklist_models.dart';
import 'package:shopper/src/DashboardPage/Models/task_list_models.dart';
import 'package:shopper/src/DashboardPage/enums/task_status.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class ShopperChecklistCard extends StatefulWidget {
  final TaskListItem data;
  final Function(String, int, bool) checkListCallback;
  final Function finishCallback;
  final bool isHistory;

  ShopperChecklistCard({
    @required this.data,
    @required this.checkListCallback,
    @required this.finishCallback,
    @required this.isHistory,
  });

  @override
  _ShopperChecklistCard createState() => _ShopperChecklistCard(data: data);
}

class _ShopperChecklistCard extends State<ShopperChecklistCard> {
  TaskListItem data;

  _ShopperChecklistCard({this.data});

  @override
  Widget build(BuildContext context) {
    return (data.isHidden!=null && data.isHidden)?
        Container()
        :ShopperCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.title,
                style: ShopperTextStyles.headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Visibility(
                visible: data.subtitle!=null && data.subtitle.isNotEmpty,
                child: Text(
                  data.subtitle ?? "",
                  style: ShopperTextStyles.bodyText2
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(height: 8,),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 2,right: 2),
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.checkList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                      contentPadding: EdgeInsets.only(right: 8, left: 4),
                      title: Text(
                        data.checkList[index].task,
                        style: ShopperTextStyles.subtitle2.copyWith(
                          decoration: data.checkList[index].isCompleted?
                          TextDecoration.lineThrough:
                              TextDecoration.none
                        ),
                      ),
                      subtitle: data.checkList[index].description != null
                          ? Text(
                        data.checkList[index].description,

                        style: ShopperTextStyles.bodyText2.copyWith(
                        ),
                      )
                          : null,
                      value: data.checkList[index].isCompleted,
                      onChanged: (value) {
                        if(!widget.isHistory) {
                          checkListUpdate(index, value);
                        }
                      });
                },
              ),
              Visibility(
                visible: !widget.isHistory,
                child: Container(
                  width: double.infinity,
                  child: ShopperElevatedButton(
                    onPressed: () {
                      changeStatus();
                    },
                    buttonText: ShopperLocalizations(context).localization.mark_as_completed,
                  ),
                ),
              )
            ],
          ),
        );
  }

  void checkListUpdate(int index, bool isCompleted) async{
    CheckListUpdateRequest payload  = CheckListUpdateRequest();
    payload.isCompleted = isCompleted;
    payload.checklistId = data.checkList[index].sId;
    payload.taskId = data.sId;
    NetworkCall().call(jsonEncode(payload), context, AppUrl.checkListUpdate).then((value) {
      var response  = CheckListUpdateResponse.fromJson(value);
      if(response.code == Strings.successCode){
        setState(() {
          widget.checkListCallback(data.checkList[index].sId, index, isCompleted);
          data.checkList[index].isCompleted = isCompleted;
          if(response.results!=null && response.results.isCompleted){
            widget.finishCallback();
            data.isHidden = true;
          }
        });
      }
    });
  }

  void changeStatus() async{
    ChangeStatusRequest payload = ChangeStatusRequest();
    payload.taskId = data.sId;
    payload.status = TaskStatus.COMPLETED.type;
    NetworkCall().call(jsonEncode(payload),context,AppUrl.changeStatus).then((value){
      var response = ChangeStatusResponse.fromJson(value);
      if(response.code == Strings.successCode){
        setState(() {
          widget.finishCallback();
          data.isHidden = true;
        });
      }
    });
  }
}


