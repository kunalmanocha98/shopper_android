import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopperDialog extends StatelessWidget{
  final Widget child;
  final EdgeInsets padding;
  ShopperDialog({@required this.child,this.padding});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(0),
          child: child),
    );
  }

}