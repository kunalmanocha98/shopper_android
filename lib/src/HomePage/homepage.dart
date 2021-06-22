import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/data_save.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/CreateTaskPage/create_task_page_ui.dart';
import 'package:shopper/src/DashboardPage/dashboard_page_ui.dart';
import 'package:shopper/src/HistoryPage/history_page_ui.dart';
import 'package:shopper/src/Registration/ui/welcome_page.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex=0;
  List<Widget> _widgetOptions = [
    DashboardPage(),
    HistoryPage(),
  ];
  List<String> get _titleOptions => [
    ShopperLocalizations(context).localization.dashboard,
    ShopperLocalizations(context).localization.history
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
        ShopperAppbar.getSimpleAppbar(
            title: _titleOptions.elementAt(_selectedIndex),
          actions: [
            IconButton(
              icon: Icon(Icons.logout,),
              onPressed: (){
                DataSaveUtil.clearAllData();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context){
                      return WelcomePage();
                    }
                ),ModalRoute.withName('/'));
              },
            )
          ]
         ),
      
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: ShopperColor.appMainColor,
          notchMargin: 8.0,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(items: [
            BottomNavigationBarItem(
              label: ShopperLocalizations(context).localization.dashboard,
                icon: Icon(Icons.dashboard)),
            BottomNavigationBarItem(
                label:  ShopperLocalizations(context).localization.history,
                icon: Icon(Icons.history)),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return CreateTaskPage();
            }));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
  void _onItemTapped(int i){
    setState(() {
      _selectedIndex =i;
    });
  }
}
