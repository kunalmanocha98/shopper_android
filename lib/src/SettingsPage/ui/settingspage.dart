import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/data_save.dart';
import 'package:shopper/src/HistoryPage/history_page_ui.dart';
import 'package:shopper/src/Registration/ui/login_page.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';

class SettingsPage extends StatefulWidget{
  @override
  _SettingsPage createState() => _SettingsPage();
}
class _SettingsPage extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Scaffold(
       appBar: ShopperAppbar.getSimpleAppbar(title: ShopperLocalizations(context).localization.settings),
       body: ListView(
         children: [
           ListTile(
             onTap: historyPage,
             leading: Icon(Icons.history),
             title: Text(
               ShopperLocalizations(context).localization.completed_tasks,
               style: ShopperTextStyles.subtitle2,
             ),
             subtitle: Text(
               ShopperLocalizations(context).localization.completed_task_des,
               style: ShopperTextStyles.bodyText2,
             ),
           ),
           ListTile(
             onTap: logout,
             leading: Icon(Icons.logout),
             title: Text(
              ShopperLocalizations(context).localization.logout,
               style: ShopperTextStyles.subtitle2,
             ),
             subtitle: Text(
               ShopperLocalizations(context).localization.logout_des,
               style: ShopperTextStyles.bodyText2,
             ),
           )
         ],
       ),
     ),
   );
  }


  void logout() {
    DataSaveUtil.clearAllData();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (BuildContext context){
          return LoginPage();
        }
    ),ModalRoute.withName('/'));
  }

  void historyPage() {
    Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context){
          return HistoryPage();
        }
    ));
  }
}