import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';

class HistoryPage extends StatefulWidget{

  @override
  _HistoryPage createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(ShopperLocalizations(context).localization.history),
      ),
    );
  }

}