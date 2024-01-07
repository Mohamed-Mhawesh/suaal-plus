import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:suaal_plus/controllers/create_group_controller.dart';
import '../../controllers/groups_controller.dart';

import '../../theme/constants.dart';


GroupsController controller=Get.find();

class GroupChoiceChip extends StatelessWidget {
  final String process;
  final String chipText;
  final int chipId;

  GroupChoiceChip({
    Key? key,
    required this.chipText,
    required this.chipId, required this.process,
  }) : super(key: key);

  Color chosenColor(String process,int chipId){
    switch (process){
      case "gr":{if(controller.chosenGroupsFilter==chipId){return kPrimaryColor;}else{return Colors.white;}}
      default: {return Colors.white;}
    }
  }
  Color chosenTextColor(String process,int chipId){
    switch (process){
      case "gr":{if(controller.chosenGroupsFilter==chipId){return Colors.white;}else{return kPrimaryColor;}}
      default: {return Colors.white;}
    }
  }

  GroupsController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        controller.choose(process, chipId);
      },
      child: Container(
        height: size.height*0.05,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(0, 2)),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 0,
                offset: Offset(2, 0)),
          ],
          color: chosenColor(process, chipId) ,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        margin: EdgeInsets.only(top: size.height * 0.01,bottom: size.height * 0.014,right: size.width * 0.01,left: size.width * 0.01),
        child: Center(
            child: Text(
              chipText,
              style: TextStyle(
                  fontSize: 12.sp,
                  color:  chosenTextColor(process, chipId),
                  fontWeight: FontWeight.bold
              ),
            )),
      ),
    );

  }

}