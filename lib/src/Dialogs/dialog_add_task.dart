import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_mixins.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';

class AddTaskDialog extends StatelessWidget with ShopperMixins {
  final Function(String) addCallback;
  final Function cancelCallback;
  String task;
  GlobalKey<FormState> formKey = GlobalKey();

  AddTaskDialog({this.addCallback, this.cancelCallback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ShopperLocalizations(context).localization.add_task,
                  style: ShopperTextStyles.headline6,
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                validator: validateTextField,
                onSaved: (value) {
                  task = value;
                },
                maxLines: 4,
                maxLength: 250,
                decoration: InputDecoration(
                    hintText: ShopperLocalizations(context)
                        .localization
                        .hint_enter_task,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Spacer(),
                    ShopperOutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        cancelCallback();
                      },
                      buttonText:
                          ShopperLocalizations(context).localization.cancel,
                    ),
                    SizedBox(width: 8,),
                    ShopperElevatedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          Navigator.pop(context);
                          addCallback(task);
                        }
                      },
                      buttonText: ShopperLocalizations(context).localization.add,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
