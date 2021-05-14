import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/UIComponents/custom_dialog.dart';

class DialogTaskNote extends StatelessWidget{
  final String message;
  DialogTaskNote({@required this.message});
  @override
  Widget build(BuildContext context) {
    return ShopperDialog(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Note',style: ShopperTextStyles.headline6.copyWith(
            fontWeight: FontWeight.bold
          ),),
          Text(message,style: ShopperTextStyles.subtitle1,)
        ],
      ),
    );
  }

}