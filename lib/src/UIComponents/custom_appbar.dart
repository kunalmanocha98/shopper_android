import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';

class ShopperAppbar{
  static Widget getSimpleAppbar({@required String title,List<Widget> actions }) => AppBar(
    title: Text(title,style: ShopperTextStyles.headline6,),
    centerTitle: false,
    actions: actions,
  );
}