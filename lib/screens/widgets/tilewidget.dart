import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final String itemname;
  final String itemvalue;
  const TileWidget({super.key, required this.itemname, required this.itemvalue});
  

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$itemname : ',style:const TextStyle(fontSize: 20),),
                Text(itemvalue,style:const TextStyle(fontSize: 20),),
              ],
      ),
    );
  }
}