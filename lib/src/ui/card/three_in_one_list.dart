import 'package:flutter/material.dart';

Widget threeInOneList(double width, List<Widget> widgets){
  List<Widget> list = [];
  Widget? w1;
  Widget? w2;
  Widget? w3;
  for (var item in widgets){
    if (w1 == null){
      w1 = item;
      continue;
    }
    if (w2 == null){
      w2 = item;
      continue;
    }
    if (w3 == null){
      w3 = item;
      continue;
    }
    list.add(Column(
      children: [
        w1,
        SizedBox(height: 15,),
        w2,
        SizedBox(height: 15,),
        w3
      ],
    ));
    w1 = null;
    w2 = null;
    w3 = null;
    list.add(SizedBox(width: 20,));
  }
  if (w1 != null){
    list.add(Column(
      children: [
        w1,
        SizedBox(height: 15,),
        if (w2 != null)
          w2,
        SizedBox(height: 15,),
        if (w3 != null)
          w3
      ],
    ));
  }
  return Container(
    height: width*0.2*3+30,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: list,
    ),
  );
}