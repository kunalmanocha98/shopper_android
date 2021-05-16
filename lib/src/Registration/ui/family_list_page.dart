import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';

import 'create_family_page.dart';

class FamilyListPage extends StatefulWidget {
  @override
  FamilyListPageState createState() => FamilyListPageState();
}

class FamilyListPageState extends State<FamilyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopperAppbar.getSimpleAppbar(
        title: 'Family List',
        actions: [IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return CreateFamilyPage();
                }
              ));
            })]
      ),
      body: PaginationView<String>(
        pageFetch: fetchList,
        itemBuilder: (BuildContext content, String string, int index) {
          return ListTile(
            title: Text(
              string,
              style: ShopperTextStyles.subtitle1,
            ),
            subtitle: Text(
              "this is a family",
              style: ShopperTextStyles.bodyText2,
            ),
          );
        },
        onEmpty: Center(child: Text("Empty")),
        onError: (value) {
          print(value.toString());
          return Text("Error");
        },
      ),
    );
  }

  Future<List<String>> fetchList(int page) {
    var list = List<String>.generate(20, (index) => "item$index");
    return page == 0 ? Future.value(list) : Future.value([]);
  }
}
