import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';

class ShadowComponents {
  static BoxShadow get shadowBlur6{
    return BoxShadow(
      color:  ShopperColor.appColorBlack08,
      offset: Offset(0, 3),
      blurRadius: 6,
    );
  }

  static BoxShadow get shadowBlur3{
    return BoxShadow(
      color:  ShopperColor.appColorBlack08,
      offset: Offset(0, 1),
      blurRadius: 3,
    );
  }
}