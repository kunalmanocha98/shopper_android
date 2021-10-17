import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';

class ShopperAppbar{
  static Widget getSimpleAppbar({@required String title,List<Widget> actions,bool leadingIconVisible= true, bool centerTitle= true }) => AppBar(
    title: Text(title,style: ShopperTextStyles.headline6.copyWith(
      fontWeight: FontWeight.bold,
      color: ShopperColor.appColorWhite
    ),),
    automaticallyImplyLeading: leadingIconVisible,
    centerTitle: centerTitle,
    actions: actions,
  );
}