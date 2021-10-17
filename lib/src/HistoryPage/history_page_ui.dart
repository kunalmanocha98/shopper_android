import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/paginator.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/DashboardPage/Models/task_list_models.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_shopping_list_card.dart';

class HistoryPage extends StatefulWidget{

  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage>{
  SharedPreferences prefs = locator<SharedPreferences>();
  List<TaskListItem> itemsList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ShopperAppbar.getSimpleAppbar(title: ShopperLocalizations(context).localization.history),
        body: Paginator<TaskListResponse>.listView(
          pageLoadFuture: fetchData,
          pageItemsGetter: listItemsGetter,
          listItemBuilder: listItemBuilder,
          loadingWidgetBuilder: CustomPaginator(context).loadingWidgetMaker,
          errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
          emptyListWidgetBuilder: CustomPaginator(context).emptyListWidgetMaker,
          totalItemsGetter: CustomPaginator(context).totalPagesGetter,
          pageErrorChecker: CustomPaginator(context).pageErrorChecker,
        ),
      ),
    );
  }

  Future<TaskListResponse> fetchData(int page) async {
    TaskListRequest payload = TaskListRequest();
    payload.familyId = prefs.getString(Strings.familyId);
    payload.page = page;
    payload.pageSize = 10;
    var value =
    await NetworkCall().call(jsonEncode(payload), context, AppUrl.historyList);
    return TaskListResponse.fromJson(value);
  }
  List<TaskListItem> listItemsGetter(TaskListResponse pageData) {
    itemsList.addAll(pageData.results);
    return pageData.results;
  }
  Widget listItemBuilder(itemData, int index) {
    TaskListItem item = itemData;
    return ShopperChecklistCard(
      data: item,
      isHistory:true,
      checkListCallback: (String id, int idx, bool value){
        // itemsList[index].checkList[idx].isCompleted = value;
      },
      finishCallback:(){

      },
    );
  }

}