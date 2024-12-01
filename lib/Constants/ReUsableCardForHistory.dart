import 'package:bmicalculator/Hive/UserData.dart';
import 'package:flutter/material.dart';

class ReUsableCardForHistory extends StatelessWidget {
   final UserData data;
   const ReUsableCardForHistory({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Col1
          Column(
            children: [
               Text(data.bmi.toString(),style: const TextStyle(fontSize: 27,color: Colors.white,fontWeight: FontWeight.bold),),
               Text(data.bmicategory,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold))
            ],
          ),

          /// Col2
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(data.date.toString(),style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}