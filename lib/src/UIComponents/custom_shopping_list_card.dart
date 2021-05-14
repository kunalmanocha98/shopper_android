import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/Dialogs/dialog_task_note.dart';
import 'package:shopper/src/UIComponents/custom_buttons.dart';
import 'package:shopper/src/UIComponents/custom_card.dart';

class ShopperChecklistCard extends StatefulWidget {
  @override
  _ShopperChecklistCard createState() => _ShopperChecklistCard();
}

class _ShopperChecklistCard extends State<ShopperChecklistCard> {
  List<bool> listBoolTest = List<bool>.generate(5, (index) {
    return index.isEven;
  });

  @override
  Widget build(BuildContext context) {
    return ShopperCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                'Shopping for manocha house',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: ShopperTextStyles.subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              )),
              IconButton(
                  icon: Icon(Icons.info_outline_rounded), onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return DialogTaskNote(message:'please bring all the items quickly and efficiently');
                      }
                    );
              })
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listBoolTest.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.only(right: 12,left: 8),
                title: Text('Refrigerator',style: ShopperTextStyles.subtitle2,),
                  subtitle: Text('Bring a two door refrigerator',style: ShopperTextStyles.bodyText2,),
                  value: listBoolTest.elementAt(index),
                  onChanged: (value) {
                    setState(() {
                      listBoolTest[index] = value;
                    });
                  });
            },
          ),
          Row(
            children: [
              Text("0 out of 5"),
              Spacer(),
              ShopperElevatedButton(onPressed: (){},buttonText: 'finish',),
              SizedBox(width: 8,)
            ],
          )
        ],
      ),
    );
  }
}
