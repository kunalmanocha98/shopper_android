import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/CreateTaskPage/create_task_page_ui.dart';
import 'package:shopper/src/DashboardPage/dashboard_page_ui.dart';
import 'package:shopper/src/SettingsPage/ui/settingspage.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<DashboardPageState> dashboardKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
        ShopperAppbar.getSimpleAppbar(title: ShopperLocalizations(context).localization.tasklist,
          centerTitle: false,
          leadingIconVisible: false,
          actions: [
            IconButton(
              icon: Icon(Icons.settings,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(BuildContext context){
                  return SettingsPage();
                }));
              },
            )
          ]
         ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return CreateTaskPage();
            })).then((value) {
              if(value!=null && value){
                dashboardKey.currentState.refresh();
              }
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          backgroundColor: ShopperColor.appMainColor,
          tooltip: ShopperLocalizations(context).localization.create_task,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body:  DashboardPage(dashboardKey),
      ),
    );
  }
}
