import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String labelText;
  final bool obscureText;
  final String Function(String) validator;
  final Function(String) onSaved;
  final TextEditingController controller;
  final TextInputType keyboardType;

  CustomTextField({
    this.hint = "",
    this.labelText = "",
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ShopperColor.appColorWhite,
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        onSaved: onSaved,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: hint,
            contentPadding:
            EdgeInsets.only(left: 12, top: 16, bottom: 8),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(12)),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: labelText),
      ),
    );
  }

}