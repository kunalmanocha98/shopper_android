import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/paginator.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/DashboardPage/Models/task_list_models.dart';
import 'package:shopper/src/UIComponents/custom_shopping_list_card.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage(Key key):super(key: key);
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  SharedPreferences prefs = locator<SharedPreferences>();
  List<TaskListItem> itemsList = [];
  GlobalKey<PaginatorState> paginatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Paginator<TaskListResponse>.listView(
      key: paginatorKey,
      padding: EdgeInsets.only(bottom: 100),
      pageLoadFuture: fetchData,
      pageItemsGetter: listItemsGetter,
      listItemBuilder: listItemBuilder,
      loadingWidgetBuilder: CustomPaginator(context).loadingWidgetMaker,
      errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
      emptyListWidgetBuilder: CustomPaginator(context).emptyListWidgetMaker,
      totalItemsGetter: CustomPaginator(context).totalPagesGetter,
      pageErrorChecker: CustomPaginator(context).pageErrorChecker,
    );
  }

  Future<TaskListResponse> fetchData(int page) async {
    TaskListRequest payload = TaskListRequest();
    payload.familyId = prefs.getString(Strings.familyId);
    payload.page = page;
    payload.pageSize = 10;
    var value =
    await NetworkCall().call(jsonEncode(payload), context, AppUrl.taskList);
    return TaskListResponse.fromJson(value);
  }
  List<TaskListItem> listItemsGetter(TaskListResponse pageData) {
    itemsList.addAll(pageData.results);
    return pageData.results;
  }
  Widget listItemBuilder(itemData, int index) {
    TaskListItem item = itemData;
    return ShopperChecklistCard(
      isHistory:false,
      data: item,
      checkListCallback: (String id, int idx, bool value){
        // itemsList[index].checkList[idx].isCompleted = value;
      },
      finishCallback:(){

      },
    );
  }

  void refresh() {
    paginatorKey.currentState.changeState(resetState: true);
  }


}
