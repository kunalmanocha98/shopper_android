import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/paginator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/CreateTaskPage/Models/create_task_models.dart';
import 'package:shopper/src/CreateTaskPage/Models/memberlist.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';

class AssignToListPage extends StatefulWidget {
  final CreateTaskRequest payload;
  AssignToListPage({this.payload});
  @override
  AssignListState createState() => AssignListState();
}

class AssignListState extends State<AssignToListPage> {
  SharedPreferences prefs = locator<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: ShopperAppbar.getSimpleAppbar(
              title: ShopperLocalizations(context).localization.assign_to),
          body: Paginator<FamilyMembersListResponse>.listView(
            pageLoadFuture: fetchData,
            pageItemsGetter: CustomPaginator(context).listItemsGetter,
            listItemBuilder: listItemBuilder,
            loadingWidgetBuilder: CustomPaginator(context).loadingWidgetMaker,
            errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
            emptyListWidgetBuilder: CustomPaginator(context).emptyListWidgetMaker,
            totalItemsGetter: CustomPaginator(context).totalPagesGetter,
            pageErrorChecker: CustomPaginator(context).pageErrorChecker,
          ),
        ));
  }

  Future<FamilyMembersListResponse> fetchData(int page) async{
    var body = jsonEncode({
      "page":page,
      "page_size":10,
      "family_id":prefs.getString(Strings.familyId)
    });
    var value = await NetworkCall().call(body, context, AppUrl.familyMembers);
    return FamilyMembersListResponse.fromJson(value);
  }

  Widget listItemBuilder(itemData, int index) {
    FamilyMemberItem item = itemData;
    return ListTile(
      onTap: (){
       createTask(item);
      },
      title: Text(
        item.name,
        style: ShopperTextStyles.subtitle1,
      ),
      subtitle: Text(
        item.email,
        style: ShopperTextStyles.bodyText2,
      ),
    );
  }
  void createTask(FamilyMemberItem item) async {
    widget.payload.assignTaskId = item.sId;
    NetworkCall()
        .call(jsonEncode(widget.payload), context, AppUrl.taskCreate)
        .then((value) {
      var res = CreateTaskResponse.fromJson(value);
      if (res.code == Strings.successCode) {
        ToastAndSnackbar.showToast(
            ShopperLocalizations(context).localization.task_create_success,
            ShopperColor.information);
        Navigator.pop(context,true);
      } else {
        ToastAndSnackbar.showToast(
            ShopperLocalizations(context).localization.task_create_fail,
            ShopperColor.failure);
      }
    });
  }
}
