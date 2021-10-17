import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopper/Network/app_url.dart';
import 'package:shopper/Network/network.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/paginator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/BasicUtilities/string_constant.dart';
import 'package:shopper/src/BasicUtilities/toast.dart';
import 'package:shopper/src/Registration/models/family_models.dart';
import 'package:shopper/src/Registration/models/signup_model.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';

import 'create_family_page.dart';
import 'login_page.dart';

class FamilyListPage extends StatefulWidget {
  final SignUpRequest signUpData;
  FamilyListPage({this.signUpData});
  @override
  FamilyListPageState createState() => FamilyListPageState();
}

class FamilyListPageState extends State<FamilyListPage> {
  GlobalKey<PaginatorState> paginatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopperAppbar.getSimpleAppbar(
          title: ShopperLocalizations(context).localization.families,
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CreateFamilyPage();
                  })).then((value) {
                    if(value!=null){
                      if(value){
                        refreshList();
                      }
                    }
                  });
                })
          ]),
      body: Paginator<FamilyListResponse>.listView(
        key: paginatorKey,
        pageLoadFuture: fetchList,
        pageItemsGetter: CustomPaginator(context).listItemsGetter,
        listItemBuilder: listItemBuilder,
        loadingWidgetBuilder: CustomPaginator(context).loadingWidgetMaker,
        errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
        emptyListWidgetBuilder: CustomPaginator(context).emptyListWidgetMaker,
        totalItemsGetter: CustomPaginator(context).totalPagesGetter,
        pageErrorChecker: CustomPaginator(context).pageErrorChecker,
      ),
    );
  }

  void refreshList(){
    paginatorKey.currentState.changeState(resetState: true);
  }

  Future<FamilyListResponse> fetchList(int page) async {
    FamilyListRequest payload = FamilyListRequest();
    payload.page = page;
    payload.pageSize = 25;
    var response = await NetworkCall().call(jsonEncode(payload), context, AppUrl.familyList,withToken: false);
    return FamilyListResponse.fromJson(response);
  }

  Widget listItemBuilder(itemData, int index) {
    FamilyListItem item = itemData;
    return InkWell(
      onTap: (){
        signUp(item);
      },
      child: ListTile(
        title: Text(
          item.familyName,
          style: ShopperTextStyles.subtitle1,
        ),
        subtitle: Text(
          item.familyUserName,
          style: ShopperTextStyles.bodyText2,
        ),
      ),
    );
  }

  void signUp(FamilyListItem item) async{
    widget.signUpData.familyId = item.sId;
    NetworkCall().call(jsonEncode(widget.signUpData), context, AppUrl.signUp,withToken: false).then((value){
      var res = SignUpResponse.fromJson(value);
      if(res.code == Strings.successCode){
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return LoginPage();
            }), ModalRoute.withName('/'));
      }else{
        ToastAndSnackbar.showToast(res.message, ShopperColor.failure);
      }
    });
  }
}
