import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShopperAvatar extends StatelessWidget{
  final double size;
  final String imageUrl;
  ShopperAvatar({this.size = 52.0,@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
   return ClipOval(
     child: CachedNetworkImage(
       imageUrl: imageUrl,
       width: size,
       height: size,
       fit: BoxFit.cover,
     ),
   );
  }

}