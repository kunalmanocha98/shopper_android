import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';

class ShopperTextButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color textColor;

  ShopperTextButton(
      {@required this.onPressed, this.buttonText, this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText ??
              ShopperLocalizations(context).localization.button_placeholder,
          style: ShopperTextStyles.caption
              .copyWith(color: textColor ?? ShopperColor.appMainColor),
        ));
  }
}

class ShopperElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color textColor;
  final TextStyle textStyle;
  final EdgeInsets padding;

  ShopperElevatedButton({
    @required this.onPressed,
    this.buttonText,
    this.textColor,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    var style = textStyle ?? ShopperTextStyles.caption;
    return ElevatedButton(
        onPressed: onPressed,

        child: Padding(
          padding: padding ?? EdgeInsets.all(0.0),
          child: Text(
            buttonText ??
                ShopperLocalizations(context).localization.button_placeholder,
            style:
                style.copyWith(color: textColor ?? ShopperColor.appColorWhite),
          ),
        ));
  }
}

class ShopperOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color textColor;

  ShopperOutlinedButton(
      {@required this.onPressed, this.buttonText, this.textColor});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        child: Text(
          buttonText ??
              ShopperLocalizations(context).localization.button_placeholder,
          style: ShopperTextStyles.caption
              .copyWith(color: textColor ?? ShopperColor.appMainColor),
        ));
  }
}

class ShopperAppBarActionTextButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final Color textColor;

  ShopperAppBarActionTextButton(
      {@required this.onPressed, this.buttonText, this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          buttonText ??
              ShopperLocalizations(context).localization.button_placeholder,
          style: ShopperTextStyles.caption
              .copyWith(color: textColor ?? ShopperColor.appMainColor),
        ));
  }
}
