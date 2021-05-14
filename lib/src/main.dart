import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/HomePage/homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Registration/signup_page.dart';

void main() {
  runApp(MyApp());
}
var color = MaterialColor(0xFF00BCD4, {
  50:Color.fromRGBO(0, 188, 212, 0.1),
  100:Color.fromRGBO(0, 188, 212, 0.2),
  200:Color.fromRGBO(0, 188, 212, 0.3),
  300:Color.fromRGBO(0, 188, 212, 0.4),
  400:Color.fromRGBO(0, 188, 212, 0.5),
  500:Color.fromRGBO(0, 188, 212, 0.6),
  600:Color.fromRGBO(0, 188, 212, 0.7),
  700:Color.fromRGBO(0, 188, 212, 0.8),
  800:Color.fromRGBO(0, 188, 212, 0.9),
  900:Color.fromRGBO(0, 188, 212, 1),
});

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frisk Shopper',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: color,
        fontFamily: 'Source Sans Pro',
        scaffoldBackgroundColor: ShopperColor.appBackgroundColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: ShopperColor.appColorBlack85,
            size: 20
          ),
          iconTheme:  IconThemeData(
              color: ShopperColor.appColorBlack85,
              size: 20
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
            primary: ShopperColor.appMainColor,
          )
        ),
        elevatedButtonTheme:  ElevatedButtonThemeData(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              primary: ShopperColor.appMainColor,
            )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              primary: ShopperColor.appMainColor,
            )
        ),
        textTheme: TextTheme(
          headline1: ShopperTextStyles.headline1,
          headline2: ShopperTextStyles.headline2,
          headline3: ShopperTextStyles.headline3,
          headline4: ShopperTextStyles.headline4,
          headline5: ShopperTextStyles.headline5,
          headline6: ShopperTextStyles.headline6,
          subtitle1: ShopperTextStyles.subtitle1,
          subtitle2:ShopperTextStyles.subtitle2,
          bodyText1: ShopperTextStyles.bodyText1,
          bodyText2: ShopperTextStyles.bodyText2,
          button: ShopperTextStyles.button,
          caption:ShopperTextStyles.caption,
          overline:ShopperTextStyles.overline,
        ),
      ),
      // home: HomePage(),
      home: SignupPage(),
    );
  }
}

