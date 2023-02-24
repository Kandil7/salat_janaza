
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:intl/intl.dart';
import 'package:salat_janaza/cubit/cubit.dart';
item(){
  return Stack(

    children: [
      Container(
          padding: EdgeInsets.all(10
          ),
          width: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Text('بعد التكبيرة الأولى تقرأ الفاتحة.',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),)
      ),

      Positioned(
        top:0,
        right: 0,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
          child: Text('1',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),


          ),
        ),
      ),
    ],
  );
}
List<Widget> markers=[
  TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'open_street_map_search_and_pick',
    subdomains: ['a', 'b', 'c'],


  ),


];



Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
}){
  return AlertDialog(
    title: Text('$title',),
    titlePadding: EdgeInsetsDirectional.only(start:13,top: 15 ),
    content: Text('$content',),
    elevation: 8,
    contentPadding: EdgeInsets.all(15),
    actions: [
      OutlinedButton(
          onPressed: (){
            Navigator.of(context).pop(false);
          },
          child: Text('$outlinedButtonText')
      ),
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueAccent)) ,
          onPressed: (){
            Navigator.of(context).pop(true);
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(elevatedButtonIcon),
              SizedBox(width: 5,),
              Text('$elevatedButtonText',style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    ],

  );
}



