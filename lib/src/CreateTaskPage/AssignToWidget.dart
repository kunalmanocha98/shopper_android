import 'package:flutter/material.dart';
import 'package:shopper/src/BasicUtilities/custom_localizations.dart';
import 'package:shopper/src/BasicUtilities/custom_text_styles.dart';
import 'package:shopper/src/BasicUtilities/shopper_colors.dart';
import 'package:shopper/src/CreateTaskPage/Models/memberlist.dart';
import 'package:shopper/src/CreateTaskPage/assign_to_list_page.dart';

class AssignToWidget extends StatefulWidget{
  AssignToWidget(Key key):super(key: key);
  @override
  AssignToWidgetState createState() => AssignToWidgetState();
}
class AssignToWidgetState extends State<AssignToWidget>{
  FamilyMemberItem familyMember;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context){
            return AssignToListPage();
          })).then((value) {
            if(value!=null){
              setState(() {
                familyMember = value;
              });
            }
          });
        },
        contentPadding: EdgeInsets.all(0),
        // leading: ShopperAvatar(
        //   imageUrl: 'https://picsum.photos/id/237/200/300',
        // ),
        title:Text(familyMember!=null?familyMember.name:ShopperLocalizations(context)
            .localization
            .assign_to),
        subtitle: familyMember!=null?Text(familyMember.email,style: ShopperTextStyles.bodyText2,):null,
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: ShopperColor.appColorBlack65,
        ),
      ),
    );
  }

  String getMemberId(){
    if(familyMember!=null){
      return familyMember.sId;
    }else{
      return null;
    }
  }

}