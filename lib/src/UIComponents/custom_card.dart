import 'package:flutter/material.dart';
import 'package:shopper/src/UIComponents/shdow_components.dart';

class ShopperCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function onTap;
  final Color color;
  final double borderRadius;

  ShopperCard({
    @required this.child,
    this.margin = const EdgeInsets.only(left: 8, right: 8.0, top: 6.0, bottom: 6.0),
    this.padding = const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
    this.onTap,
    this.color =  Colors.white,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [ShadowComponents.shadowBlur6],
      ),
      margin: margin,
      padding: EdgeInsets.all(0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        margin: EdgeInsets.all(0),
        color: color,
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
