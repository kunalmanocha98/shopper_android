import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/UIComponents/custom_appbar.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

class CreateFamilyPage extends StatefulWidget{
  @override
  CreateFamilyPageState createState() => CreateFamilyPageState();
}
class CreateFamilyPageState extends State<CreateFamilyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopperAppbar.getSimpleAppbar(title: 'Create a Family'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: ShopperTextStyles.subtitle1,
              decoration: InputDecoration(
                  hintStyle: ShopperTextStyles.caption,
                  hintText: ShopperLocalizations(context).localization.hint_enter_family_user_name
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: ShopperTextStyles.subtitle1,
              decoration: InputDecoration(
                  hintStyle: ShopperTextStyles.caption,
                  hintText: ShopperLocalizations(context).localization.hint_enter_family_name
              ),
            ),
          ),
          ShopperElevatedButton(onPressed: (){},
            textColor: ShopperColor.appColorWhite,
            buttonText: ShopperLocalizations(context).localization.register_family,)
        ],
      ),
    );
  }

}