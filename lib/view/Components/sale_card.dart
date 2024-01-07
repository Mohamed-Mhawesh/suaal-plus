import 'package:flutter/material.dart';
import 'package:suaal_plus/view/Components/simple_shadow.dart';

import '../../theme/constants.dart';

class SaleCard extends StatelessWidget {
  const SaleCard({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SimpleShadow(
color:const Color(0xff2F80ED),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.02),
       clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          color: kPrimaryColor,
          child: Row(
            children: [
              Container(

                height: size.height*0.1,
                  margin: EdgeInsets.symmetric(vertical: size.height*0.005,horizontal: size.width*0.04),
                  width: size.width*0.8,
                  child: const Text("دورة احترافية في التصميم مقدمة من معهد آسيا دورة احترافية في التصميم مقدمة من معهد آسيا",style: TextStyle(
                      height:1.2,fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),)),
            ],
          ),
        ),),

    );
  }
}
