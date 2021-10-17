import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/locator.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopper/src/SpalshPage/splashPage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  GetIt.I.isReady<SharedPreferences>().then((value){
    runApp(MyApp());
  });
}
var color = MaterialColor(0xFF188dee, {
  50:ShopperColor.appMainColor.withOpacity(0.1),
  100:ShopperColor.appMainColor.withOpacity(0.2),
  200:ShopperColor.appMainColor.withOpacity(0.3),
  300:ShopperColor.appMainColor.withOpacity(0.4),
  400:ShopperColor.appMainColor.withOpacity(0.5),
  500:ShopperColor.appMainColor.withOpacity(0.6),
  600:ShopperColor.appMainColor.withOpacity(0.7),
  700:ShopperColor.appMainColor.withOpacity(0.8),
  800:ShopperColor.appMainColor.withOpacity(0.9),
  900:ShopperColor.appMainColor.withOpacity(1),
});

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frisk Shopper',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: color,
        fontFamily: 'Raleway',
        scaffoldBackgroundColor: ShopperColor.appBackgroundColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: ShopperColor.appColorWhite,
            size: 20
          ),
          iconTheme:  IconThemeData(
              color: ShopperColor.appColorWhite,
              size: 20
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            primary: ShopperColor.appMainColor,
          )
        ),
        elevatedButtonTheme:  ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              primary: ShopperColor.appMainColor,
            )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
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
      home: SplashPage(),
    );
  }
}

