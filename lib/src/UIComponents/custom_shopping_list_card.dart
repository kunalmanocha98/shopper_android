import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/DashboardPage/Models/task_list_models.dart';
import 'package:shopper/src/Dialogs/dialog_task_note.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class ShopperChecklistCard extends StatefulWidget {
  final TaskListItem data;
  final Function(String, int, bool) checkListCallback;
  final Function finishCallback;

  ShopperChecklistCard({
    @required this.data,
    @required this.checkListCallback,
    @required this.finishCallback,
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
          Row(
            children: [
              Expanded(
                  child: Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: ShopperTextStyles.subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogTaskNote(message: data.subtitle);
                        });
                  })
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.checkList.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.only(right: 12, left: 8),
                  title: Text(
                    data.checkList[index].task,
                    style: ShopperTextStyles.subtitle2,
                  ),
                  subtitle: data.checkList[index].description != null
                      ? Text(
                    data.checkList[index].description,
                    style: ShopperTextStyles.bodyText2,
                  )
                      : null,
                  value: data.checkList[index].isCompleted,
                  onChanged: (value) {
                    setState(() {
                      widget.checkListCallback(
                          data.checkList[index].sId, index, value);
                      data.checkList[index].isCompleted = value;
                    });
                  });
            },
          ),
          Row(
            children: [
              Text("${data.percentCompleted}% Completed"),
              Spacer(),
              ShopperElevatedButton(
                onPressed: () {
                  widget.finishCallback();
                  setState(() {
                    data.isHidden = true;
                  });
                },
                buttonText: ShopperLocalizations(context).localization.finish,
              ),
              SizedBox(
                width: 8,
              )
            ],
          )
        ],
      ),
    );
  }
}
